#ifndef __LANG_TYPE
#define __LANG_TYPE

struct ast{

int operation;
char* val;


struct ast *lc,*rc;



};

struct ast *newast(char* str,int operation,struct ast *lc,struct ast *rc);
void free_ast(struct ast *s);
//sstruct ast eval(struct ast *node,struct objfile *file);


#endif
