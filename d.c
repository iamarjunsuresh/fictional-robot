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
 c=(char*)malloc(sizeof(char)*10000);

	 
	// strcpy(c,"int a,b=55,c;int f; int add(int ami,int b){int x,y,z; float p,q,r;} int sub(int a,int b){int aa,bb,cc; float f=3; assignment=assignment+add();for(i=0,j=0;i<2&&i>10;i=i+2){int tink,tank=4;} if(1>2){d();} }");
	 
	 
	strcpy(c,"int ifa,b,c; int main(){int v,m,n; v=2;v=3; }");
	 yydebug=3;
	init_objfile(&file);
scan_string(c);
summary(&file);
interpret();
	}
	
	int main()
	{
	
	run_str(NULL);
	
	return 0;
	
	}
