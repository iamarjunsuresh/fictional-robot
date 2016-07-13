
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
%type <sset> var_s var_dec_single var_dec_options var_s1 var_dec_single1 var_dec_options1
%type <cons> literal param_list_comma_allow_blank param_list_comma

%type <act> else_part assignment_statement assignment_allow_blank for_var_init func_call program1 assignment_blank
%type <fn> LT GT EXCLAIM condition_oper logical_oper
%type <b> block_code block
%type <dar> operands exp condition pred2 condition_one cond_allow_blank

%type <func_def> var_list_comma list_comma

%nonassoc "then"
%nonassoc "else"
%%

prog: program1
;

test:
|test
                           
program1:  { int c;
		summary(&file);
		$$=NULL;}
 |program1 var_dec_single 
 				{struct symbol *s;s=$2->start;
 				
    				
    				//printf("%d",file.symcount);
    				/*printf("\nadding symbol:");print_symbol(s);
    				int y;
    				
    				printf("infile:");//print_symbol(file.symbols); 
    				scanf(" %d",&y);
    				
    		*/
                           addsymbol(s,&file,NULL);
                           
                           
                           $$=NULL;
                           }
                           
                           
                           
                           
 | program1 function_def {//int v; printf("func_def"); scanf(" %d", &v);
 				}
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

var_dec_single:DATATYPE var_dec_options { $2->datatype=$1;  
 						$$=$2;
 						
 						 }

 ;

var_dec_options:IDENTIFIER var_s EOL {struct symbol *t,*prev=NULL;t =$2->start;
					
					struct symbol *node;
					node=(struct symbol*)malloc(sizeof(struct symbol));
					node->name=$1;
					node->next=NULL;
					node->value=NULL;
						print_symbol(node);			
					node->next=t;
					$2->start=node;
					
					print_symbol($2->start);
					$$=$2;
					}	
 |IDENTIFIER ASSIGN literal var_s  EOL  {struct symbol *t,*prev=NULL;t =$4->start;
					
					struct symbol *node;
					node=(struct symbol*)malloc(sizeof(struct symbol));
					node->value=(struct literal_data *)malloc(sizeof(struct literal_data));
					node->name=(char *)malloc(sizeof(char)*strlen($2));
					node->name=$2;
					node->next=NULL;
				
				node->value=$3	;			
						print_symbol(node);
					
					node->next=t;
					$4->start=node;
					$$=$4; }
 ;
var_s:%empty	{struct symbolset *s;s=CREATE(symbolset);
       s->start=NULL;
       
       
       $$=s;
       
       }
       
|COMMA IDENTIFIER var_s  			{
                                                    
       
       struct symbol *t,*prev=NULL;t =$3->start;
					
					struct symbol *node;
					node=(struct symbol*)malloc(sizeof(struct symbol));
					node->value=(struct literal_data *)malloc(sizeof(struct literal_data)*100);
					node->name=(char *)malloc(sizeof(char)*strlen($2)+2);
					node->name=$2;
					node->next=NULL;
				
				node->value=NULL;				
					
					
					print_symbol(node);
					node->next=t;
					$3->start=node;
					$$=$3;
       }
 |COMMA IDENTIFIER ASSIGN literal  var_s {struct symbolset *s;s=(struct symbolset*)malloc(sizeof(struct symbolset));
       s->start=NULL;
       
       printf("%d",file.symcount);
       
       struct symbol *t,*prev=NULL;t =$5->start;
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
				
				node->value=$4;		;
					print_symbol(node);		
					
					if(prev==NULL&&t==NULL)
					{
					
					$5->start=node;
					
					}
					else{
					
					prev->next=node;
					}
					$$=$5;
       }
 ;

function_def:DATATYPE IDENTIFIER B_O var_list_comma B_C block {  
 printf("function def created");

struct fn_sig *sig=CREATE(fn_sig);
sig->returntype=$1;
sig->name=$2;
sig->start=$4;
$6->sig=sig;
$6->name=$2;
printf("root block");
print_block($6);
addblock($6,&file);





}
 ;
function_dec:DATATYPE IDENTIFIER B_O var_list_comma B_C EOL  {  }
 ;
