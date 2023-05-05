; non delimiting words
; [
;   "NaN"
;   "allowing"
;   "ancestor"
;   "ancestor-or-self"
;   "and"
;   "array"
;   "as"
;   "ascending"
;   "at"
;   "attribute"
;   "base-uri"
;   "boundary-space"
;   "by"
;   "case"
;   "cast"
;   "castable"
;   "catch"
;   "child"
;   "collation"
;   "comment"
;   "construction"
;   "context"
;   "copy-namespaces"
;   "count"
;   "decimal-format"
;   "decimal-separator"
;   "declare"
;   "default"
;   "descendant"
;   "descendant-or-self"
;   "descending"
;   "digit"
;   "div"
;   "document"
;   "document-node"
;   "element"
;   "else"
;   "empty"
;   "empty-sequence"
;   "encoding"
;   "eq"
;   "every"
;   "except"
;   "exponent-separator"
;   "external"
;   "following"
;   "following-sibling"
;   "for"
;   "function"
;   "ge"
;   "greatest"
;   "group"
;   "grouping-separator"
;   "gt"
;   "idiv"
;   "if"
;   "import"
;   "in"
;   "infinity"
;   "inherit"
;   "instance"
;   "intersect"
;   "is"
;   "item"
;   "le"
;   "least"
;   "let"
;   "lt"
;   "map"
;   "minus-sign"
;   "mod"
;   "module"
;   "namespace"
;   "namespace-node"
;   "ne"
;   "no-inherit"
;   "no-preserve"
;   "of"
;   "option"
;   "or"
;   "order"
;   "ordered"
;   "ordering"
;   "parent"
;   "pattern-separator"
;   "per-mille"
;   "percent"
;   "preceding"
;   "preceding-sibling"
;   "preserve"
;   "processing-instruction"
;   "return"
;   "satisfies"
;   "schema"
;   "schema-attribute"
;   "schema-element"
;   "self"
;   "some"
;   "stable"
;   "strip"
;   "switch"
;   "text"
;   "then"
;   "to"
;   "treat"
;   "try"
;   "typeswitch"
;   "union"
;   "unordered"
;   "variable"
;   "version"
;   "where"
;   "xquery"
;   "zero-digit"
; ] @keyword




(module_import
  [
   name: (identifier) @namespace
   "import"  @include
   ]
  )
(schema_import
  [
   name: (identifier) @namespace
   "element" @keyword
   "import"  @include
   ]
  )
; highlight top level namespace
[
 (module_declaration )
 (namespace_declaration)
 ] @namespace


(function_declaration "function" @keyword.function)
(inline_function_expr "function" @keyword.function)
(default_namespace_declaration [ "function"  "element"] @keyword)
(context_item_declaration [ "context"  "item"] @keyword)
(variable_declaration "variable" @keyword)

;
;
; lhs rhs binary statements

(range_expr [ "to" ] @keyword.operator)
(additive_expr [ "-" "+"] @operator)
(multiplicative_expr [ "*" ] @operator)
(multiplicative_expr [ "div" "idiv" "mod" ] @keyword.operator)
(comparison_expr [ "eq" "ne" "lt" "le" "gt" "ge" "is" ] @keyword.operator)
(comparison_expr [ "=" "!=" "<" "<=" ">" ">="  "<<" ">>" ] @operator)
(unary_expr [ "-" "+"] @operator)
(and_expr [ "and" ] @keyword.operator)
(or_expr [ "or" ] @keyword.operator)
; ; other lhs rhs expr operators that are words  
(instance_of_expr ["instance" "of"] @keyword.operator ) 
(cast_expr [ "cast"] @keyword.operator ) 
(castable_expr [ "castable"] @keyword.operator ) 
(treat_expr [ "treat"] @keyword.operator ) 
(intersect_except_expr [ "intersect" "except"] @keyword.operator )
(union_expr [ "union" ] @keyword.operator )
(string_concat_expr ["||"] @operator )
(bang_expr [ "!" ] @operator )
(arrow_expr [ "=>" ]  @operator)


; (context/_item_expr [ "." ] @operator)
(lookup [ "?" ] @operator) 


;(unary_lookup "?" @operator )

; 3.12 FLWOR Expressions
[ 
  "at" 
  "in" 
  "where"
  ] @conditional
[ 
  "allowing"
  "as"
  "ascending"
  "by"
  "collation" 
  "count"
  "descending"
  "empty"
  "greatest"
  "group"
  "least"
  "let"
  "order"
  "ordered" 
  "stable"
  "unordered"
  ] @keyword
["return"] @keyword.return
;
[ 
  (variable)
  (var_ref)
  ] @variable
; (variable 
;   [ 
;     prefixed: (identifier) @variable.namespace
;     local: (identifier) @variable
;     ncname: (identifier) @variable
;   ])



(function_call
  [
    prefixed: (identifier) @function.namespace
    local: (identifier) @function
    ncname: (identifier) @function
  ])

; when in the tree context of
; sequence_type/item_type
; then identify as a builtin type
(lookup
  [
    key: (identifier) @constant
  ])

;delimiting terminal symbols
 ;S, "!", "!=", StringLiteral, "#", "#)", "$", "%", "(", "(#", ")", "*", "*:", "+", (comma), "-", "-->", (dot), "..", "/", "//", "/>", (colon), ":*", "::", ":=", (semi-colon), "<", "<!--", "<![CDATA[", "</", "<<", "<=", "<?", "=", "=>", ">", ">=", ">>", "?", "?>", "@", BracedURILiteral, "[", "]", "]]>", "]``", "``[", "`{", "{", "|", "||", "}", "}`" ] ;

[ "%" ";" ":=" "," "|" ] @punctuation.delimiter


(path_expr  [ "/" "//" ] @operator)
(forward_axis [
   [
   "child"
   "descendant"
   "attribute"
   "self"
   "descendant-or-self"
   "following-sibling"
   "following"] @keyword.path
   "::" @punctuation.delimiter
    ncname: (identifier) @constant.name
    name_test: (wildcard) @type.wildcard
    kind_test: (_) @type.kind
    ])

(reverse_axis [
  [
  "parent"
  "ancestor"
  "preceding-sibling"  
  "preceding"
  "ancestor-or-self"
  ] @keyword.path
   "::" @punctuation.delimiter
    ncname: (identifier) @constant.name
    name_test: (wildcard) @constant.wildcard
    kind_test: (_) @constant.kind
    ])
(abbrev_forward_step  [
    name_test: (wildcard) @constant.wildcard
    ])

(_
    [          
    prefixed: (identifier) @namespace
    local: (identifier) @type.local
    ncname: (identifier) @type.name
    name: (wildcard) @type.wildcard
    ]
 )



; 
; pairs @punctuation.bracket
(enclosed_expr  [ "{" "}" ] @punctuation.bracket)
(parenthesized_expr [ "(" ")" ] @punctuation.bracket)
(string_constructor [ "``[" "]``" ] @punctuation.bracket)
(interpolation [ "`{" "}`" ] @punctuation.bracket.special)
(string_literal [ "'" "\""] @punctuation.bracket ) 

[ (string_apos_content) (string_quote_content) (string_constructor_chars) ] @string
[(integer_literal) (decimal_literal) (double_literal) ] @number

(ERROR) @error
