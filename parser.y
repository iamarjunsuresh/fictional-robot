
%{
#include "operation.h"
#include"lang_types.h"
#include <string.h>
#include <malloc.h>
#include <stdio.h>
#include "log.h"

#include "obj_writer.h"


struct block *bl;


%}

%union {
char *val;
struct ast *node;
int tokenspecific;
struct symbolset *sset;
void* (*action)(void*);
struct block *b;
struct literal_data *cons;
struct data_access_result *dar;
struct func_call_params_set *func_params;

}
/* declare tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token STATEMENT
%token IDENTIFIER
%token ASSIGN
%token ANY
%token CHARACTER_LITERAL
%token INCLUDE
%token DEFINE
%token DATATYPE
%token FUNC_NAME
%token FUNC_DECL
%token FUNC_PARAMS
%token FUNC_DEF
%token VAR_NAME
%token COMMA
%token C_O

%token C_C
%token B_O
%token B_C
%token CHAR
%token FLOAT
%token INT
%token AND
%token OR
%token STRUCT
%token FOR
%token WHILE
%token IF
%token THEN
%token ELSE
%token RETURN
%token BREAK
%token SWITCH
%token EXCLAIM
%token CASE
%token SPACE
%token UNSIGNED
%token CONTINUE
%token SIGNED
%token VOID
%token DEFAULT
%token GOTO
%token SIZEOF
%token GT
%token LT
%token COLON
%token HASHS
%token STRING
%token ALPHAS
%token QUOTE

%type <val>  NUMBER  ADD SUB MUL DIV ABS  EOL  STATEMENT  IDENTIFIER  ASSIGN  ANY  CHARACTER_LITERAL  INCLUDE  DEFINE  DATATYPE  FUNC_NAME  FUNC_DECL  FUNC_PARAMS  FUNC_DEF  VAR_NAME  COMMA  C_O   C_C  B_O  B_C  CHAR  FLOAT  INT  AND  OR  STRUCT  FOR  WHILE  IF  THEN  ELSE  RETURN  BREAK  SWITCH  EXCLAIM  CASE  SPACE  UNSIGNED  CONTINUE  SIGNED  VOID  DEFAULT  GOTO  SIZEOF  COLON  HASHS  STRING  ALPHAS  QUOTE 
%type <sset> var_s var_dec_single var_dec_options
%type <cons> literal
%type <action> condition_oper
%type <b> block_code
%type <dar> operands
%type <func_params> param_list_comma
%nonassoc "then"
%nonassoc "else"
%%
test:
 |test var_dec_single {	 
 
 				struct symbol *s;s=$2->start;
 				
    				while(s!=NULL)
    				{
    				//printf("%d",file.symcount);
                           addsymbol(*s,&file,NULL);
                           
                           s=s->next;}
                           }
 ;

program:
 |directives 
 |program struct
 |program var_dec_single 
 |program function_def  
 ;
directives:directives HASHS LT IDENTIFIER GT {LOGI("%s",$4);}
 |
 ;
struct:
 |struct STRUCT C_O struct_vars C_C
 ;
struct_vars:
 |struct_vars var_dec_single
 ;

 var_dec_single:DATATYPE var_dec_options {  $2->datatype=$1;  
 						$$=$2;
 						 }
 ;
var_dec_options: IDENTIFIER var_s {struct symbol *t,*prev;t =$2->start;
					while(t!=NULL)
					{
					
					prev=t;
					t=t->next;
					}
					struct symbol *node;
					node=(struct symbol*)malloc(sizeof(struct symbol));
					node->name=$1;
					node->next=NULL;
					node->value=NULL;			
					if(prev==NULL&&t==NULL)
					{
					
					$2->start=node;
					
					}
					else{
					
					prev->next=node;
					}
					$$=$2;
					}	
 |IDENTIFIER ASSIGN literal var_s {struct symbol *t,*prev;t =$4->start;
					while(t!=NULL)
					{
					
					prev=t;
					t=t->next;
					}
					struct symbol *node;
					node=(struct symbol*)malloc(sizeof(struct symbol));
					node->value=(char *)malloc(sizeof(char)*100);
					node->name=(char *)malloc(sizeof(char)*strlen($1));
					node->name=$1;
					node->next=NULL;
					char lit[1000];
					switch($3->type)
					{
					case 0: sprintf(lit,"%i",$3->i);break;
					case 1: sprintf(lit,"%f",$3->f);break;
					case 2: sprintf(lit,"%c",$3->c);break;
					case 3: sprintf(lit,"%s",$3->str);break;
					}
					strcpy(node->value,lit);				
					
					if(prev==NULL&&t==NULL)
					{
					
					$4->start=node;
					
					}
					else{
					
					prev->next=node;
					}
					$$=$4; }
 ;
var_s:COMMA var_dec_options { $$=$2; }
 |EOL {struct symbolset *s;s=(struct symbolset*)malloc(sizeof(struct symbolset));
       s->start=NULL;
       
       printf("%d",file.symcount);
       $$=s;
       }
 ;
function_def:DATATYPE IDENTIFIER B_O var_list_comma B_C block { }
 ;
function_dec:DATATYPE IDENTIFIER B_O var_list_comma B_C EOL
 ;
var_list_comma:
  |var_list_comma COMMA DATATYPE IDENTIFIER
  |DATATYPE IDENTIFIER
  ;
param_list_comma: 
  |param_list_comma COMMA literal { struct func_call_params var=CREATE(func_call_params);
  				var->type=$3->type;
      				switch($3->type)
      				{
      				case 0;var->param=&($3->i);break;
      				
      				case 1;var->param=&($3->f);break;
      				case 2;var->param=&($3->c);break;
      				case 3;var->param=&($3->str);break;
      				
      				case 4;var->param=&($3->userdefined);break;
      				}
      				struct func_call_params *t,*prev;
      				t=$1->start;
      				
      				while(t!=null)
      				{prev=t;
      				t=t->next;}
      				prev->next=var;
      				$$=$1;
  
  					}
  |literal { 
  
  struct func_call_params_set set=CREATE(func_call_params_set);
  
  
  struct func_call_params var=CREATE(func_call_params);
  				var->type=$1.type;
      				switch($1.type)
      				{
      				case 0;var->param=&($1.i);break;
      				
      				case 1;var->param=&($1.f);break;
      				case 2;var->param=&($1.c);break;
      				case 3;var->param=&($1.str);break;
      				
      				case 4;var->param=&($1.userdefined);break;
      				}
      				set->start=var;
      				$$=set;
      		}
  ;
  
literal:FLOAT { 
		
		float f;
		sscanf("%f",$1,&f);
		struct literal_data node;
		node.f=f;
		node.type=2;
		struct literal_data *n;n=CREATE(literal_data);*n=node;
		$$=n;
		}
 |INT { int  i;
		sscanf("%d",$1,&i);
		struct literal_data node;
		node.i=i;
		node.type=1;
		struct literal_data *n;n=CREATE(literal_data);*n=node;
		$$=n;}
 |CHAR { char ch;
		sscanf("%c",$1,&ch);
		struct literal_data node;
		node.c=ch;
		node.type=3;
		struct literal_data *n;n=CREATE(literal_data);*n=node;
		$$=n;}
 |STRING { 
		struct literal_data node;
		node.str=CREAT(char,strlen($1));
		node.type=4;
		struct literal_data *n;n=CREATE(literal_data);*n=node;
		$$=n;}
 ;
 
block:C_O block_code C_C 
 ;
 
block_code:  {bl=(struct block*)malloc(sizeof(struct block));
		$$=bl;}
 |block_code var_dec_single { struct symbol *s;s=$1->start;
    				while(s!=NULL)
    				{
                           addsymbol(*s,&file,NULL);
                           
                           s=s->next;} return $1;}
 |block_code assignment_statement EOL { }
 |block_code FOR B_O for_var_init EOL cond_allow_blank EOL assignment_allow_blank B_C block
 |block_code IF B_O condition B_C block else_part
 |block_code CONTINUE EOL
 |block_code SWITCH B_O exp B_C C_O switch_block C_C
 |block_code BREAK EOL
 |block_code RETURN EOL
 |block_code func_call
 ;
 
 func_call:IDENTIFIER B_O param_list_comma B_C EOL {LOGI("fn called");}
  ;
switch_block:CASE literal COLON block_code switch_block
 |DEFAULT COLON block_code
 | 
 ;  
else_part: 
 |ELSE IF B_O condition B_C block else_part  
 |ELSE block  
 ;
for_var_init:
 |for_var_init IDENTIFIER ASSIGN literal
 |for_var_init IDENTIFIER ASSIGN literal COMMA
 ;

assignment_allow_blank:
 |assign_coma
 ;
assign_coma:assignment_statement COMMA assignment_allow_blank
  |assignment_statement
  ;
assignment_statement:IDENTIFIER ASSIGN exp 
 |IDENTIFIER ADD ADD
 |IDENTIFIER SUB SUB
 ;
cond_allow_blank:
 |condition 
 ;

logical_oper:AND AND
 |OR OR
 ;

condition:condition_one logical_oper condition_one
 |condition_one
 ;
condition_one:exp condition_oper exp
 |operands
 ;


exp:exp ADD exp
 |exp SUB exp
 |B_O exp B_C
 |pred2
 ;


pred2:exp MUL exp
 |exp DIV exp
 |operands
 ;

operands:IDENTIFIER {  struct data_access_result * s;
			s=(struct data_access_result*)malloc(sizeof(struct data_access_result));
			s->literal_data=NULL;
			s->act=(struct action *)malloc(sizeof(struct action));
			s->act->f=mem_access;
			s->act->data=$1;
			$$=s;
			
			 }
 |IDENTIFIER B_O param_list_comma B_C { struct data_access_result * s;
			s=(struct data_access_result*)malloc(sizeof(struct data_access_result));
			s->literal_data=NULL;
			s->act=(struct action *)malloc(sizeof(struct action));
			s->act->f=func_call;
			s->act->data=$1;
			$$=s; }
 |literal  {$$=$1;}
 ;

condition_oper:ASSIGN ASSIGN { $$=equal;}
 |EXCLAIM ASSIGN {$$=ntequal;}
 |GT {$$=gt;}
 |LT {$$=lt;}
 |LT ASSIGN {$$=lte;}
 |GT ASSIGN {$$=gte;}
 ;
%%

yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}

