//gramatica para la fase 1 del proyecto compi2

inicio 
    = _ num:numero _ {
        return num
    }

numero 
    = [0-9]+ {return Number(text())}




_ = [ \t\n\r]*