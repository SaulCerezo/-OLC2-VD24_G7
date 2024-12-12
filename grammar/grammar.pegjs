grammar
 = regla (_ regla)*

regla
 = _ id alias_regla? _ "=" _ opciones _ (';' / salto_linea)

alias_regla
  = _ '"' [^"]+ '"'
  / _ "'" [^']+ "'"

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
 / _Punto_
 / fin_entrada
 / repeticiones

repeticiones
  = "|" _ (id / numero)? _ tipo_rep

tipo_rep
  = ".." _ (id / numero)? _ fin_rep
    / "|" _ etiquetada?
    / "," _ ( _ expresion _ )+ _ "|" _ etiquetada?
  
fin_rep 
  = "," _ (_ expresion _)+ _ "|" _ etiquetada?
   / "|" _ etiquetada?

fin_entrada
  = "!." _ etiquetada?

_Punto_
  = "." _ etiquetada?

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
 = [a-zA-Z_]i[a-zA-Z0-9_]i*

numero
 = [0-9]+

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