#include "action.h"
#include "operation.h"
#include <stddef.h>
#include <malloc.h>
#include "interpreter.h"





void* equal(struct operands_data *data)
{
if(((struct literal_data *)data->data1)->type!=((struct literal_data *)data->data2)->type)
{
error("datatype not same");


return NULL;}
struct literal_data *lit=CREATE(literal_data);lit->type=1;
struct literal_data *d1=(struct literal_data *)data->data1;

struct literal_data *d2=(struct literal_data *)data->data2;
lit->next=NULL;
switch(d1->type)
{
case 1:;

lit->i=(d1->i==d2->i)==1?1:0;

return lit; 
case 2:;

lit->i=(d1->f==d2->f)==1?1:0;

return lit; 
case 3:;

lit->i=(d1->c==d2->c)==1?1:0;

return lit; 
case 4:;

lit->i=strcmp(d1->str,d2->str)==0?1:0;

return lit; 

}
}

void *log_or(struct operands_data *data){return NULL;}
void *log_and(struct operands_data *data){return NULL;}

void *increment(struct operands_data *data){return NULL;}
void *decrement (struct operands_data *data){return NULL;}
void *assign (struct operands_data *data){


struct symbol *s=(struct symbol *)(data->data1);
struct literal_data* temp=s->value;

s->value=(struct literal_data*)data->data2;

free(temp);
}
void *mem_access(struct operands_data *data){

if(checkdefined((char*)(((struct literal_data*)data->data1)->str),current_blk)==0)
{
printf("error symbol undefined :%s",(char*)data->data1);
return NULL; //error
}
struct symbol *s=getsymbol((char*)(((struct literal_data*)data->data1)->str),current_blk);
//print_symbol(s);



return s;








}
void *ntequal(struct operands_data *data)
{
if(((struct literal_data *)data->data1)->type!=((struct literal_data *)data->data2)->type)
{
error("datatype not same");


return NULL;}
struct literal_data *lit=CREATE(literal_data);lit->type=1;
struct literal_data *d1=(struct literal_data *)data->data1;

struct literal_data *d2=(struct literal_data *)data->data2;
lit->next=NULL;
switch(d1->type)
{
case 1:;

lit->i=(d1->i!=d2->i)==1?1:0;

return lit; 
case 2:;

lit->i=(d1->f!=d2->f)==1?1:0;

return lit; 
case 3:;

lit->i=(d1->c!=d2->c)==1?1:0;

return lit; 
case 4:;

lit->i=strcmp(d1->str,d2->str)!=0?1:0;

return lit; 

}

}
void *func_call(struct operands_data *data){return NULL;}

void *func_def(struct operands_data *data){return NULL;}



void *lte(struct operands_data *data)
{
if(((struct literal_data *)data->data1)->type!=((struct literal_data *)data->data2)->type)
{
error("datatype not same");


return NULL;}
struct literal_data *lit=CREATE(literal_data);lit->type=1;
struct literal_data *d1=(struct literal_data *)data->data1;

struct literal_data *d2=(struct literal_data *)data->data2;
lit->next=NULL;
switch(d1->type)
{
case 1:;

lit->i=(d1->i<=d2->i)==1?1:0;

return lit; 
case 2:;

lit->i=(d1->f<=d2->f)==1?1:0;

return lit; 
case 3:;

lit->i=(d1->c<=d2->c)==1?1:0;

return lit; 
case 4:;

lit->i=strcmp(d1->str,d2->str)<0?1:0;

return lit; 


}
}



void *gte(struct operands_data *data)
{
if(((struct literal_data *)data->data1)->type!=((struct literal_data *)data->data2)->type)
{
error("datatype not same");


return NULL;}
struct literal_data *lit=CREATE(literal_data);lit->type=1;
struct literal_data *d1=(struct literal_data *)data->data1;

struct literal_data *d2=(struct literal_data *)data->data2;
lit->next=NULL;
switch(d1->type)
{
case 1:;

lit->i=(d1->i>=d2->i)==1?1:0;

return lit; 
case 2:;

lit->i=(d1->f>=d2->f)==1?1:0;

return lit; 
case 3:;

lit->i=(d1->c>=d2->c)==1?1:0;

return lit; 
case 4:;

lit->i=strcmp(d1->str,d2->str)>=0?1:0;

return lit; 

}

}



void *gt(struct operands_data *data)
{
if(((struct literal_data *)data->data1)->type!=((struct literal_data *)data->data2)->type)
{
error("datatype not same");


return NULL;}
struct literal_data *lit=CREATE(literal_data);lit->type=1;lit->type=1;
struct literal_data *d1=(struct literal_data *)data->data1;

struct literal_data *d2=(struct literal_data *)data->data2;
lit->next=NULL;
switch(d1->type)
{
case 1:;

lit->i=(d1->i>d2->i)==1?1:0;

return lit; 
case 2:;

lit->i=(d1->f>d2->f)==1?1:0;

return lit; 
case 3:;

lit->i=(d1->c>d2->c)==1?1:0;

return lit; 
case 4:;

lit->i=strcmp(d1->str,d2->str)>0?1:0;

return lit; 

}

}void *for_block(struct operands_data *data){return NULL;}
void *ret(struct operands_data *data){return NULL;}
void *brk(struct operands_data *data){return NULL;}
void *add(struct operands_data *data){


if(((struct literal_data *)data->data1)->type!=((struct literal_data *)data->data2)->type)
{
error("datatype not same");


return NULL;}
struct literal_data *lit=CREATE(literal_data);lit->type=1;lit->type=1;
struct literal_data *d1=(struct literal_data *)data->data1;

struct literal_data *d2=(struct literal_data *)data->data2;
lit->next=NULL;
switch(d1->type)
{
case 1:;

lit->i=(d1->i+d2->i);

return lit; 
case 2:;

lit->f=(d1->f+d2->f);

return lit; 
case 3:;

lit->c=(d1->c+d2->c);

return lit; 
case 4:;
char * s1=d1->str;

char * s2=d2->str;
strcat(s1,s2);
strcpy(lit->str,s1);
return lit; 
}









}

