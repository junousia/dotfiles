;; http://groups.google.com/group/gnu.emacs.help/browse_thread/thread/b2f51ca55c68f4dc?pli=1

(if (and (not (boundp 'font-lock-builtin-face))
         (boundp 'font-lock-doc-string-face))
    (defun ttcn3-builtin-face ()
      "builtin face for XEmacs"
      font-lock-doc-string-face)
  (defun ttcn3-builtin-face ()
    "builtin face for GNU Emacs"
    font-lock-builtin-face))
(if (and (not (boundp 'font-lock-constant-face))
         (boundp 'font-lock-preprocessor-face))
    (defun ttcn3-constant-face ()
      "constant face for XEmacs"
      font-lock-preprocessor-face)
  (defun ttcn3-constant-face ()
    "constant face for GNU Emacs"
    font-lock-constant-face))

(setq ttcn3-font-lock-keywords
        (list
         ;; TTCN-3 functions, modules, and testcases
         (list (concat
                "\\<\\(" "function" "\\|" "group" "\\|" "language"
                "\\|" "module" "\\|" "named alt" "\\|" "altstep"
                "\\|" "testcase"
                "\\)\\>" "[ \t]+\\(\\sw+\\)?")
               '(1 font-lock-keyword-face)
               '(2 font-lock-function-name-face nil t))
         ;; TTCN-3 keywords
         (list
          (concat
           "\\<"
           (regexp-opt
            '("action" "activate" "all" "alt" "and" "and4b" "any"
              "call" "catch" "check" "clear" "connect" "const"
              "control" "create" "deactivate" "disconnect" "display"
              "do" "done" "else" "encode" "error" "except" "exception"
              "execute" "expand" "extension" "external" "fail" "false"
              "for" "from" "get" "getcall" "getreply" "getverdict"
"goto" "if"
              "ifpresent" "import" "in" "inconc" "infinity" "inout"
              "interleave" "label" "length" "log" "map" "match"
              "message" "mixed" "mod" "modifies" "modulepar" "mtc"
"none"
              "nonrecursive" "not" "not4b" "nowait" "null" "omit"
              "optional" "or" "or4b" "out" "param" "pass" "pattern"
              "procedure" "raise" "read" "receive" "rem" "repeat"
              "reply" "return" "running" "runs on" "self" "send"
              "sender" "setverdict" "signature" "start" "stop"
"sut.action"
              "system" "template" "timeout" "timer" "to" "trigger"
              "true" "type" "unmap" "value" "valueof" "var"
              "verdict.get" "verdict.set" "while" "with" "xor"
              "xor4b") t) "\\>")
          '(1 font-lock-keyword-face))
         ;; TTCN-3 predefined (built-in) functions
         (list
          (concat
           "\\<"
           (regexp-opt
            '("bit2hex" "bit2int" "bit2oct" "bit2str" "char2int" "float2int"
              "hex2bit" "hex2int" "hex2oct" "hex2str" "int2bit" "int2char"
              "int2float" "int2hex" "int2oct" "int2str" "int2unichar"
"ischosen"
              "ispresent" "lengthof" "oct2bit" "oct2hex" "oct2int"
              "oct2str" "regexp" "rnd" "sizeof" "str2int" "str2oct"
              "substr" "unichar2int") t) "\\>")
          '(1 (ttcn3-builtin-face)))
         ;; TTCN-3 types
         (list
          (concat
           "\\<"
           (regexp-opt
            '("address" "anytype" "bitstring" "boolean" "char" "charstring"
              "component" "enumerated" "float" "hexstring" "integer"
              "objid" "octetstring" "port" "record" "record of" "set"
              "set of" "union" "universal char" "universal charstring"
              "verdicttype") t)
              "\\>")
          '(1 font-lock-type-face))
         ;; user-defined types
         (list (concat "\\<\\(type\\)\\>[ \t]+\\(\\(record\\|set\\)[ \t]+"
                       "of[ \t]+\\)?\\(\\sw+\\)[ \t]+\\(\\sw+\\)")
               '(1 font-lock-keyword-face)
               '(5 font-lock-type-face nil t))
         ;; TTCN-3 constants
         (list (concat "\\<\\(const\\)\\>"
                       "[ \t]+\\(\\sw+\\)?[ \t]+\\(\\sw+\\)?")
               '(1 font-lock-keyword-face)
               '(2 font-lock-type-face)
               '(3 (ttcn3-constant-face) nil t))
         ;; TTCN-3 templates, and variables
         (list (concat "\\<\\(template\\|var\\)\\>[ \t]+"
                       "\\(\\(record\\|set\\)[ \t]+of[ \t]+\\)?"
                       "\\(\\sw+\\)[ \t]+\\(\\sw+\\)")
               '(1 font-lock-keyword-face)
               '(4 font-lock-type-face)
               '(5 font-lock-variable-name-face nil t))
         ;; ASN.1 keywords, not to be used as identifiers in TTCN-3
         (list
          (concat
           "\\<"
           (regexp-opt
            '("ABSENT" "ABSTRACT-SYNTAX" "ALL" "APPLICATION"
              "AUTOMATIC" "BEGIN" "BIT" "BMPSTRING" "BOOLEAN" "BY"
              "CHARACTER" "CHOICE" "CLASS" "COMPONENT" "COMPONENTS"
              "CONSTRAINED" "DEFAULT" "DEFINITIONS" "EMBEDDED" "END"
              "ENUMERATED" "EXCEPT" "EXPLICIT" "EXPORTS" "EXTERNAL"
              "FALSE" "FROM" "GeneralizedTime" "GeneralString"
              "IA5String" "IDENTIFIER" "IMPLICIT" "IMPORTS" "INCLUDES"
              "INSTANCE" "INTEGER" "INTERSECTION" "ISO646String" "MAX"
              "MIN" "MINUS-INFINITY" "NULL" "NumericString" "OBJECT"
              "ObjectDescriptor" "OCTET" "OF" "OPTIONAL" "PDV"
              "PLUS-INFINITY" "PRESENT" "PrintableString" "PRIVATE"
              "REAL" "SEQUENCE" "SET" "SIZE" "STRING" "SYNTAX"
              "T61String" "TAGS" "TeletexString" "TRUE"
              "TYPE-IDENTIFIER" "UNION" "UNIQUE" "UNIVERSAL"
              "UniversalString" "UTCTime" "VideotexString"
              "VisibleString" "WITH") t) "\\>")
          '(1 font-lock-reference-face))))

(define-derived-mode ttcn3-mode fundamental-mode
  (set (make-local-variable 'font-lock-defaults) '(ttcn3-font-lock-keywords))
  (setq mode-name "TTCN3")
)
(provide 'ttcn3-bds)

