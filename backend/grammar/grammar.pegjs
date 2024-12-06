inicio
  = _ dcl:Declaracion* _ { return dcl; }


Declaracion
    = identificador:Identificador _ "=" _ valor:Valor _ { 
        return { tipo: "Declaracion", nombre: identificador, valor: valor }; 
    }

Valor

    = '"' text:literalContent '"' { return text; }
    / "'" text:literalContent "'" { return text; }
  
    / exp:Expresion { return exp; }


Expresion
  = "(" _ expr:additive _ ")" { return expr; }
    / "(" _ expr:Valor _ ")" { return expr; }
    / additive 

    


additive
  = left:multiplicative _ "+" _ right:additive { return left + right; }
  / multiplicative

multiplicative
  = left:primary _ "*" _ right:multiplicative { return left * right; }
  / primary

primary
  = integer
  / "(" _ expr:additive _ ")" { return expr; }

integer
  = [0-9]+ { return parseInt(text(), 10); }

Identificador
  = [a-zA-Z][a-zA-Z0-9]* { return text(); }

literalContent
  = [^"']+ // Contenido literal dentro de comillas

_ 
  = ([ \t\n\r] / Comments)*

Comments
  = "//" (![\n] .)*  // Comentarios de una línea
  / "/*" (!"*/" .)* "*/"  // Comentarios multilínea
