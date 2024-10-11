This is the Assignment 2 made by  A01732702 Nezih Nieto Gutiérrez. 
It should contain:
1. Source code: Assignment2.l
2. Test file: test.txt

To run the assignment properly please check that the files listed above are contained in the ZIP folder. Then run in your linux terminal the following command after having navigated to the folder of this assignment:

> lex Assignment2.l; cc lex.yy.c; ./a.out

It should show how the source code identifies and accepts every required character, and provides a response thereto. If you liked to edit the test file, you can do it, yet if a compilation without test file is wanted, you should run:

> mkdir TempTest; mv test.txt TempTest; lex Assignment2.l; cc lex.yy.c; ./a.out 

And then run...

> cd TempTest; mv test.txt ../; cd ../; rm -rf TempTest

so you can start again from the top of this README document.