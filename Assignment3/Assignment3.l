/*Assignment 3 - A01732702 Nezih Nieto Gutiérrez*/
/*** Please run with the following commands 
$> flex Assignment3.l; cc lex.yy.c; ./a.out <fileName.txt>
for example: 
$> flex Assignment3.l; cc lex.yy.c; ./a.out prueba2.txt
***/
%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<math.h>
	/* Tokens */
	#define T_ID 			1
	#define T_FLOAT 		2
	#define T_INTEGER 		3
	#define T_COMMA 		4
	#define T_SEMICOL 		5
	#define T_OPENKEY 		6
	#define T_CLOSEKEY		7
	#define T_OPENBRACK 	8
	#define T_CLOSEBRACK 	9
	#define T_OPENPAR		10
	#define T_CLOSEPAR		11
	#define T_PLUSOP		12
	#define T_MULTOP		13
	#define T_MINUSOP 		14
	#define T_DIVOP 		15
	#define T_ASSOP 		16
	#define T_EQSYM 		17
	#define T_LESSOP 		18
	#define T_MOREOP		19
	#define T_LESSOEQOP 	20
	#define T_MOREOEQOP		21
	#define T_DOIF			22
	#define T_DOIFELSE		23
	#define T_DOWHILE		24
	#define T_DOUNTIL		25
	#define T_PROGRAM		26
	#define T_BEGIN			27
	#define T_END			28
	#define T_EOF			29
	#define T_DIGIT			30
	int line = 1; 		/* line counter */
	int order = 1; 	/* identation order */
	int reader;
%}
  
/*** Rule Section has three rules, first rule matches with capital letters, second rule matches with any character except newline and  third rule does not take input after the enter ***/
id   		(([aA-zZ])[a-z0-9]*)+([A-Z][a-z0-9]*)*
digit 		[0-9]
integer 	{digit}+
float 		({digit}+[.]{digit}*)|({digit}*[.]{digit}+)

%%
{float}			{return T_FLOAT;} 
{integer}   	{return T_INTEGER;} 
","				{return T_COMMA;}
";"				{return T_SEMICOL;}
"{"				{return T_OPENKEY;}
"}"				{return T_CLOSEKEY;}
"["				{return T_OPENBRACK;}
"]"				{return T_CLOSEBRACK;}
"("				{return T_OPENPAR;}
")"				{return T_CLOSEPAR;}
"+"				{return T_PLUSOP;}
"*"				{return T_MULTOP;}
"-"				{return T_MINUSOP;}
"/"				{return T_DIVOP;}
":="			{return T_ASSOP;}
"="				{return T_EQSYM;}
"<"				{return T_LESSOP;}
">"				{return T_MOREOP;}
"=<"|"<="		{return T_LESSOEQOP;}
"=>"|">="		{return T_MOREOEQOP;}
"do-if" 		{return T_DOIF;}	
"do-ifelse"		{return T_DOIFELSE;}
"do-while" 		{return T_DOWHILE;}
"do-until" 		{return T_DOUNTIL;}
"program"		{return T_PROGRAM;}
"begin"			{return T_BEGIN;}
"end"			{return T_END;}
"\n"			{line++;order=1;}
"\t"			{order++;}
{id}			{return T_ID;}
"<<EOF>>"		{return T_END;}	
. 
%%

/* grammar functions definition */

void prog();
void stmt();
void opt_stmts();
void stmt_lst();
void expr();
void term();
void factor();
void expression();
void error();

/*** Code Section prints the number of
capital letter present in the given input ***/
int yywrap(){}

void prog(){
	reader = yylex();
	if(reader == T_PROGRAM){
		reader = yylex();
		if(reader == T_ID){
			reader = yylex();
			if(reader == T_BEGIN){        
				reader = yylex();
				opt_stmts();
				printf("DOPEST CODE EVER.\n");
				fclose(yyin);
			} else {fclose(yyin);printf("MISSING BEGIN RESERVED WORD FOR PROGRAM...\n");error();}
		} else {fclose(yyin);printf("MISSING PROGRAM'S ID...\n");error();}
	} else {fclose(yyin);printf("MISSING PROGRAM RESERVED WORD...\n");error();}			
}

