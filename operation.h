#ifndef __OPERATION_H__
#define __OPERATION_H__
#include <malloc.h>
#define CREATE(x) (struct x*)malloc(sizeof(struct x))
#define CREAT(x,l) (x*)malloc(sizeof(x)*(l))
 
enum opcode{
T_VAR_DEC=0,
T_BLOCK_DEC,
T_VAR_,
T_VAR



};
struct data{
int i;

int d;
int f;
int str;


};

struct fn_param_list{


int datatype;
int name;
struct fn_param_list *next;


};
struct fn_sig{
char* returntype;
char * name;
struct fn_param_list *start;



};
struct block{
char *type;
char *name;
struct fn_sig *sig;
int id;
char *metadata;
int symcount;
int instcount;
int blockcount;
struct symbol *sym;
struct action *istr;
struct block *blocks;
struct block *next;
};
struct symbol{
int id;
char *name;
int type;
char *meta;
struct fn_sig *sig;
struct literal_data *value;
struct symbol *next;

};


struct symbolset{

char *datatype;
struct symbol *start;



};
struct action{

struct block *b;
struct data_access_result *d1,*d2;
void* (*f)(struct operands_data *);
struct action *next;


};
struct operands_data{
void *data1;
void *data2;
int type1,type2;


};
struct literal_data{

int i;
float f;
char c;
char *str;
void *userdefined;
int type;
struct literal_data *next;
};

struct data_access_result{

struct literal_data *data;
struct action *act;
void * pointer;

};

struct act_or_data{
struct data_access_result *data;
struct action *act;

};
struct func_call_params_set{
struct func_call_param *start;



};

struct func_call_param{

int i;
float f;
char c;
char *str;
void *userdefined;
int type;



};








#endif
