#!/usr/bin/env python

"""
Grab all the bookmark+ files from EmacsWiki.
If there are changes commit them to the repo.
"""

import sys
import re
import os
from os.path import dirname
from subprocess import Popen, call, PIPE
from urllib2 import urlopen, URLError
from time import sleep
from optparse import OptionParser
from datetime import datetime

class FileNotFoundError(OSError):
    pass

class NoChangesException(Exception):
    pass

REPO_DIR   = dirname(dirname(os.path.abspath(__file__)))
SOURCE_DIR = os.path.join(REPO_DIR, 'src')

def get_files(options):
    url_format = "http://www.emacswiki.org/emacs/download/bookmark%%2b%s.el"
    suffixes = ['',
                '-mac',
                '-bmu',
                '-1',
                '-key',
                '-lit',
                '-doc',
                '-chg']
    failed_suffixes = []
    pages = {}

    for suffix in suffixes:
        try:
            addr = url_format % suffix
            pages[suffix] = urlopen(addr).read()
            if options.verbose:
                print "Got %s" % addr.split('/')[-1]
        except URLError:
            failed_suffixes.append(suffix)

    for suffix in failed_suffixes:
        # give it another shot, what the hell
        sleep(1)
        try:
            addr = url_format % suffix
            if options.verbose:
                print "Trying to get %s." % addr.split('/')[-1]
            pages[suffix] = urlopen(addr).read()
            del pages[suffix]
        except URLError, e:
            print >>sys.stderr, "Could not get %s (%s), dying." % (
                suffix, str(e))
            exit(1)

    return pages

def _write(files, to_dir):
    ""
    fmt = 'bookmark+%s.el'
    for suffix, data in files.iteritems():
        try:
            fname = os.path.join(to_dir, fmt % suffix)
            if not os.path.exists(fname):
                raise FileNotFoundError()
            fh = open(fname, 'w')
            fh.write(data)
        except FileNotFoundError:
            print >>sys.stderr, "Don't want to open a new file! (%s)" % fname
        finally:
            fh.close()

def write_files(files):
    "``files`` should be a dictionary of (suffix, file_contents) pairs"
    path = os.path.abspath('.')
    while path != '/':
        if 'src' in os.listdir(path):
            return _write(files, os.path.join(path, 'src'))

        path = os.path.dirname(path)

    print >>sys.stderr, "Couldn't find the source dir"
    exit(2)

def extract_changelog(changes, verbose):
    """return an ([authors], changelog) tuple"""
    file_delim = re.compile(r"CHANGE LOG FOR `(?P<file>[^']+)'")
    author_pat = re.compile(r'\d{4}/\d{2}/\d{2} (.*)')
    changelog = []
    authors = []

    # generate the changelog header
    full_changes = "Auto-generated commit message extracted from" +\
        " bookmark+-chg.el\n\n"

    files_changed = Popen(['git', 'status', '--porcelain', SOURCE_DIR],
                          stdout=PIPE).communicate()[0]
    files_changed = [f.lstrip(' M') for f in files_changed.split('\n')]

    full_changes += 'Files Changed:\n    %s' % (
        '\n    '.join(files_changed))

    # Keep track of whether or not we're in a file's changes or in meta-info.
    # This is because I'm too lazy to convert ``changes`` into a StringIO
    # instance and do things correctly
    log_line = False

    # get drew's actual changelog
    for line in changes.split('\n'):
        if line.startswith('diff') or line.startswith('@@'):
            log_line = False
            continue

        if file_delim.search(line):
            log_line = True
            changelog.append('\n'+line)
            continue

        author = author_pat.search(line)
        if author and not author.group(1) in authors:
            authors.append(author.group(1))

        if line.startswith('+;') and log_line:
            changelog.append(line.lstrip('+;'))

    full_changes += '\n'.join(changelog)

    if verbose:
        print full_changes

    return authors, full_changes

def get_changes(options):
    """
    Get the things that have changed in bookmark+-chg so that we can use them
    as the commit message

    return an ([authors], changelog) tuple."""

    changefile = os.path.join(SOURCE_DIR, 'bookmark+-chg.el')

    diff = Popen(['git', 'diff', SOURCE_DIR], stdout=PIPE)
    diff_chg = Popen(['git', 'diff', changefile],
                     stdout=PIPE)

    the_diff = diff.communicate()[0]

    if the_diff:
        changes = diff_chg.communicate()[0]
        return extract_changelog(changes, verbose=options.verbose)
    else:
        raise NoChangesException()


def commit(authors, message):
    if authors:
        author_str = ' and '.join(authors)
        if '<' not in author_str:
            # git *really* likes emails
            author_str += ' <%s>' % authors[0]
    else:
        author_str = "Unknown <unknown>"

    author_arg = '--author=%s' % author_str

    call(['git', 'add', 'src'])
    call(['git', 'commit', author_arg, '-m', message])

def log(msg, logfile):
    fmt = "[%s] %s\n"
    now = datetime.now().strftime('%F %H:%M')
    try:
        fh = open(logfile, 'a')
        fh.write(fmt % (now, msg.rstrip()))
    finally:
        fh.close()

def parse_args():
    parser = OptionParser()
    parser.add_option('--no-git',
                      dest="git",
                      action="store_false",
                      default=True,
                      help="Don't do any git-specific things, "
                      "just download the files.")
    parser.add_option('--no-fetch',
                      dest="fetch",
                      action="store_false",
                      default=True,
                      help="Don't grab the files from the net.")
    parser.add_option('-v', '--verbose',
                      action='store_true',
                      default=False,
                      help="Be friendly (talk about progress updates, etc)")
    defupdate = os.path.join(REPO_DIR, 'updates.log')
    parser.add_option('-l', '--logfile',
                      default=defupdate,
                      help="The logfile to write to.")
    return parser.parse_args()

def main():
    options, args = parse_args()

    if options.fetch:
        files = get_files(options)
        write_files(files)
    if options.git:
        try:
            authors, changes = get_changes(options)
            commit(authors, changes)
            log("Commited changes.", options.logfile)
        except NoChangesException:
            if options.verbose:
                print "No Changes"
            log("No Changes.", options.logfile)


if __name__ == "__main__":
    try:
        main()
    except Exception, e:
        log(str(e), os.path.join(REPO_DIR, 'updates.log'))
