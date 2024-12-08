grammar
 = regla (_ regla)*

regla
 = _ id _ "=" _ opciones _ (';'/_)

opciones
 = concatenacion (_ "/" _ concatenacion)*

concatenacion
 = expresion (_ expresion)*
 
expresion
 = subexpresion [+*?]?
 / cero_o_mas
 / una_o_mas
 / cero_o_una
 / parseo
 
 subexpresion
  = "(" _ opciones _ ")"

cero_o_mas
 = _ parseo _ "*" 

una_o_mas
 = _ parseo _ "+"