void stmt(){

  switch(reader){

    case T_ID:
		reader=yylex();
		//printf("TOKEN #%d\n",reader);
		if(reader==T_ASSOP){
			//printf("TOKEN #%d\n",reader);
			reader=yylex();
			expr();
			return;
		}else{printf("MISSING ASSIGNATION OPERAND FOR ID STATEMENT...\n");error();}
    	break;
    
    case T_DOIF:
		reader=yylex();
		
		if(reader==T_OPENPAR){
			reader = yylex();
			expression();
			//reader=yylex();
			if(reader==T_CLOSEPAR){
				reader=yylex();
				//printf("TOKEN #%d\n",reader);
				if(reader==T_OPENBRACK){
						
					reader=yylex();
					
					opt_stmts();
					//printf("TOKEN #%d\n",reader);
					//reader=yylex();
					if(reader==T_CLOSEBRACK){
						return;
					} else{printf("MISSING CLOSE BRACKET FOR DO-IF STATEMENT...\n");}
				} else {printf("MISSING OPEN BRACKET FOR DO-IF STATEMENT...\n");}
			} else {printf("MISSING CLOSE PARENTHESIS FOR DO-IF STATEMENT...\n");}
		} else {printf("MISSING OPEN PARENTHESIS FOR DO-IF STATEMENT...\n");}
    	break;
      
    case T_DOIFELSE:
		reader=yylex();
		if(reader==T_OPENPAR){
			reader = yylex();
			expression();
			//reader=yylex();
			if(reader==T_CLOSEPAR){
				reader=yylex();
				//printf("TOKEN #%d\n",reader);
				if(reader==T_OPENBRACK){		
					reader=yylex();
					opt_stmts();
					//printf("TOKEN #%d\n",reader);
					//reader=yylex();
					if(reader==T_CLOSEBRACK){
						reader=yylex();
						if(reader==T_OPENBRACK){							
							reader=yylex();
							opt_stmts();
							//printf("TOKEN #%d\n",reader);
							//reader=yylex();
							if(reader==T_CLOSEBRACK){
								return;
							} else{printf("MISSING CLOSE BRACKET FOR DO-IFELSE STATEMENT...\n");}
						} else {printf("MISSING OPEN BRACKET FOR DO-IFELSE STATEMENT...\n");}
					} else{printf("MISSING CLOSE BRACKET FOR DO-IFELSE STATEMENT...\n");}
				} else {printf("MISSING OPEN BRACKET FOR DO-IFELSE STATEMENT...\n");}
			} else {printf("MISSING CLOSE PARENTHESIS FOR DO-IFELSE STATEMENT...\n");}
		} else {printf("MISSING OPEN PARENTHESIS FOR DO-IFELSE STATEMENT...\n");}
		break;
	      
    case T_DOUNTIL:
		reader=yylex();
		if(reader==T_OPENPAR){
			reader = yylex();
			expression();
			//reader=yylex();
			if(reader==T_CLOSEPAR){
				reader=yylex();
				//printf("TOKEN #%d\n",reader);
				if(reader==T_OPENBRACK){
						
					reader=yylex();
					
					opt_stmts();
					//printf("TOKEN #%d\n",reader);
					//reader=yylex();
					if(reader==T_CLOSEBRACK){
						return;
					} else{printf("MISSING CLOSE BRACKET FOR DO-UNTIL STATEMENT...\n");}
				} else {printf("MISSING OPEN BRACKET FOR DO-UNTIL STATEMENT...\n");}
			} else {printf("MISSING CLOSE PARENTHESIS FOR DO-UNTIL STATEMENT...\n");}
		} else {printf("MISSING OPEN PARENTHESIS FOR DO-UNTIL STATEMENT...\n");}		
		break;  
      
    case T_DOWHILE:
		reader=yylex();
		if(reader==T_OPENPAR){
			reader = yylex();
			expression();
			//reader=yylex();
			if(reader==T_CLOSEPAR){
				reader=yylex();
				//printf("TOKEN #%d\n",reader);
				if(reader==T_OPENBRACK){			
					reader=yylex();
					opt_stmts();
					//printf("TOKEN #%d\n",reader);
					//reader=yylex();
					if(reader==T_CLOSEBRACK){
						return;
					} else{printf("MISSING CLOSE BRACKET FOR DO-WHILE STATEMENT...\n");}
				} else {printf("MISSING OPEN BRACKET FOR DO-WHILE STATEMENT...\n");}
			} else {printf("MISSING CLOSE PARENTHESIS FOR DO-WHILE STATEMENT...\n");}
		} else {printf("MISSING OPEN PARENTHESIS FOR DO-WHILE STATEMENT...\n");}    	
		break;	
     }
}

