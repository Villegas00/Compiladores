/* Tarea 3

Este archivo contiene un reconocedor sintactico descendente predictivo de
una gramatica especifica, la cual genera un lenguaje de programacion muy basico. 
El reconocedor devuelve un “YES” si el archivo que se le presente contiene un programa
valido; de loc contarario indicara que hay un error de sintaxis señalando la lınea donde este se encuentre.

   Para compilar y ejecutar:
   flex tarea3.lex
   gcc lex.yy.c -lfl
   ./a.out <filename.txt>

   Sergio Ivan Villegas Arenas A01625055

    */


%{


#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ID 1
#define CONSTANT 2
#define END 3
#define PROGRAM 4
#define BGIN 5
#define DO_IF 6
#define DO_IF_ELSE 7
#define DO_UNTIL 8
#define DO_WHILE 9
#define ASIGNAR 10
#define IGUAL 11
#define MENORQUE 12
#define MAYORQUE 13
#define SUMA 14
#define RESTA 15
#define PRODUCTO 16
#define DIVICION 17
#define I_PARENTESIS 18
#define F_PARENTESIS 19
#define I_CORCHETE 20
#define F_CORCHETE 21
#define PUNTOYCOMA 22


int dato; 
int yylval; 
int line = 1; 
char text_file[20]; 


int prog();
void stmt();
void opt_stmts();
void stmt_lst();
void expr();
void term();
void factor();
void expresion();
void error(char * expected_grammar);

%}


%%

"end"                        {return END;}
"program"                    {return PROGRAM;}
"begin"                      {return BGIN;}
"do-if"                      {return DO_IF;}
"do-ifelse"                  {return DO_IF_ELSE;}
"do-until"                   {return DO_UNTIL;}
"do-while"                   {return DO_WHILE;}
":="                         {return ASIGNAR;}
"="                          {return IGUAL;}
"<"                          {return MENORQUE;}
">"                          {return MAYORQUE;}
"+"                          {return SUMA;}
"-"                          {return RESTA;}
"*"                          {return PRODUCTO;}
"/"                          {return DIVICION;}
"("                          {return I_PARENTESIS;}
")"                          {return F_PARENTESIS;}
"["                          {return I_CORCHETE;}
"]"                          {return F_CORCHETE;}
";"                          {return PUNTOYCOMA;}
[_$a-zA-Z][_$a-zA-Z0-9]*     {return ID;}
[1-9][0-9]*|0                {yylval = atoi(yytext); return CONSTANT;}
[ \t]                        {}
[\n]                         {line++;}

%%


int prog(){
    dato = yylex();
    if (dato == PROGRAM){
        dato = yylex();
        if (dato == ID){
            dato = yylex();
            if (dato == BGIN){
                dato = yylex();
                opt_stmts(0); 
                if (dato == END){
                    printf("Yes\n");
                    fclose(yyin);
                    exit(0);
                }
                else { error("'end'");
                     }
            }
            else { error("'begin'"); }
        }
        else { error("<ID>"); }
    }
    else { error("'program'"); }
}

void stmt(){

    if (dato == ID){
        dato = yylex();
        if (dato == ASIGNAR){
            dato = yylex();
            expr(); 
        }
        else { error("':='"); }
    }

    else if (dato == DO_IF) 
    {
        dato = yylex();
        if (dato == I_PARENTESIS){
            dato = yylex();
            expresion(); 
            if (dato == F_PARENTESIS){
                dato = yylex();
                if (dato == I_CORCHETE){
                    dato = yylex();
                    opt_stmts(); 
                    if (dato == F_CORCHETE){
                        dato = yylex();
                    }
                    else { error("']'"); }
                }
                else { error("'['"); }
            }
            else { error("')'"); }
        }
        else { error("'('"); }
    }

    else if (dato == DO_IF_ELSE){
        dato = yylex();
        if (dato == I_PARENTESIS){
            dato = yylex();
            expresion();
            if (dato == F_PARENTESIS){
                dato = yylex();
                if (dato == I_CORCHETE){
                    dato = yylex();
                    opt_stmts(); 
                    if (dato == F_CORCHETE){
                        dato = yylex();
                        if (dato == I_CORCHETE){
                            dato = yylex();
                            opt_stmts(); 
                            if (dato == F_CORCHETE){
                                dato = yylex();
                            }
                            else { error("']'"); }
                        }
                        else { error("'['"); }
                    }
                    else { error("']'"); }
                }
                else { error("'['"); }
            }
            else { error("')'"); }
        }
        else { error("'('"); }
    }

    else if (dato == DO_UNTIL){
        dato = yylex();
        if (dato == I_PARENTESIS){
            dato = yylex();
            expresion(); 
            if (dato == F_PARENTESIS){
                dato = yylex();
                if (dato == I_CORCHETE){
                    dato = yylex();
                    opt_stmts();
                    if (dato == F_CORCHETE){
                        dato = yylex();
                    }
                    else { error("']'"); }
                }
                else { error("'['"); }
            }
            else { error("')'"); }
        }
        else { error("'('"); }
    }

    else if (dato == DO_WHILE){
        dato = yylex();
        if (dato == I_PARENTESIS){
            dato = yylex();
            expresion(); 
            if (dato == F_PARENTESIS){
                dato = yylex();
                if (dato == I_CORCHETE){
                    dato = yylex();
                    opt_stmts();
                    if (dato == F_CORCHETE){
                        dato = yylex();
                    }
                    else { error("']'"); }
                }
                else { error("'['"); }
            }
            else { error("')'"); }
        }
        else { error("'('"); }
    }

    else { error("'id :=' | 'do-if' | 'do-ifelse' | 'do-until' | 'do-while'"); }
}


void opt_stmts(){
    if (dato != END){
        stmt_lst();
    }
    else{return;}
}


void stmt_lst(){
    stmt(); 
    if (dato == PUNTOYCOMA){
        dato = yylex();
        stmt_lst(); 
    }
}


void expr(){
    term(); 
     if (dato == SUMA || dato == RESTA){
        dato = yylex();
        expr(); 
    }
}

void term(){
    factor(); 
      if (dato == PRODUCTO || dato == DIVICION){
        dato = yylex();
        term(); 
    }
}

void factor(){
    if (dato == I_PARENTESIS){
        dato = yylex();
        expr(); 
        if (dato == F_PARENTESIS){
            dato = yylex();
        }
        else { error("')'"); }
    }

    else if (dato == ID) {
        dato = yylex();
    }
    
    else if (dato == CONSTANT) {
        dato = yylex();
    }

    else { error("'(' | <ID> | <CONSTANT>"); }
}


void expresion(){
    expr(); 
    if (dato == MENORQUE | dato == MAYORQUE || dato == IGUAL){
        dato = yylex();
    }
    
    else { error("'<' | '>' | '='"); } 
    expr(); 
}



void error(char * expected_grammar){
    printf("%s: error in line %i: ", text_file, line); 
    printf("expected %s\n", expected_grammar); 
    fclose(yyin);
    exit(1);
}

int main(int argc, char * argv[]){
    if (argc != 2){
        printf("Correct use of the program: ./program filename.txt\n");
        exit(1);
    }
    yyin = fopen(argv[1], "r"); 

    if (yyin == NULL){
        printf("Could not open %s.\n", argv[1]);
        exit(1);
    }
    strcpy(text_file, argv[1]);
    prog();
}
