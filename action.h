#ifndef __ACTION
#define __ACTION
#include "operation.h"
void* equal(struct operands_data *data);




void *ntequal(struct operands_data *data);

void *ret(struct operands_data *data);
void *brk(struct operands_data *data);
void *lte(struct operands_data *data);

void *for_block(struct operands_data *data);

void *gte(struct operands_data *data);
void *continue_stat(struct operands_data *data);
void *assign (struct operands_data *data);
void *mem_access(struct operands_data *data);
void *if_cond(struct operands_data *data);
void *gt(struct operands_data *data);
void *decrement (struct operands_data *data);
void *increment (struct operands_data *data);

void *lt(struct operands_data *data);
void *add(struct operands_data *data);

void *div(struct operands_data *data);
void *mul(struct operands_data *data);
void *sub(struct operands_data *data);

void *log_or(struct operands_data *data);
void *log_and(struct operands_data *data);
void *func_call(struct operands_data *data);

void *func_def(struct operands_data *data);
#endif
