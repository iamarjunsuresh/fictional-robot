/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NUMBER = 258,
    ADD = 259,
    SUB = 260,
    MUL = 261,
    DIV = 262,
    ABS = 263,
    EOL = 264,
    STATEMENT = 265,
    IDENTIFIER = 266,
    ASSIGN = 267,
    ANY = 268,
    CHARACTER_LITERAL = 269,
    INCLUDE = 270,
    DEFINE = 271,
    DATATYPE = 272,
    FUNC_NAME = 273,
    FUNC_DECL = 274,
    FUNC_PARAMS = 275,
    FUNC_DEF = 276,
    VAR_NAME = 277,
    COMMA = 278,
    C_O = 279,
    C_C = 280,
    B_O = 281,
    B_C = 282,
    CHAR = 283,
    FLOAT = 284,
    INT = 285,
    AND = 286,
    OR = 287,
    STRUCT = 288,
    FOR = 289,
    WHILE = 290,
    IF = 291,
    THEN = 292,
    ELSE = 293,
    RETURN = 294,
    BREAK = 295,
    SWITCH = 296,
    EXCLAIM = 297,
    CASE = 298,
    SPACE = 299,
    UNSIGNED = 300,
    CONTINUE = 301,
    SIGNED = 302,
    VOID = 303,
    DEFAULT = 304,
    GOTO = 305,
    SIZEOF = 306,
    GT = 307,
    LT = 308,
    COLON = 309,
    HASHS = 310,
    STRING = 311,
    ALPHAS = 312,
    QUOTE = 313
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 18 "parser.y" /* yacc.c:1909  */

char *val;
struct ast *node;
int tokenspecific;
struct symbolset *sset;
void* (*action)(void*);
struct block *b;
struct literal_data *cons;
struct data_access_result *dar;
struct func_call_params_set *func_params;


#line 126 "parser.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
