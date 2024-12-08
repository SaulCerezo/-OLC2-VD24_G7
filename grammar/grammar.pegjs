{
  const array_reglas = {}; 
}

start
  = head:Reglas tail:(_ Reglas)* {
      return [head, ...tail.map(([_, rule]) => rule)];
    }

Reglas 
  = var_:variable _ "=" _ expr:Expression _ ";" {
  array_reglas[var_] = expr;
  return {var_, expr};
}

Expression 
  = primero:cadena lista:(_ cadena)* {
      return [primero, ...lista.map(([_, cadena]) => cadena)];
    }

cadena 
  = variable_referencia:variable {
    if(array_reglas[variable_referencia]){ return `Regla: ${variable_referencia}`; }
    else{ throw new Error(`Regla no definida: ${variable_referencia}`); }
  } 
  / cero_o_mas/ una_o_mas / cero_o_uno / opciones / concatenacion / quoted / range / set / subexpresion _ (';'/_) {
      return 'Cadena reconocida: ' + rec;
    }

subexpresion
  = '(' _ expr:Expression _ ')' {
      return expr;
    }

cero_o_mas
  = _ rec:(opciones / concatenacion / quoted / range / set / subexpresion) _ "*" { 
      return [" ", rec, rec + rec, rec + rec + rec];
    }

una_o_mas
  = _ rec:(opciones / concatenacion / quoted / range / set / subexpresion) _ "+" { 
      return [rec, rec + rec, rec + rec + rec];
    }

cero_o_uno
  = _ rec:(opciones / concatenacion / quoted / range / set / subexpresion) _ "?" { 
      return [" ", rec];
    }

variable =[a-zA-Z0-9_]+ {
      return text();
    }

quoted
  = '"' [a-zA-Z0-9_]+ '"' {
      return text().slice(1, -1); // Quitar comillas 
    }
  / "'" [a-zA-Z0-9_]+ "'" {
      return text().slice(1, -1); // Quitar comillas
    }

concatenacion
  = quotedPart:quoted _ otherParts:(quoted _)* {
      // Concatenar todas las partes en una sola cadena
      return [quotedPart, ...otherParts.map(([part]) => part)].join('');
    }
    
opciones
  = first:quoted _ '/' _ rest:(quoted _ '/' _)* last:quoted {
      // Captura las cadenas y las coloca en un array
      return [first, ...rest.map(([option]) => option), last];
    }


range
  = '[' start:[a-zA-Z] '-' end:[a-zA-Z] ']' {
      const result = [];
      for (let char = start.charCodeAt(0); char <= end.charCodeAt(0); char++) {
        result.push(String.fromCharCode(char));
      }
      return result; // Rango como arreglo
    }

set
  = '[' chars:[a-zA-Z0-9]+ ']' {
       return chars.join('').split('');
    }

_ = [ \t\n\r]* 

