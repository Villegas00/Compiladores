/* Este archivo contiene un reconocedor de expresiones aritméticas junto
   con algunas reglas semánticas que calculan los valores de las
   expresiones que se reconocen. Las expresiones son muy sencillas y
   consisten únicamente de sumas, restas, multiplicaciones y divisiones de
   números enteros.

   Para compilar y ejecutar:
   flex calculadora.lex
   bison -d calculadora.y
   gcc lex.yy.c calculadora.tab.c -lfl
   ./a.out

   Autor: Alberto Oliart Ros 
   Co-autor: Nezih Nieto Gutiérrez	*/

%{
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
extern int yylex();
int yyerror(char const * s);
(int numero, int potencia);
%}

/* Los elementos terminales de la gramática. La declaración de abajo se
   convierte en definición de constantes en el archivo calculadora.tab.h
   que hay que incluir en el archivo de flex. */

%token NUM SUMA RESTA DIVIDE MULTI MOD POW PAREND PARENI FINEXP
%start exp

%%

exp : expr FINEXP {printf("Valor = %d\n", $1);exit(0);}
;

expr : expr SUMA term    {$$ = $1 + $3;}
     | expr RESTA term   {$$ = $1 - $3;}
     | term
;

term : term MULTI factor   {$$ = $1 * $3;}
     | term DIVIDE factor  {$$ = $1 / $3;}
     | term MOD factor 	   {$$ = $1 % $3;}
     | term POW factor 	   {$$ = potenciaConWhile($1, $3);}
     | factor
;

factor : PARENI expr PAREND  {$$ = $2;}
       | NUM
;

%%


int potenciaConWhile(int numero, int potencia)
{
    int resultado = numero;
    while (potencia > 1)
    {
        resultado = resultado * numero;
        potencia--;
    }
    return resultado;
}

int yyerror(char const * s) {
  fprintf(stderr, "%s\n", s);
}

void main() {

  yyparse();
}

