#include<malloc.h>
#include"lang_types.h"

#include<string.h>

#include "parser.tab.h"
#include "operation.h"


struct ast *newast(char* str,int operation,struct ast *lc,struct ast *rc)
{
struct ast *node=(struct ast*) malloc(sizeof(struct ast));
node->val=(char*)malloc(sizeof(char)*strlen(str));
strcpy(node->val,str);
node->lc=lc;
node->rc=rc;

return node;


}
void free_ast(struct ast *s){

free(s);

}

struct ast eval(struct ast *node,struct objfile *file){
/*
if(file==NULL)
{
file=init_objfile();
}*/
switch(node->operation)
{
case T_VAR_DEC:;
	
             /*struct ast* n;
             n=node;
             struct symbol var;
             char* dtype=(char*)malloc(sizeof(char)*strlen(n->val));
             
             strcpy(dtype,n->val);
             n=n->rc;
               while(n!=NULL)
               {
               switch(n->operation)
               {
               case T_VAR_:strcpy(var.type,dtype);
               
               strcpy(var.name,n->val);
               var.type=NULL;
               var.next=NULL;
               
               addsymbol(var,file,NULL);
               n=n->rc;
               case T_VAR:
               strcpy(var.type,dtype);
               sscanf("%s|%s",var.name,var.meta);
               
               var.type=NULL;
               var.next=NULL;
               
               addsymbol(var,file,NULL);
               
               break;
               }
              n=n->rc; 
   		 }     */
		
		     break;
case T_BLOCK_DEC:;
                
			


}







}

