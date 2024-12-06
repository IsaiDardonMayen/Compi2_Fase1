inicio 
    = _ num:additive _ {
        return num
    }
    
additive
  = multiplicative "+" additive
  / multiplicative

multiplicative
  = primary "*" multiplicative
  / primary

primary
  = integer
  / "(" additive ")"


integer
  = [0-9]+ { return Number(text()); }

Identificador = [a-zA-Z][a-zA-Z0-9]* { return text() }

_ = ([ \t\n\r] / Comments)* 


Comments = "//" (![\n] .)*
            / "/" (!("/") .)* "*/"