void opt_stmts(){
	//printf("TOKEN #%d\n",reader);
	if(reader == T_ID || reader == T_DOIF || reader ==  T_DOWHILE || reader == T_DOUNTIL || reader == T_DOIFELSE  || reader == T_BEGIN) stmt_lst();
	else if(reader == T_END) return;
	else {error();}
}


void stmt_lst(){
	
	if(reader == T_ID || reader == T_DOIF || reader ==  T_DOWHILE || reader == T_DOUNTIL || reader == T_DOIFELSE  || reader == T_BEGIN) stmt();
	else error();
	//printf("TOKEN #%d\n",reader);
	if(reader == T_SEMICOL){
	reader = yylex();
	stmt_lst();
	}
	else if(reader == T_END||reader==T_CLOSEBRACK) return;
	else error();

}

void expr(){
	//printf("TOKEN #%d\n",reader);
	
	if(reader == T_ID || reader == T_FLOAT || reader == T_OPENPAR || reader == T_INTEGER) term();
	
	if (reader == T_END || reader == T_SEMICOL|| reader == T_EQSYM || reader == T_LESSOP || reader == T_LESSOEQOP || reader == T_MOREOEQOP || reader == T_MOREOP || reader == T_CLOSEPAR || reader == T_CLOSEBRACK) {return;}
	else{
		reader = yylex();
		if(reader == T_ID || reader == T_FLOAT || reader == T_OPENPAR || reader == T_INTEGER) expr();
		else error();
	}
}


void term(){

  if(reader == T_ID || reader == T_FLOAT || reader == T_OPENPAR || reader == T_INTEGER) factor();

	reader = yylex();
	//printf("TOKEN #%d\n",reader);
	//printf("TOKEN #%d\n",reader);
  if(reader==T_MULTOP || reader==T_DIVOP){
    reader = yylex();
    term();
  }
  else if (reader == T_SEMICOL || reader ==  T_END|| reader == T_EQSYM || reader == T_LESSOP || reader == T_LESSOEQOP || reader == T_MOREOEQOP || reader == T_MOREOP || reader == T_CLOSEPAR || reader == T_CLOSEBRACK || reader==T_PLUSOP || reader==T_MINUSOP){return;}
  else error();


}


void factor(){
  //printf("TOKEN #%d\n",reader);
  if(reader == T_OPENPAR){
    reader = yylex();
    expr();
    if(reader == T_CLOSEPAR) return;
    else error();
  }
  else if(reader == T_FLOAT || reader == T_INTEGER || reader == T_ID) return;
  else error();
}

void expression(){
  
  expr();
  
  reader = yylex();
  if(reader == T_ID || reader == T_FLOAT || reader == T_OPENPAR || reader == T_INTEGER) {expr();}
  else error();
}

void error(){
  printf("SYNTAX_ERROR[%d,%d]: Error in line %d and identation order %d\n.", line, order, line,order);
  printf("TOKEN #%d not working...\n",reader);
  exit(-1);
}

 /*** This main function opens a test file, so it can be read in case it is available. 
       If you want to try any other test case, you can create another file with the text of your election.
  ***/
int main(int argc, char **argv) {
  ++argv, --argc;
  if(argc > 0)
    yyin = fopen(argv[0], "r");
  else
    yyin = stdin;  
  if(yyin == NULL){
    printf("ERROR: MISSING FILE\n");
    exit(1);
  }
  
  prog();
  yyterminate();
}
