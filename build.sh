
#if [ $1=="t" ] ;then

#bison -d -g parser.y && flex scanner.l && gcc lang_types.c lex.yy.c obj_writer.c parser.tab.c -ocompiler -lfl -g
#else
bison -d -g parser.y && flex scanner.l && gcc *.c -ocompiler -lfl -g
#fi



