#include "arjunsuresh_webautomation_MainActivity.h"
#include <malloc.h>
#include <string.h>


JNIEXPORT jstring JNICALL Java_arjunsuresh_webautomation_MainActivity_test
  (JNIEnv *, jobject)
  {
	  
	  char *s;
	  s=(char*) malloc(sizeof(char)*10000);
	  strcpy(s,"#include<iostream int a;int main(){}");
	  run_str(s);
  
  
  }
