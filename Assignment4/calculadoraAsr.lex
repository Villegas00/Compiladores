/* Archivo con el reconocedor l�xico para la calculadora */
%{
#include<stdlib.h>
#include<math.h>
  /* Se incluye el archivo generado por bison para tener las definiciones
     de los tokens */
#include "calculadoraAsr.tab.h"
%}

LETRA [A-Za-z]
DIGITO [0-9]

%%

{DIGITO}* {yylval.valor = atoi(yytext); return NUM; /* Convierte el NUM a número */}
"+"       {return SUMA; /* Se encontr� un s�mbolo de suma */}
"-"       {return RESTA;/* Se encontr� un s�mbolo de resta */}
"*"       {return MULTI;/* Se encontr� un s�mbolo de multiplicaci�n */}
"/"       {return DIVIDE;/* Se encontr� un s�mbolo de divisi�n */}
"%"       {return MOD;/* Se encontr� un "%" */}
"^"       {return POW;/* Se encontr� un "^" */}
"("       {return PARENI;/* Se encontr� un "(" */}
")"       {return PAREND;/* Se encontr� un ")" */}
"$"       {return FINEXP;/* Se encontr� un $, que es s�mbolo de fin de expr */}
[ \n\t]   { }
.         {return -1;}

%%
