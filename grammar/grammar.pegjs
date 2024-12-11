inicio
  = regla newl (newl regla newl)*

regla
  = name _ "=" _ elegir _ ";"

elegir
  = concatenation (newl "/" newl concatenation)*

concatenation
	= expression (_ expression)*

repeticion
  = expression repetitionQuantifier?

repetitionQuantifier
  = "|" count:integer "|"  // Exacto número de repeticiones
  / "|" min:integer ".." max:integer "|"  // Rango de repeticiones

delimitador "delimitador"
  = parsingExpression { return { type: "delimiter" }; }

expression
  = parsingExpression newl[?+*]?
  / group newl[?+*]?
  / insensitiveString

insensitiveString
  = string insensitive:"i"?

group
  = "(" _ inner:elegir _ ")"  // Alternativas completas dentro de paréntesis
  / "(" _ inner:concatenation _ ")"  // Concatenaciones completas

parsingExpression
  = name
  / string
  / range
  / dot

string
  = ["] [^"]* ["] insensitive:"i"?
  / ['] [^']* ['] insensitive:"i"?

range
  = "[" input_range+ "]"

input_range
  = [^[\]-] "-" [^[\]-]
  / [^[\]]+

name "identificador"
  = [a-zA-Z_][a-zA-Z0-9_]*

dot "punto"
  = "." { return { type: "dot", description: "match any single character" }; }

integer "entero positivo"
  = [0-9]+ { return parseInt(text(), 10); }

_ "espacios en blanco"
  = ([ \t] / Comments)*

newl "nueva linea"
  = ([ \t\n\r] / Comments)*

Comments
  = "//" (![\n] .)*  // Comentarios de una línea
  / "/" (!"/" .)* "*/"  // Comentarios multilínea
