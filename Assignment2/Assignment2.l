//Assignment 2 - A01732702 Nezih Nieto Gutiérrez
/*** Definition Section has no variable
which can be accessed inside yylex() 
and main() ***/
%{

%}
  
/*** Rule Section has three rules, first rule matches with capital letters, second rule
matches with any character except newline and 
third rule does not take input after the enter ***/
id   (([aA-zZ])[a-z0-9]*)+([A-Z][a-z0-9]*)*
digit [0-9]
int {digit}+
floaty ({digit}+[.]{digit}*)|({digit}*[.]{digit}+)
comma		","
semicol	";"
openKey	"{"
closeKey	"}"
openBrack	"["
closeBrack	"]"
plusOp		"+"
multOp		"*"
minusOp	"-"
divOp		"/"
assOp		":="
eqSym		"="
lessOp		"<"
moreOp		">"

%%
{id} {printf("Identifier '%s'!",yytext);}
{floaty} {printf("Floating point constant '%s'!",yytext);}
{int}    {printf("Integer constant '%s'!", yytext);}	
{comma}|{semicol}|{openKey}|{closeKey}|{openBrack}|{closeBrack}|{plusOp}|{multOp}|{minusOp}|{divOp}|{assOp}|{eqSym}|{lessOp}|{moreOp} {printf("Oh... symbol '%s'!", yytext);}
"do-if" {printf("Gotta be 'Do if'!");}		
"do-ifelse" {printf("Das me-lad 'Do if else'!");}
"do-while" {printf("Is that u, 'Do while'?");}
"do-until" {printf("My actual homs: 'Do until'!");}
. {printf("ERROR: Not Accepted Token\t");}
%%
/*** Code Section prints the number of
capital letter present in the given input ***/
int yywrap(){}
int main(){
  /*** This main function opens a test file, so it can be read in case it is available. 
       If you want to try any other test case, you can create another file with the text of your election.
  ***/
  yyin = fopen("test.txt", "r");
  if(yyin){  
 	  yylex();
  	fclose(yyin);
  }
  else{
    yylex();    
  } 
}