var_list_comma: { $$=NULL;}
  |  DATATYPE IDENTIFIER  list_comma{ struct fn_param_list *n=CREATE(fn_param_list);
  			n->datatype=$1;
  			n->name=$2;
  			n->next=$3;
  			
  			$$=n;	
  
  					
}
  |
  ;
  list_comma: {$$=NULL;}
  |COMMA DATATYPE IDENTIFIER list_comma {
  
  struct fn_param_list *n=CREATE(fn_param_list);
  			n->datatype=$2;
  			n->name=$3;
  			n->next=$4;
  			
  			$$=n;	
  
  }
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
		free($1);
		$$=n;
		}
 |INT { int  i;

		sscanf(" %d",$1,&i);
		struct literal_data node;
		printf("literal-data:%d",i);
		scanf(" %d",&i);
		node.i=i;
		node.type=1;
		struct literal_data *n;n=CREATE(literal_data);*n=node;
		free($1);
		$$=n;}
 |CHAR { char ch;
		sscanf(" %c",$1,&ch);
		struct literal_data node;
		node.c=ch;
		node.type=3;
		struct literal_data *n;n=CREATE(literal_data);*n=node;
		free($1);
		$$=n;}
 |STRING { 
		struct literal_data node;
		node.str=CREAT(char,strlen($1));
		node.type=4;
		struct literal_data *n;n=CREATE(literal_data);*n=node;
		free($1);
		$$=n;}
 ;
 
block:C_O block_code C_C {

print_block($2);
$$=$2;} 
 ;
 
block_code:  {

		//printf("\nnew block created");
		
		struct block *b=createblock(NULL,NULL,NULL,NULL,NULL,NULL);
		/*print_block(b);
		
		int c;scanf(" %d",&c);*/
		$$=b;
		}
 |var_dec_single block_code { //	printf("called");
 				struct symbol *s;s=$1->start;
    				//int c;scanf(" %d",&c);
                           addsymbol(s,&file,$2);
                           print_block($2);
                           
                          // scanf(" %d",&c);
                            $$= $2;}
 | assignment_statement EOL block_code {  struct action *p=$3->istr;
 							$1->next=p;
 							$3->istr=$1;
 							$$=$3;
 							}
 |FOR B_O for_var_init EOL cond_allow_blank EOL assignment_blank B_C block block_code  {
/* printf("fors block:");print_block($9);
printf("fors parant:");print_block($10);
int c;
scanf(" %d",&c); 		*/					
 						struct action *n=createaction(createdataresult($4,NULL),for_block,createdataresult(NULL,chainaction($2,$6))); n->b=$9;
 						
 							struct action *p=$10->istr;
 							n->next=p;
 							$10->istr=n;
 							
 							$$=$10;
 							}
 | IF B_O condition B_C block else_part block_code {struct action *n=createaction($3,if_cond,NULL); n->b=$5;
 							struct action *p=$7->istr;
 							n->next=p;
 							$7->istr=n;
 							 /*printf("if block:");print_block($5);
printf("if parant:");print_block($7);int c;
scanf(" %d",&c); */
 							$$=$7;
 							}
 | CONTINUE EOL block_code {struct action *n=createaction(NULL,continue_stat,NULL);
 							struct action *p=$3->istr;
 							n->next=p;
 							$3->istr=n;
 							$$=$3;
 							}
 |SWITCH B_O exp B_C C_O switch_block C_C block_code {$$=$8;}
 | BREAK EOL  block_code{struct action *n=createaction($3,brk,NULL); 
 							struct action *p=$3->istr;
 							n->next=p;
 							$3->istr=n;
 							$$=$3;
 							}
 | RETURN EOL block_code {struct action *n=createaction($3,ret,NULL); 
 							struct action *p=$3->istr;
 							n->next=p;
 							$3->istr=n;
 							$$=$3;
 							}
 |func_call block_code  {
 							struct action *p=$2->istr;
 							$2->next=p;
 							$2->istr=$1;
 							$$=$2;
 							}
 ;
 
 func_call:IDENTIFIER B_O param_list_comma_allow_blank B_C EOL {   
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
for_var_init: { $$=NULL;}
|IDENTIFIER ASSIGN literal  {
				
				
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
assignment_blank:%empty {$$=NULL;}
|assignment_allow_blank {$$=$1;}
;
assignment_allow_blank:assignment_statement {$$=$1;}

 |  assignment_statement COMMA assignment_allow_blank {$$=chainaction($1,$3);}
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
					
					
					}
					else{
					$$=createdataresult(NULL,createaction($1->data,$2,$3->act));
					
					}
					
					}
					else{
					if($3->data==NULL)
					{
					$$=createdataresult(NULL,createaction($1->act,$2,$3->act));
					
					
					}
					else{
					$$=createdataresult(NULL,createaction($1->act,$2,$3->data));
					
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
					
					
					}
					else{
					$$=createdataresult(NULL,createaction($1->data,$2,$3->act));
					
					}
					
					}
					else{
					if($3->data==NULL)
					{
					$$=createdataresult(NULL,createaction($1->act,$2,$3->act));
					
					
					}
					else{
					$$=createdataresult(NULL,createaction($1->act,$2,$3->data));
					
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
 |IDENTIFIER B_O param_list_comma_allow_blank B_C { $$=createdataresult(NULL,
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

