/* Este archivo contiene un reconocedor de expresiones aritm�ticas junto
   con algunas reglas sem�nticas que calculan los valores de las
   expresiones que se reconocen. Las expresiones son muy sencillas y
   consisten �nicamente de sumas, restas, multiplicaciones,divisiones, potencias y modulos de
   n�meros enteros.

   Para compilar y ejecutar:
   flex calculadora.lex
   bison -d calculadora.y
   gcc lex.yy.c calculadora.tab.c -lfl -lm
   ./a.out

   Autor: Alberto Oliart Ros 
   Coautor: Sergio Ivan Villegas Arenas A01625055   */

%{
#include<stdlib.h>
#include<stdio.h>
#include<math.h>
extern int yylex();
int yyerror(char const * s);

%}

/* Los elementos terminales de la gram�tica. La declaraci�n de abajo se
   convierte en definici�n de constantes en el archivo calculadora.tab.h
   que hay que incluir en el archivo de flex. */

%token NUM SUMA RESTA DIVIDE MULTI PAREND PARENI MOD POW FINEXP
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
     | term POW factor     {$$ = pow($1, $3);}
     | term MOD factor     {$$ = $1 % $3;}
     | factor
;

factor : PARENI expr PAREND  {$$ = $2;}
       | NUM
;

%%

int yyerror(char const * s) {
  fprintf(stderr, "%s\n", s);
}

void main() {

  yyparse();
}

