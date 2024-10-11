/* Tarea 2

Este programa es un reconocedor léxico que reconoce los elementos léxicos de un lenguaje de programación con los siguientes elementos:

1. Constantes como las usadas en C. Reconoce constantes enteras y de coma flotante.
2. Identificadores como los utilizados en el lenguaje de programación C.
3. Las palabras reservadas: do-if, do-ifelse, do-while, do-until.
4. Los símbolos: ',', ';', '{', '}', '[', ']', '+', '*', '-', '/', ':=', '=', '<', '>

   Para compilar y ejecutar:
   flex tarea2.lex
   gcc lex.yy.c -lfl
   ./a.out <filename.txt>

   Sergio Ivan Villegas Arenas A01625055

    */



%{
#include<stdio.h>
#include<stdlib.h>
#include<math.h>



#define ID 1
#define CONSTANT 2
#define DO_IF 3
#define DO_IFELSE 4
#define DO_WHILE 5
#define DO_UNTIL 6
#define COMA 7
#define PUNTOYCOMA 8
#define I_LLAVE 9
#define F_LLAVE 10
#define I_CORCHETE 11
#define F_CORCHETE 12
#define SUMA 13
#define PRODUCTO 14
#define RESTA 15
#define DIVISION 16
#define ASIGNAR 17
#define IGUAL 18
#define MENOR 19
#define MAYOR 20
#define FLOAT 21
#define FIN 22
#define I_PARENT 23
#define F_PARENT 24


int yylval;
float yyfloat;
%}

LETRA [A-Za-z]
INT (-?[1-9][0-9]{0,4})|0 
FLOAT (-?[0-9]{0,8}+"."+[0-9]{0,8})
ID [a-zA-Z_][a-zA_Z0-9_]*

%%

{INT} {yylval = atoi(yytext); return CONSTANT; }
{FLOAT} {yyfloat = atof(yytext); return FLOAT;}

{ID} {return ID;}

"do-if"       {return DO_IF;}
"do-ifelse"   {return DO_IFELSE;}
"do-while"    {return DO_WHILE;}
"do-until"    {return DO_UNTIL;}

","       {return COMA;}
";"       {return PUNTOYCOMA;}
"{"       {return I_LLAVE;}
"}"       {return F_LLAVE;}
"["       {return I_CORCHETE;}
"]"       {return F_CORCHETE;}
"+"       {return SUMA;}
"*"       {return PRODUCTO;}
"/"       {return DIVISION;}
":="      {return ASIGNAR;}
"="       {return IGUAL;}
"<"       {return MENOR;}
">"       {return MAYOR;}



"$"       {return FIN;}
[ \n\t]   { }

%%

int main(int argc, char * argv[]) {

  int dato;

  if (argc < 2) {
    printf ("Error: Nombre de archivo incorrecto");
    exit(1);
  }
  yyin = fopen(argv[1], "r");

  if (yyin == NULL) {
    printf("Error: No existe el archivo\n");
    exit(1);
  }

  while ((dato = yylex()) != FIN) {
    if (dato == CONSTANT){ 
      printf("Constant %d\n", yylval);
    }
    else if(dato == FLOAT ){
      printf("Constant %s\n", yytext);
    }
    else if(dato == DO_IF || dato ==DO_IFELSE || dato == DO_WHILE || dato == DO_UNTIL){
      printf("Reserved word %s\n", yytext);
    } 
     else if(dato == COMA || dato == PUNTOYCOMA ||  dato == I_LLAVE ||  dato == F_LLAVE || dato == I_CORCHETE || dato == F_CORCHETE || dato == SUMA || dato == PRODUCTO || dato == DIVISION  || dato == ASIGNAR || dato == IGUAL || dato == MENOR || dato == MAYOR){
      printf("Symbol %s\n", yytext);
    } 
    else{
      printf("Identifier %s\n", yytext);
    }

  }
}