
%{
#include "operation.h"
#include"lang_types.h"
#include <string.h>
#include <malloc.h>
#include <stdio.h>
#include "log.h"
#include "action.h"

#include "obj_writer.h"


struct block *bl;


%}

%union {
char *val;
struct ast *node;
int tokenspecific;
struct symbolset *sset;
void* (*fn)(struct operands_data*);
struct action *act;
struct block *b;
struct literal_data *cons;
struct data_access_result *dar;
struct func_call_params_set *func_params;
struct fn_param_list *func_def;

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

%type <val>  NUMBER  ADD SUB MUL DIV ABS  EOL  STATEMENT  IDENTIFIER  ASSIGN  ANY  CHARACTER_LITERAL  INCLUDE  DEFINE  DATATYPE  FUNC_NAME  FUNC_DECL  FUNC_PARAMS  FUNC_DEF  VAR_NAME  COMMA  C_O   C_C  B_O  B_C  CHAR  FLOAT  INT  AND  OR  STRUCT  FOR  WHILE  IF  THEN  ELSE  RETURN  BREAK  SWITCH CASE  SPACE  UNSIGNED  CONTINUE  SIGNED  VOID  DEFAULT  GOTO  SIZEOF  COLON  HASHS  STRING  ALPHAS  QUOTE 
%type <sset> var_s var_dec_single var_dec_options
%type <cons> literal param_list_comma_allow_blank param_list_comma

%type <act> else_part assignment_statement assignment_allow_blank for_var_init func_call
%type <fn> LT GT EXCLAIM condition_oper logical_oper
%type <b> block_code block
%type <dar> operands exp condition pred2 condition_one cond cond_allow_blank

%type <func_def> var_list_comma

%nonassoc "then"
%nonassoc "else"
%%
test: {printf("test");}
 |var_dec_sing
 ;
var_dec_sing:DATATYPE var_dec_ {  
 						 }
 ;

var_dec_:_s  IDENTIFIER EOL {
					}	
 | _s  IDENTIFIER ASSIGN literal EOL  { }
 ;
_s: %empty {}
| _s IDENTIFIER COMMA  			{
       }
 |_s IDENTIFIER ASSIGN literal  COMMA {
       }
 ;
                           
program1: { int c; scanf(" %d",&c);
		summary(&file);}
 |program1 var_dec_single 
 				{struct symbol *s;s=$2->start;
 				struct symbol *t=NULL;
    				while(s!=NULL)
    				{
    				//printf("%d",file.symcount);
    				printf("\nadding symbol:");print_symbol(s);
    				int y;
    				
    				printf("infile:");print_symbol(file.symbols); 
    				scanf(" %d",&y);
    				
    		
                           addsymbol(*s,&file,NULL);
                           
                           t=s;
                           free(t);
                           s=s->next;
                           
                           }
                           }
 |program1 function_def
 ;
program:
 |directives
 |program struct
 |program var_dec_single 
 |program function_def
 ;
directives:directives HASHS LT IDENTIFIER GT {}
 | {}
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

var_dec_options:var_s  IDENTIFIER EOL {struct symbol *t,*prev=NULL;t =$1->start;
					while(t!=NULL)
					{
					print_symbol(t);
					prev=t;
					t=t->next;
					}
					struct symbol *node;
					node=(struct symbol*)malloc(sizeof(struct symbol));
					node->name=$2;
					node->next=NULL;
					node->value=NULL;
						print_symbol(node);			
					if(prev==NULL&&t==NULL)
					{
					printf("added first");
					$1->start=node;
					
					}
					else{
					
					prev->next=node;
					}
					
					$$=$1;
					}	
 | var_s  IDENTIFIER ASSIGN literal EOL  {struct symbol *t,*prev=NULL;t =$1->start;
					while(t!=NULL)
					{
					
					prev=t;
					t=t->next;
					}
					struct symbol *node;
					node=(struct symbol*)malloc(sizeof(struct symbol));
					node->value=(struct literal_data *)malloc(sizeof(struct literal_data));
					node->name=(char *)malloc(sizeof(char)*strlen($2));
					node->name=$2;
					node->next=NULL;
				
				node->value=$4	;			
						print_symbol(node);
					if(prev==NULL&&t==NULL)
					{
					
					$1->start=node;
					
					}
					else{
					
					prev->next=node;
					}
					$$=$1; }
 ;
var_s: %empty {struct symbolset *s;s=(struct symbolset*)malloc(sizeof(struct symbolset));
       s->start=NULL;
       
       $$=s;
       
       }
| var_s IDENTIFIER COMMA  			{
                                                    
       
       struct symbol *t,*prev=NULL;t =$1->start;
					while(t!=NULL)
					{
					
					prev=t;
					t=t->next;
					}
					struct symbol *node;
					node=(struct symbol*)malloc(sizeof(struct symbol));
					node->value=(struct literal_data *)malloc(sizeof(struct literal_data)*100);
					node->name=(char *)malloc(sizeof(char)*strlen($2)+2);
					node->name=$2;
					node->next=NULL;
				
				node->value=NULL;				
					
					if(prev==NULL&&t==NULL)
					{
					
					$1->start=node;
					
					}
					else{
					
					prev->next=node;
					}
					print_symbol(node);
					$$=$1;
       }
 |var_s IDENTIFIER ASSIGN literal  COMMA {struct symbolset *s;s=(struct symbolset*)malloc(sizeof(struct symbolset));
       s->start=NULL;
       
       printf("%d",file.symcount);
       
       struct symbol *t,*prev=NULL;t =$1->start;
					while(t!=NULL)
					{
					
					prev=t;
					t=t->next;
					}
					struct symbol *node;
					node=(struct symbol*)malloc(sizeof(struct symbol));
					node->value=(struct literal_data *)malloc(sizeof(struct literal_data)*100);
					node->name=(char *)malloc(sizeof(char)*strlen($2)+2);
					node->name=$2;
					node->next=NULL;
				
				node->value=$4		;
					print_symbol(node);		
					
					if(prev==NULL&&t==NULL)
					{
					
					$1->start=node;
					
					}
					else{
					
					prev->next=node;
					}
					$$=$1;
       }
 ;

function_def:DATATYPE IDENTIFIER B_O var_list_comma B_C block {  

struct fn_sig *sig=CREATE(fn_sig);
sig->returntype=$1;
sig->name=$2;
sig->start=$4;
$6->sig=sig;
$6->name=$2;

addblock($6,&file);





}
 ;
function_dec:DATATYPE IDENTIFIER B_O var_list_comma B_C EOL  {  }
 ;
var_list_comma: { $$=NULL;}
  |var_list_comma COMMA DATATYPE IDENTIFIER { struct fn_param_list *n=CREATE(fn_param_list);
  			n->datatype=$3;
  			n->name=$4;
  			n->next=NULL;
  			$1->next=n;
  			$$=$1;	
  
  					
  					}
  |DATATYPE IDENTIFIER {     
  			struct fn_param_list *n=CREATE(fn_param_list);
  			n->datatype=$1;
  			n->name=$2;
  			$$=$1;				}
  ;
  
param_list_comma_allow_blank: {$$=NULL;}
 |param_list_comma  {$$=$1;}
 ;
param_list_comma:param_list_comma COMMA literal { $1->next=$3;
  $$=$1;
  					}
  |literal { $$=$1;
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
 
block:C_O block_code C_C {$$=$2;} 
 ;
 
block_code:  {$$=createblock(NULL,NULL,NULL,NULL,NULL,NULL);}
 |block_code var_dec_single { struct symbol *s;s=$1->sym;
    				while(s!=NULL)
    				{
                           addsymbol(*s,&file,$1);
                           
                           s=s->next;} return $1;}
 |block_code assignment_statement EOL {  struct action *p=$1->istr;
 							$2->next=p;
 							$1->istr=$2;
 							$$=$1;
 							}
 |block_code FOR B_O for_var_init EOL cond_allow_blank EOL assignment_allow_blank B_C block {
 							
 						struct action *n=createaction(createdataresult($6,NULL),for_block,createdataresult(NULL,chainaction($4,$7))); n->b=$9;
 							struct action *p=$1->istr;
 							n->next=p;
 							$1->istr=n;
 							$$=$1;
 							}
 |block_code IF B_O condition B_C block else_part {struct action *n=createaction($3,if_cond,NULL); n->b=$5;
 							struct action *p=$1->istr;
 							n->next=p;
 							$1->istr=n;
 							$$=$1;
 							}
 |block_code CONTINUE EOL {struct action *n=createaction(NULL,continue_stat,NULL);
 							struct action *p=$1->istr;
 							n->next=p;
 							$1->istr=n;
 							$$=$1;
 							}
 |block_code SWITCH B_O exp B_C C_O switch_block C_C
 |block_code BREAK EOL {struct action *n=createaction($3,brk,NULL); 
 							struct action *p=$1->istr;
 							n->next=p;
 							$1->istr=n;
 							$$=$1;
 							}
 |block_code RETURN EOL {struct action *n=createaction($3,ret,NULL); 
 							struct action *p=$1->istr;
 							n->next=p;
 							$1->istr=n;
 							$$=$1;
 							}
 |block_code func_call {
 							struct action *p=$1->istr;
 							$2->next=p;
 							$1->istr=$2;
 							$$=$1;
 							}
 ;
 
 func_call:IDENTIFIER B_O param_list_comma B_C EOL {   
 						struct data_access_result * data_result=CREATE(data_access_result);
 						data_result->data=CREATE(literal_data);
 						data_result->data->userdefined=$3;
 						struct literal_data *x=CREATE(literal_data);
 						x->str=$1;
 						struct data_access_result *data_identifier=CREATE(data_access_result);
 						data_identifier->data=x;
 						$$=createaction(data_identifier,func_call,data_result);
 							
 
 							}
  ;
switch_block:CASE literal COLON block_code switch_block
 |DEFAULT COLON block_code
 | 
 ;  
else_part:  {$$=NULL;}
 |ELSE IF B_O condition B_C block else_part  {struct action *act=createaction($4,if_cond,NULL);
 						act->b=$6;
 						act->next=$7;
 						$$=act;
 						
 						}
 |ELSE block  {struct action * els =createaction(NULL,if_cond,NULL);
 		els->b=$2;
 		els->next=NULL;
 		$$=els;
 		}
 ;
for_var_init: IDENTIFIER ASSIGN literal  {
				
				
			$$=createaction(
 			createdataresult(NULL,
 						createaction(createdataresult(createidentifier($1),NULL),
 						mem_access,
 						NULL)
 					)
 					,assign
 					,createdataresult($3,NULL));
 						}
 |IDENTIFIER ASSIGN literal COMMA for_var_init {$$=chainaction(createaction(
 			createdataresult(NULL,
 						createaction(createdataresult(createidentifier($1),NULL),
 						mem_access,
 						NULL)
 					)
 					,assign
 					,createdataresult($3,NULL)),$5);
 						}
 
 ;

assignment_allow_blank: {$$=NULL;}
 | assignment_allow_blank assignment_statement {$$=createaction(createdataresult(NULL,$1),$2,NULL);}
 | assignment_allow_blank assignment_statement COMMA {$$=createaction(createdataresult(NULL,$1),$2,NULL);}
 ;

assignment_statement:IDENTIFIER ASSIGN exp {	$$=createaction(
 			createdataresult(NULL,
 						createaction(createdataresult(createidentifier($1),NULL),mem_access,NULL)
 						),assign,$3);
 						
 						}
 |IDENTIFIER ADD ADD {	$$=createaction(
 			createdataresult(NULL,
 						createaction(createdataresult(createidentifier($1),NULL),mem_access,NULL)
 						),increment,NULL);
 						
 						}
 |IDENTIFIER SUB SUB {	$$=createaction(
 			createdataresult(NULL,
 						createaction(createdataresult(createidentifier($1),NULL),mem_access,NULL)
 						),decrement,NULL);
 						
 						}
 ;
cond_allow_blank: {$$=NULL;}
 |condition 	{$$=$1;}
 ;

logical_oper:AND AND {$$=log_and;}
 |OR OR              {$$=log_or;}
 ;

condition:condition_one logical_oper condition_one {if($1->act==NULL)
					{
					if($3->act==NULL)
					{
					$$=createdataresult(NULL,createaction($1->data,$2,$3->data));
					return;
					
					}
					else{
					$$=createdataresult(NULL,createaction($1->data,$2,$3->act));
					return;
					}
					
					}
					else{
					if($3->data==NULL)
					{
					$$=createdataresult(NULL,createaction($1->act,$2,$3->act));
					return;
					
					}
					else{
					$$=createdataresult(NULL,createaction($1->act,$2,$3->data));
					return;
					}
					
					
					}}
 |condition_one {$$=$1;}
 ;
condition_one:exp condition_oper exp { 
					if($1->act==NULL)
					{
					if($3->act==NULL)
					{
					$$=createdataresult(NULL,createaction($1->data,$2,$3->data));
					return;
					
					}
					else{
					$$=createdataresult(NULL,createaction($1->data,$2,$3->act));
					return;
					}
					
					}
					else{
					if($3->data==NULL)
					{
					$$=createdataresult(NULL,createaction($1->act,$2,$3->act));
					return;
					
					}
					else{
					$$=createdataresult(NULL,createaction($1->act,$2,$3->data));
					return;
					}
					
					
					}

					}
 |operands				{ $$=$1;}
 ;


exp:exp ADD exp { $$=createdataresult(NULL,createaction($1,add,$3));}
 |exp SUB exp { $$=createdataresult(NULL,createaction($1,sub,$3));}
 |B_O exp B_C { $$=$2;}
 |pred2        {
 
 		$$=$1;}
 ;


pred2:exp MUL exp  { $$=createdataresult(NULL,createaction($1,mul,$3));}
 |exp DIV exp  { $$=createdataresult(NULL,createaction($1,div,$3));}
 |operands {  $$=$1;    }
 ;

operands:IDENTIFIER {  $$=createdataresult(NULL,
 						createaction(createdataresult(createidentifier($1),NULL),mem_access,NULL)
 						);
 						
			
			 }
 |IDENTIFIER B_O param_list_comma B_C { $$=createdataresult(NULL,
 						createaction(createdataresult(createidentifier($1),NULL),func_call,createuserdefined($3))
 						);}
 |literal  {$$=createdataresult($1,NULL);}
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
  fprintf(stderr, "error: %s\n%s", s,yylval.val);
}

