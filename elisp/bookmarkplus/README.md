# Bookmark+ in Git

This is a git repo that exists because downloading 7 files (in 14 clicks) is too much work to get an Emacs plugin working, and The Author has said that he's uninterested in using a VCS or putting it up on github.

I didn't write this, (all credit goes to Drew Adams and Theiry Volpiatto) I don't know the code and I'm not a maintainer.
Drew Adams (concat "drew.adams" "@" "oracle" ".com") is the maintainer, and actively.

That said, patches welcome.

The [project page on EmacsWiki](http://www.emacswiki.org/emacs/BookmarkPlus) is where you should go for installation instructions, documentation, conversation, and to make sure that you've got the latest version.
(Maybe check [the changelog](http://www.emacswiki.org/emacs/bookmark%2b-chg.el)?)

## Updating

`scripts/update_bmkp.py` is a hack to update all the files, grabbing them from EmacsWiki and updating the git repo if there are changes.
It needs to be run from the repo root.

### update_bmkp TODO

- Automatically byte-compile and move the files after update.
