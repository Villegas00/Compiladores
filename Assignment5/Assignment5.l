/* Archivo con el reconocedor léxico para la calculadora */
%{
	#include	<stdio.h>
	#include	<stdlib.h>
	#include	<math.h>
	#include	"Assignment5.tab.h"
	/* Tokens */
	/*#define	T_ID 			1
	#define	T_FLOAT 		2
	#define	T_INTEGER 		3
	#define	T_COMMA 		4
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
	#define T_MODOP			30
	#define T_POWOP			31
	#define T_COLON			32
	#define T_READ			33
	#define T_PRINT			34*/
	int line = 1; 		/* line counter */
	int order = 1; 	/* identation order */
	int reader;
%}
  
/*** Rule Section has three rules, first rule matches with capital letters, second rule matches with any character except newline and  third rule does not take input after the enter ***/
digit 		[0-9]
integer 	{digit}+
float 		({digit}+[.]{digit}*)|({digit}*[.]{digit}+)
id   		(([aA-zZ])[a-z0-9]*)+([A-Z][a-z0-9]*)*
%%
"float"			{return T_FLOAT;} 
"int"   		{return T_INTEGER;} 
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
"%"				{return T_MODOP;}
"^"				{return T_POWOP;}
":"				{return T_COLON;}
"read"			{return T_READ;}
"print"			{return T_PRINT;}
"<<EOF>>"		{return T_END;}
"\n"			{line++;order=1;}
"\t"|" "		{order++;}	
{id}*			{return T_ID;}
.
%%
