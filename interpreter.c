#include "interpreter.h"
#include "operation.h"
#include <stddef.h>
#include "obj_writer.h"
struct block *current_blk;
void interpret()
{
//initalise symbols
struct block *blk=file.blocks;
while(blk!=NULL)
{

if(strcmp(blk->name,"main")==0)
{

break;

}
blk=blk->next;

}
if(blk==NULL)
{

error("main not found");
return;
}
struct action *start=blk->istr;
current_blk=blk;
while(start!=NULL)
{

runaction(start);
start=start->next;
}

}

 void * runaction(struct action *act)
{
struct operands_data * d=CREATE(operands_data);
d->data1=getoperand_data(act->d1);
d->data2=getoperand_data(act->d2);

return act->f(d);




}

 void * getoperand_data(struct data_access_result *input)
{
if(input==NULL){return NULL;}
if(input->act==NULL&&input->data!=NULL)
{

return input->data;
}
if(input->data==NULL&&input->act!=NULL)
{
return runaction(input->act);


}




return NULL;














}
void error (char *s)
{

printf("ERROR :%s",s);



}

