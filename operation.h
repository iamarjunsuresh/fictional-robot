#ifndef __OPERATION_H__
#define __OPERATION_H__
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

struct block{
char *type;
char *name;
int id;
char *metadata;
int symcount;
int instcount;
struct symbol *sym;
struct action *istr;
struct block *blocks;
struct block *next;
};
struct symbol{
int id;
char *name;
char *type ;
char *meta;
char *value;
struct symbol *next;

};


struct symbolset{

char *datatype;
struct symbol *start;



};
struct action{

struct block *b;
void *data;
void* (*f)(void *);
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
};

struct data_access_result{

struct literal_data *data;
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
