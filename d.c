#include "d.h"
#include "lang_types.h"
#include <malloc.h>
#include <string.h>
#include<stdio.h>
#include<stdlib.h>

#include "parser.tab.h"
#include "obj_writer.h"



int  run_str(char *s)
{
char str[10000];
char *c;
 c=(char*)malloc(sizeof(char)*0100);

	 
	 strcpy(c,"int a;");
	 yydebug=3;
	init_objfile(&file);
scan_string(c);
summary(&file);
	}
	
	int main()
	{
	
	run_str(NULL);
	
	return 0;
	
	}
