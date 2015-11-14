#ifndef _DEFINE_LINUX_H
#define _DEFINE_LINUX_H

#include <ctype.h>
#include <limits.h>
#include <netdb.h>
#include <stdio.h> 
#include <stdlib.h>
#include <sys/types.h> 
#include <sys/stat.h> 
#include <fcntl.h> 
#include <unistd.h>
#include <errno.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <pthread.h>
#include <sys/file.h>
#include <sys/wait.h>
#include <sys/param.h>
//#include <lzo/lzo1x.h>
//#include <lzo/lzoconf.h>

#ifndef	WIN32
#define _MAX_PATH 	260
#define HANDLE		void *
#endif

typedef unsigned long u32;
typedef unsigned short u16;
typedef unsigned char u8;

#define BOOL bool
#define true 1
#define false 0
#define TRUE 1
#define FALSE 0

typedef int SOCKET;
typedef unsigned long DWORD;
typedef unsigned long ULONG;
typedef unsigned int UINT;
typedef unsigned short WORD;
typedef unsigned char UCHAR;
//typedef	void VOID;
typedef	void *  LPVOID;
typedef pthread_t THREADID;
typedef pid_t PROCESSID;
typedef THREADID * PTHREADID;
typedef PROCESSID * PPROCESSID;

#define	THREADRTN void *
typedef void *(*THREADPROC) (void *);
#define THREADARG void *

#define ThreadCreate(PThreadID,ThreadProc,ThreadArg)	\
				(pthread_create(PThreadID,NULL,ThreadProc,ThreadArg)==0)?TRUE:FALSE

#define closesocket(Socket) close(Socket);
#define lzo_alloc(a,b)      (malloc((a)*(b)))
#define lzo_malloc(a)       (malloc(a))
#define lzo_free(a)         (free(a))
#define lzo_fread(f,b,s)    (fread(b,1,s,f))
#define lzo_fwrite(f,b,s)   (fwrite(b,1,s,f))

#define Sleep(Seconds)	sleep(Seconds)
#define GetLastError()	errno

#endif //_DEFINE_LINUX_H
