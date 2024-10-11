/*** Definition Section has no variable
which can be accessed inside yylex() 
and main() ***/
%{

%}
  
/*** Rule Section has three rules, first rule 
matches with capital letters, second rule
matches with any character except newline and 
third rule does not take input after the enter***/
	
L1	("a"[a|b]*"a")|("b"[a|b]*"b")
L2	([a|b]"a"[a|b]"b"[a|b]*)

%%
{L1}|{L2} {
	printf("YES!\n\tYES!\n\t\tYES!\n\t\t\tYES!\n\t\t\t\tYES!\n"); 
	return 0;
}

. {	printf("NO!\n\tNO!\n\t\tNO!\n\t\t\tNO!\n\t\t\t\tNO!\n"); 
	return 0;}
%%
  
/*** Code Section prints the number of
capital letter present in the given input***/
int yywrap(){}
int main(){
yylex();
}
