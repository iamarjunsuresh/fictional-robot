//filewriter
#ifndef __INTERPRETER_H__
#define __INTERPRETER_H__
#include "operation.h"

void interpret();
 void * runaction(struct action *act);
 void * getoperand_data(struct data_access_result *input);
 extern struct block *current_blk;

#endif
