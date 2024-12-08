inicio
  = regla (newl regla)*

regla
  = name _ "=" _ elegir _ ";"
  
elegir
  = concatenation (newl "/" newl concatenation)*

concatenation
  = expression (_ expression)*

expression
  = parsingExpression newl[?+*]?
  / group newl[?+*]?
  
group
  = "(" _ inner:elegir _ ")"  // Alternativas completas dentro de paréntesis
  / "(" _ inner:concatenation _ ")"  // Concatenaciones completas
  
parsingExpression
  = name
  / string
  / range
 

string
  = ["] [^"]* ["]
  / ['] [^']* [']

range
  = "[" input_range+ "]"

input_range
  = [^[\]-] "-" [^[\]-]
  / [^[\]]+

name "identificador"
  = [a-zA-Z_][a-zA-Z0-9_]* 
   

_ "espacios en blanco"
  = ([ \t] / Comments)*

newl "nueva linea"
  = ([ \t\n\r] / Comments)*

Comments
  = "//" (![\n] .)*  // Comentarios de una línea
  / "/" (!"/" .)* "*/"  // Comentarios multilínea