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
n->symcount=355;
}

struct objfile* addblock(struct block node,struct objfile *file)
{
if(file->isinit==0)
{
file->symbols=NULL;
file->blocks=NULL;
file->symcount=0;
file->block_count=0;
file->isinit=1;

}
struct objfile t=*file;
struct block *prev=NULL;
while(t.blocks!=NULL)
{
prev=t.blocks;
t.blocks=t.blocks->next;
}
struct block *n;n=(struct block*)malloc(sizeof(struct block));*n=node;
if(t.blocks==NULL&&prev==NULL)
{
file->blocks=n;
}
else{
prev->next=n;

}

file->block_count++;
}

struct action * create_action(int type,char *metadata){
struct action node;
struct action *n;n=(struct action*)malloc(sizeof(struct action));*n=node;

}
struct block *  addsymbol(struct symbol sym,struct objfile *fil,struct block *b){



if(b==NULL)
{

struct objfile t=*fil;

struct symbol *prev=NULL;

while(t.symbols!=NULL)
{
printf("next");
prev=t.symbols;
t.symbols=t.symbols->next;
}
struct symbol *n;n=(struct symbol*)malloc(sizeof(struct symbol));*n=sym;
n->id=fil->symcount;
if(t.symbols==NULL&&prev==NULL)
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

struct block *t;
t=b;

struct symbol *prev=NULL;

while(t!=NULL)
{
prev=t->sym;
t->sym=t->sym->next;
}
struct symbol *n;n=(struct symbol*)malloc(sizeof(struct symbol));*n=sym;
n->id=fil->symcount;
if(t->sym==NULL&&prev==NULL)
{
b->sym=n;
printf("addedsymbol");
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


