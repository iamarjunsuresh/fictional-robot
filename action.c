#include "action.h"
#include "operation.h"
#include <stddef.h>
#include <malloc.h>


void* equal(struct operands_data *data)
{
if(data->type1!=data->type2)
{return NULL;}/*
switch(data->type1)
{
case 0:;
int *d1;d1=(int*)data->d1;
int *d2;d2=(int*) data->d2;
return

*/
}

void *log_or(struct operands_data *data){return NULL;}
void *log_and(struct operands_data *data){return NULL;}

void *increment(struct operands_data *data){return NULL;}
void *decrement (struct operands_data *data){return NULL;}
void *assign (struct operands_data *data){return NULL;}
void *mem_access(struct operands_data *data){return NULL;}
void *ntequal(struct operands_data *data)
{
 return NULL;


}
void *func_call(struct operands_data *data){return NULL;}

void *func_def(struct operands_data *data){return NULL;}



void *lte(struct operands_data *data)
{
 return NULL;


}



void *gte(struct operands_data *data)
{
 return NULL;


}



void *gt(struct operands_data *data)
{
 return NULL;


}void *for_block(struct operands_data *data){return NULL;}
void *ret(struct operands_data *data){return NULL;}
void *brk(struct operands_data *data){return NULL;}
void *add(struct operands_data *data){return NULL;}

void *div(struct operands_data *data){return NULL;}
void *mul(struct operands_data *data){return NULL;}
void *sub(struct operands_data *data){return NULL;}

void *lt(struct operands_data *data)
{
 return NULL;


}

struct action * chainaction(struct action *a,struct action *b)
{



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
