/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_ASSIGNMENT5_TAB_H_INCLUDED
# define YY_YY_ASSIGNMENT5_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    T_FLOAT = 258,                 /* T_FLOAT  */
    T_INTEGER = 259,               /* T_INTEGER  */
    T_COMMA = 260,                 /* T_COMMA  */
    T_SEMICOL = 261,               /* T_SEMICOL  */
    T_OPENKEY = 262,               /* T_OPENKEY  */
    T_CLOSEKEY = 263,              /* T_CLOSEKEY  */
    T_OPENBRACK = 264,             /* T_OPENBRACK  */
    T_CLOSEBRACK = 265,            /* T_CLOSEBRACK  */
    T_OPENPAR = 266,               /* T_OPENPAR  */
    T_CLOSEPAR = 267,              /* T_CLOSEPAR  */
    T_PLUSOP = 268,                /* T_PLUSOP  */
    T_MULTOP = 269,                /* T_MULTOP  */
    T_MINUSOP = 270,               /* T_MINUSOP  */
    T_DIVOP = 271,                 /* T_DIVOP  */
    T_ASSOP = 272,                 /* T_ASSOP  */
    T_EQSYM = 273,                 /* T_EQSYM  */
    T_LESSOP = 274,                /* T_LESSOP  */
    T_MOREOP = 275,                /* T_MOREOP  */
    T_LESSOEQOP = 276,             /* T_LESSOEQOP  */
    T_MOREOEQOP = 277,             /* T_MOREOEQOP  */
    T_DOIF = 278,                  /* T_DOIF  */
    T_DOIFELSE = 279,              /* T_DOIFELSE  */
    T_DOWHILE = 280,               /* T_DOWHILE  */
    T_DOUNTIL = 281,               /* T_DOUNTIL  */
    T_PROGRAM = 282,               /* T_PROGRAM  */
    T_BEGIN = 283,                 /* T_BEGIN  */
    T_END = 284,                   /* T_END  */
    T_EOF = 285,                   /* T_EOF  */
    T_MODOP = 286,                 /* T_MODOP  */
    T_POWOP = 287,                 /* T_POWOP  */
    T_COLON = 288,                 /* T_COLON  */
    T_READ = 289,                  /* T_READ  */
    T_PRINT = 290,                 /* T_PRINT  */
    T_ID = 291                     /* T_ID  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_ASSIGNMENT5_TAB_H_INCLUDED  */
