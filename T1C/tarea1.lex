/*** Tarea 1 

Este programa léxico reconoce la unión de los siguientes idiomas:

1. L1 = {w ∈ {a, b}∗| w comienza y termina con el mismo símbolo }.
2. L2 = {w ∈ {a, b}∗| w tiene una a en la segunda posición y una b en la cuarta posición}.

Este programa lee la entrada de la terminal e imprime "SÍ" si la entrada satisface la especificación dada del lenguaje y "no" en caso contrario.

Para compilar y ejecutar:

flex tarea1.lex;
gcc lex.yy.c;
./a.out
< >

Sergio Ivan Villegas Arenas A01625055
***/


%%

((("a"[a|b]*"a")|("b"[a|b]*"b"))|([a|b]"a"[a|b]"b"[a|b]*)) {printf("YES\n"); return 0;}

.*                   {printf("NO\n"); return 0;}

%%

int main(){
yylex();
}

int yywrap(){}