void *div(struct operands_data *data){
if(((struct literal_data *)data->data1)->type!=((struct literal_data *)data->data2)->type)
{
error("datatype not same");


return NULL;}
struct literal_data *lit=CREATE(literal_data);lit->type=1;lit->type=1;
struct literal_data *d1=(struct literal_data *)data->data1;

struct literal_data *d2=(struct literal_data *)data->data2;
lit->next=NULL;
switch(d1->type)
{
case 1:;

lit->i=(d1->i/d2->i);

return lit; 
case 2:;

lit->f=(d1->f/d2->f);

return lit; 
case 3:;

error("Operation not supported");

return NULL; 
case 4:;
error("Operation not supported");
return NULL; 
}





}
void *mul(struct operands_data *data){
if(((struct literal_data *)data->data1)->type!=((struct literal_data *)data->data2)->type)
{

error("datatype not same");


return NULL;}
struct literal_data *lit=CREATE(literal_data);lit->type=1;lit->type=1;
struct literal_data *d1=(struct literal_data *)data->data1;

struct literal_data *d2=(struct literal_data *)data->data2;
lit->next=NULL;
switch(d1->type)
{
case 1:;

lit->i=(d1->i*d2->i);

return lit; 
case 2:;

lit->f=(d1->f*d2->f);

return lit; 
case 3:;



case 4:;

error("operation not supported");

return NULL; 
}





}
void *sub(struct operands_data *data){
if(((struct literal_data *)data->data1)->type!=((struct literal_data *)data->data2)->type)
{
error("datatype not same");


return NULL;}
struct literal_data *lit=CREATE(literal_data);lit->type=1;lit->type=1;
struct literal_data *d1=(struct literal_data *)data->data1;

struct literal_data *d2=(struct literal_data *)data->data2;
lit->next=NULL;
switch(d1->type)
{
case 1:;

lit->i=(d1->i-d2->i);

return lit; 
case 2:;

lit->f=(d1->f-d2->f);

return lit; 
case 3:;

lit->c=(d1->c-d2->c);

return lit; 
case 4:;
error("operation not supporteed");
return NULL;
}





}

void *lt(struct operands_data *data)
{
if(((struct literal_data *)data->data1)->type!=((struct literal_data *)data->data2)->type)
{
error("datatype not same");


return NULL;}
struct literal_data *lit=CREATE(literal_data);lit->type=1;lit->type=1;
struct literal_data *d1=(struct literal_data *)data->data1;

struct literal_data *d2=(struct literal_data *)data->data2;
lit->next=NULL;
switch(d1->type)
{
case 1:;

lit->i=(d1->i<d2->i)==1?1:0;

return lit; 
case 2:;

lit->i=(d1->f<d2->f)==1?1:0;

return lit; 
case 3:;

lit->i=(d1->c<d2->c)==1?1:0;

return lit; 
case 4:;

lit->i=strcmp(d1->str,d2->str)<0?1:0;

return lit; 

}


}

struct action * chainaction(struct action *a,struct action *b)
{

if(a==NULL){return NULL;}

a->next=b;
return a;



}
struct action * create_action(int type,char *metadata){
struct action node;
struct action *n;n=(struct action*)malloc(sizeof(struct action));*n=node;

}
void *if_cond(struct operands_data *data){return NULL;}

void *continue_stat(struct operands_data *data){return NULL;}

struct literal_data * createuserdefined(void* data)
{
struct literal_data * n=(struct literal_data *) malloc(sizeof(struct literal_data));
n->userdefined=data;

return n;

}

struct literal_data * createidentifier(char* name)
{
struct literal_data * n=(struct literal_data *) malloc(sizeof(struct literal_data));
n->str=name;
n->next=NULL;

return n;

}
struct data_access_result * createdataresult(struct literal_data *ldata,struct action *act)
{
struct data_access_result * n=(struct data_result *) malloc(sizeof(struct data_access_result));
if(ldata==NULL)
{
n->act=act;
n->data=NULL;

}
else if(act==NULL){
n->act=NULL;
n->data=ldata;

}
else{
n->act=NULL;
n->data=NULL;

}
return n;


}
/*
struct act_or_result *createactorresult(struct data_access_result *d,struct action *a)
{
struct act_or_result *n=CREATE(act_or_result);
if(a==NULL)
{
n->data=d;
n->act=NULL;
}
else{d
n->act=a;
n->data=NULL;

}

return n;
}*/

struct action* createaction(struct data_access_result *d1,void* (*f)(void*),struct data_access_result *d2)
{

struct action * act=(struct action *)malloc(sizeof(struct action));
act->next=NULL;
act->f=f;
act->d1=d1;
act->d2=d2;
return act;



}
