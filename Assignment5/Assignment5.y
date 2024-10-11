/* Este archivo contiene un reconocedor sintáctico.

   Para compilar y ejecutar:
   flex Assignment5.l; bison -d Assignment5.y; gcc lex.yy.c Assignment5.tab.c -lfl; ./a.out <filename>

   ejemplo:
   flex Assignment5.l; bison -d Assignment5.y; gcc lex.yy.c Assignment5.tab.c -lfl; ./a.out testCase.txt
   Autor: Nezih Nieto Gutiérrez	*/

%{
	#include	<stdio.h>
	#include	<math.h>
	#include	<stdlib.h>
	#include	<string.h>
	int * count; 
	extern int yylex();
	int yyerror(char const * s);
	int potenciaConWhile(int numero, int potencia);
	extern char * yytext;
	extern FILE * yyin;
	extern int order;
	extern int line;
%}

/* Los elementos terminales de la gramática. La declaración de abajo se
   convierte en definición de constantes en el archivo Assignment5.tab.h
   que hay que incluir en el archivo de flex. */

%token T_FLOAT T_INTEGER T_COMMA T_SEMICOL T_OPENKEY T_CLOSEKEY T_OPENBRACK T_CLOSEBRACK T_OPENPAR T_CLOSEPAR T_PLUSOP T_MULTOP T_MINUSOP T_DIVOP T_ASSOP T_EQSYM T_LESSOP T_MOREOP T_LESSOEQOP T_MOREOEQOP T_DOIF T_DOIFELSE T_DOWHILE T_DOUNTIL T_PROGRAM T_BEGIN T_END T_EOF T_MODOP T_POWOP T_COLON T_READ T_PRINT T_ID
%start prog 

%%
	prog 		: T_PROGRAM T_ID opt_decls T_BEGIN opt_stmts T_END {printf("Dopest code ever!!!!\n");}
	;

	opt_decls 	: decl_lst 
				|
	;

	decl_lst 	: decl T_SEMICOL decl 
				| decl
	;

	decl 		: type T_COLON id_list
	;
	
	id_list 	: T_ID T_COMMA id_list 
				| T_ID
	;
	
	type 		: T_INTEGER 
				| T_FLOAT
	;
	
	stmt 		: T_ID T_ASSOP expr
				| T_DOIF T_OPENPAR expression T_CLOSEPAR T_OPENBRACK opt_stmts T_CLOSEBRACK
				| T_DOIFELSE T_OPENPAR expression T_CLOSEPAR T_OPENBRACK opt_stmts T_CLOSEBRACK T_OPENBRACK opt_stmts T_CLOSEBRACK
				| T_DOUNTIL T_OPENPAR expression T_CLOSEPAR T_OPENBRACK opt_stmts T_CLOSEBRACK
				| T_DOWHILE T_OPENPAR expression T_CLOSEPAR T_OPENBRACK opt_stmts T_CLOSEBRACK
				| T_PRINT expr
				| T_READ T_ID
	;
	
	opt_stmts 	: stmt_lst 
				|
	;
	
	stmt_lst 	: stmt T_SEMICOL stmt_lst 
				| stmt
	;
	
	expr	 	: expr T_PLUSOP term    //{$$ = $1 + $3;}
	     		| expr T_MINUSOP term   //{$$ = $1 - $3;}
	     		| term
	;

	term 		: term T_MULTOP factor   		//{$$ = $1 * $3;}
	     		| term T_DIVOP factor		//{$$ = $1 / $3;}
	     		| term T_MODOP factor 		//{$$ = $1 % $3;}
	     		| term T_POWOP factor 		//{$$ = potenciaConWhile($1, $3);}
	     		| factor
	;

	factor 		: T_OPENPAR expr T_CLOSEPAR  //{$$ = $2;}
	       		| T_FLOAT
	       		| T_INTEGER
	;
	
	expression 	: expr T_LESSOP expr	   //{$$ = $1 < $3;}
		   		| expr T_MOREOP expr    //{$$ = $1 > $3;}
		   		| expr T_LESSOEQOP expr //{$$ = $1 <= $3;}
		   		| expr T_MOREOEQOP expr //{$$ = $1 >= $3;}
		   		| expr T_EQSYM expr 	   //{$$ = $1 = $3;}
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
	fprintf(stderr, "%s,%s at [%d,%d]\n", s, yytext,line,order);
	exit(1);
}

void main(int argc, char * argv[]) {
   extern FILE * yyin;
   if(argc<2){
      	yyparse();
   } else{
    yyin = fopen(argv[1],"r");
    yyparse();
   }

}

