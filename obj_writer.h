//filewriter
#ifndef __OBJWRITER_H__
#define __OBJWRITER_H__
#include "operation.h"
struct objfile{
struct symbol *symbols;
int symcount,block_count;
struct block *blocks;
int isinit;

};
extern struct objfile file;
struct block * createblock(struct block *inner,char *type,char *name,struct symbol *sym,struct action* act,struct block *next);
struct objfile* addblock(struct block *node,struct objfile *file);
void print_symbol(struct symbol *s);
void writetofile(char *name,struct objfile *file);
struct instruction * create_instruction(int type,char *metadata);
struct block *  addsymbol(struct symbol *sym,struct objfile *file,struct block *b);

void init_objfile(struct objfile *n);


#endif
