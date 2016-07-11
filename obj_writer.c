#include "obj_writer.h"
#include "constants.h"
#include "stdio.h"
#include "stdlib.h"
#include "malloc.h"

struct objfile file;
FILE *fp;

void  init_objfile(struct objfile *n)

{

n->symbols=NULL;
n->blocks=NULL;
n->symcount=0;
n->block_count=0;

}

void print_symbol(struct symbol *s){
if(s==NULL){printf("NULL");return;}
printf("{name:%s}",s->name);

}
struct objfile* addblock(struct block *node,struct objfile *file)
{

struct block *t=file->blocks;
struct block *prev=NULL;
while(t!=NULL)
{
prev=t;
t=t->next;
}

if(t==NULL&&prev==NULL)
{
file->blocks=node;
}
else{
prev->next=node;

}

file->block_count++;
}



struct block * createblock(struct block *inner,char *type,char *name,struct symbol *sym,struct action* act,struct block *next)
{

struct block *n=CREATE(block);

n->blocks=inner;
/*char *type;
char *name;
int id;
char *metadata;*/
n-> symcount=0;
n->instcount=0;
n->blockcount=0;

n->sym=sym;
n->istr=act;
n->next=next;
return n;
}

void print_block(struct block *b){

if(b==NULL){printf("NULL");return;}
struct symbol *symb;
struct block *inner;
struct action *istart;

symb=b->sym;
inner=b->blocks;

istart=b->istr;
print_symbol(symb);
print_block(inner);
//print_instr(istart);





printf("{name:%s\nsymbol_count:%d\nblock_count:%d}",b->name,b->symcount,b->blockcount);

}
void summary(struct  objfile *fil)
{


struct symbol *t;t=fil->symbols;



struct symbol *prev=NULL;
//fil->symbols=NULL;
printf("\nSUMMARY\n====================\nsymbols:");
while(t!=NULL)
{
printf("\n");

print_symbol(t);
prev=t;
t=t->next;
}
struct block *b=NULL,*prevb=NULL;
b=fil->blocks;

printf("\nblocks:\n");
while(b!=NULL)
{
printf("\n");
print_block(b);

b=b->next;
}
printf("==================================================");



}
struct block *  addsymbol(struct symbol sym,struct objfile *fil,struct block *b){



if(b==NULL)
{

struct symbol *t;t=fil->symbols;



struct symbol *prev=NULL;
//fil->symbols=NULL;

while(t!=NULL)
{


prev=t;
t=t->next;
}
struct symbol *n;n=(struct symbol*)malloc(sizeof(struct symbol));*n=sym;
n->next=NULL;
n->id=fil->symcount;
if(t==NULL&&prev==NULL)
{
fil->symbols=n;

}
else{
prev->next=n;

}
fil->symcount++;

printf("added symbol %s",sym.name);
return NULL;
}
else{

struct symbol *t=b->sym;

struct symbol *prev=NULL;

while(t!=NULL)
{
prev=t;
t=t->next;
}
struct symbol *n;n=(struct symbol*)malloc(sizeof(struct symbol));*n=sym;
n->id=b->symcount;
if(t==NULL&&prev==NULL)
{
b->sym=n;
printf("addedsymbol to block");
}
else{
prev->next=n;

}
b->symcount++;
return b;
}

}


void write_symbol(struct symbol *start)
{while(start!=NULL)
{
struct symbol ptr;
ptr=*start;

fwrite(start,sizeof(struct symbol),1,fp);

start=start->next;
}
}

void write_instr(struct action *start)
{

while(start!=NULL)
{
fwrite(start,sizeof(struct action),1,fp);
start=start->next;

}





}
void write_block(struct block *start)
{while(start!=NULL)
{
struct symbol *symb;
struct block *inner;
struct action *istart;
fprintf(fp,"%d%d%d",VER0,VER1,VER2);
symb=start->sym;
inner=start->blocks;

istart=start->istr;
write_symbol(symb);
write_block(inner);
write_instr(istart);



start=start->next;
}}
void writetofile(char *name,struct objfile *file)
{
char filename[100];
sprintf(filename,"sdcard/webautomata/%s.txt",name);
 fp=fopen(filename,"w");
 if(fp==NULL)
 {printf("error opening");return;}
fprintf(fp,"AUTOMATA%d%d%d",VER0,VER1,VER2);

struct symbol *s;
struct block *b;

fprintf(fp,"%d%d",file->symcount,file->block_count);

s=file->symbols;
b=file->blocks;


write_symbol(s);
write_block(b);







}


