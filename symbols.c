#include "symbols.h"
#include <stddef.h>
#include "operation.h"
#include "obj_writer.h"
#include "interpreter.h"

int checkdefined(char *name,struct block *b)
{
struct symbol *s=b->sym;
while(s!=NULL)
{
if(strcmp(s->name,name)==0)
{
return 1;

break;
}


s=s->next;
}

return 0;


}



struct symbol * getsymbol(char *name,struct block *b)
{

struct symbol *s=b->sym;
while(s!=NULL)
{
if(strcmp(s->name,name)==0)
{
return s;

break;
}


s=s->next;
}
s=file.symbols;
while(s!=NULL)
{
if(strcmp(s->name,name)==0)
{
return s;

break;
}


s=s->next;

}

return NULL;

}

