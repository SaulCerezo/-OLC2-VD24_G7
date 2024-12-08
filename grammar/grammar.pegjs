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

cero_o_una
 = _ parseo _ "?"

parseo
 = id
 / cadena
 / rango
 / conjunto 

id
 = [a-zA-Z0-9_]+

cadena
 = ["] [^"]* ["]
 / ['] [^']* [']

rango
 =  "[" contenido_rango+ "]"
 
contenido_rango = [^[\]-] "-" [^[\]-]

conjunto
 = "[" contenido_conjunto+ "]"

contenido_conjunto = [^[\]]+

_ = [ \t\n\r]*