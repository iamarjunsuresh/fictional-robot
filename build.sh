
#if [ $1=="t" ] ;then

#bison -d -g parser.y && flex scanner.l && gcc lang_types.c lex.yy.c obj_writer.c parser.tab.c -ocompiler -lfl -g
#else
bison -d --verbose -g parser.y && flex scanner.l && gcc *.c  -ocompiler -DYYDEBUG=1 -lfl -g
#fi



