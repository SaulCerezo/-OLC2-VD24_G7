grammar
 = regla (_ regla)*

regla
 = _ id alias_regla? _ "=" _ opciones _ (';' / salto_linea)

alias_regla
  = _ '"' [^"]+ '"'

salto_linea = [\n]*

opciones
 = concatenacion (_ "/" _ concatenacion)*

concatenacion
 = etiquetada (_ etiquetada)*

etiquetada
  = id _ ":" _ expresion
  / expresion

expresion
 = pluck
 / regla 
 / asercion
 / texto
 / subexpresion [+*?]?
 / cero_o_mas
 / una_o_mas
 / cero_o_una
 / parseo
 / punto
 / fin_entrada
 / _ "|" _ repeticiones

repeticiones
  = conteo 
  / min_max
  / conteo_delimitador
  / min_max_delimitador

conteo
  = id _ "|" _ etiquetada

min_max
  = (id)? _ ".." _ (id)? _ "|" _ etiquetada 

conteo_delimitador
  = (id)? _ "," _ expresion _ "|" _ etiquetada

min_max_delimitador 
  = (id)? _ ".." _ (id)? _ "," _ expresion _ "|" etiquetada

fin_entrada
  = "!." etiquetada

punto
  = "." etiquetada

pluck
  = "@" _ etiquetada
  / "@" _ parseo

asercion 
  = ("&" / "!") _ parseo

texto
  = "$" _ expresion
  
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
 / cadena ( _ "i" / _)
 / rango ( _ "i" / _)
 / conjunto ( _ "i" / _)

id
 = [a-zA-Z_][a-zA-Z0-9_]*

cadena
 = ["] [^"]* ["]
 / ['] [^']* [']

rango
 =  "[" contenido_rango+ "]"
 
contenido_rango = [^[\]-] "-" [^[\]-]

conjunto
 = "[" contenido_conjunto+ "]"

contenido_conjunto = [^[\]]+

_ = ([ \t\n\r] / comentarios)*
   

comentarios = "//" (![\n] .)*
  /"/*" (!"*/" .)* "*/"