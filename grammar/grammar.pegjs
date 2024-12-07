inicio
  = _ dcl:Declaracion* _ { return JSON.stringify(dcl, null, 2); }


Declaracion
    = identificador:Identificador _ "=" _ valor:Valor _ { 
        return { tipo: "Declaracion", nombre: identificador, valor: valor }; 
    }
    / identificador:Identificador _ "=" _ referencia:Identificador _ {
      return { tipo: "Declaracion", nombre: identificador, referencia: referencia };
    }

Valor

    = '"' text:literalContent '"' { return text; }
    / "'" text:literalContent "'" { return text; }
    / conj: Conjunto { return conj; }
    / sec: secuenciaRepetida { return sec; }
  	/ exp: Expresion { return exp; }



secuenciaRepetida
  = texto:Literal _ "*" { 
      return { tipo: "SecuenciaRepetida", valor: texto }; 
  }
  / texto:Literal { 
      return { tipo: "SecuenciaRepetida", valor: texto }; 
  }
  
// Literal (por ejemplo, "foo")
Literal
  = '"' texto:[a-zA-Z0-9]+ '"' { return texto.join(""); }
  
Conjunto
  = "[" contenido:(Rango / Caracter+)+ "]" { 
      return { tipo: "Conjunto", valores: contenido.flat() }; 
    }

Rango
  = inicio:Caracter "-" fin:Caracter { 
      if (inicio.charCodeAt(0) > fin.charCodeAt(0)) {
        throw new Error("Rango inválido: el inicio debe ser menor o igual al final.");
      }
      const valores = [];
      for (let i = inicio.charCodeAt(0); i <= fin.charCodeAt(0); i++) {
        valores.push(String.fromCharCode(i));
      }
      return valores;
    }

Caracter
  = [a-zA-Z0-9] { return text(); } 

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