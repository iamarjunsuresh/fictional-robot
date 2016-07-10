   /* recognize tokens for the calculator and print them out */

%{
  #include <malloc.h>
  #include"lang_types.h"
  #include<string.h>
  #include "parser.tab.h"
#include "log.h"
  char* memcreate(char* source,int n);
void scan_string(const char* s);

%}

QUOTE "\""
HASHS "#include"
Alphas [a-zA-Z]*
identifier_regex [a-zA-Z]*
datatypes (int|float|char)

number_regex [0-9]+

SEMICOLON ";"
EOL ";"

OPEN_BRACE "("
CLOSE_BRACE ")"
OPEN_CURLY "{"
CLOSE_CURLY "}"
COMMA ","
COLON ":"

STRUCT "struct"
FOR "for"
WHILE "while"
IF "if"
THEN "then"
ELSE "else"
RETURN "return"
BREAK "break"
SWITCH "switch"

CASE "case"

UNSIGNED "unsigned"
CONTINUE "continue"
SIGNED "signed"
VOID "void"
DEFAULT "default"
GOTO "goto"
SIZEOF "sizeof"

%s Q OUTER

%%

{COMMA}  {printf("return,");return COMMA;}
{EOL}  {printf("return;");return EOL;}
{QUOTE} {BEGIN(Q);
        }

<Q>[\"] {yylval.val=memcreate(yytext,yyleng);BEGIN(OUTER);return STRING;}
<Q>{QUOTE} {BEGIN(OUTER);}
{STRUCT} {return STRUCT;}
"{" {return C_O;}
"}" {return C_C;}
"(" {return B_O;}
")" {return B_C;}
"|" {return OR;}
"&" {return AND;}
{FOR} {return FOR;}
{WHILE} {return WHILE;}
{IF} {return IF;}
"default" {return DEFAULT;}
{ELSE} {return ELSE;}
{RETURN} {return RETURN;}
{BREAK} {return BREAK;}
{SWITCH} {return SWITCH;}
{CASE} {return CASE;}
{UNSIGNED} {return UNSIGNED;}
{CONTINUE} {return CONTINUE ;}
{SIGNED} {return SIGNED;}
{VOID} {return VOID;}

{GOTO} {return GOTO;}
{SIZEOF} {return SIZEOF;}
{COLON} {return COLON;}
{HASHS} {return HASHS;}

{datatypes} {yylval.val=memcreate(yytext,yyleng);
		printf("Enter datatype:");		
		return DATATYPE; } 


{identifier_regex} {yylval.val=memcreate(yytext,yyleng);
				
				return IDENTIFIER;}

"'"[a-zA-Z0-9]"'" {yylval.val=memcreate(yytext+1,yyleng-2);return CHAR;}






">" {return GT;}
"<" {return LT;}
"!" {return EXCLAIM;}
"=" {printf("assign send");return ASSIGN;}
"+"    { return ADD; }
"-"    { return SUB; }
"*"    { return MUL; }
"/"    { return DIV; }


[0-9]+ { yylval.val =memcreate(yytext,yyleng);return INT; }
[0-9]+"."[0-9]*"f" {yylval.val=memcreate(yytext,yyleng);return FLOAT;}



[ \t]  {/* ignore whitespace */ }
.      { printf("Mystery character %c\n", *yytext); return ANY;}

%%

char* memcreate(char* source,int n)
{

char* mem=(char*)malloc(sizeof(char)*n+1);	
		 strncpy(mem,source,n);
return mem;

}
void scan_string(const char* str)
{
yy_scan_string(str);
    yyparse();
    
    yylex_destroy();
    return ;
  
 /*  
  yyscan_t scanner;
    YY_BUFFER_STATE buf;
    yylex_init(&scanner);
    buf = yy_scan_string(str, scanner);
    yylex(scanner);
    yy_delete_buffer(buf, scanner);
    yylex_destroy(scanner);
    return;*/
}


