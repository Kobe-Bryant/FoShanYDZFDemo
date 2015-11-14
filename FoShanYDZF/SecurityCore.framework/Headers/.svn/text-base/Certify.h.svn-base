//
//  Certify.h
//  interface
//
//  Created by yangli on 11-12-27.
//  Copyright 2011年 wondersoft. All rights reserved.
//


#ifndef interface_Certify_h
#define interface_Certify_h
#include <string.h>
#include "Define-all.h"
#include "Define-linux.h"
#include "Define-auth.h"
#include "Tool.h"
#include "TcpHelper.h"
#include "KeyManagerTools.h"
#include "KeyRSATools.h"
#include "PolicyManagerTools.h"

typedef struct _CC_CONNECTION_INFO_INTER_
{
	unsigned long ulValid;			
	CC_CONNECTION_PARAM_V1 Param;
    
	//THREADID ulThreadID;
	//pthread_mutex_t  m_Opt_Lock;
    
	unsigned long ulStatus_Command;	
	unsigned long ulManagementPort;	
	
	unsigned long ulStatus;
	//CC_LOG_SINGLE cLogs[CC_CONNECTION_LOG_CACHE];
	unsigned long ulLog_Pos;
    
	SOCKET iSock_Certify;			//
	struct sockaddr_in addrServer;	//
	void    *hKeyHandle;				//
	unsigned char pCertPath[8];		//
	CLIENTINFOSINGLE cis;			//
	FRAMEPACKAGE  netPack;			//
	FRAMEPACKAGE  netPackRecv;		//
	SERVERCERTIFYRESULT certResult;	//
	unsigned long	ulPID;		//
	SOCKET			iSock;		//
    
    char    SessionID[33];
    char    SessionKey[256+1];
    time_t  heartBeatTime;
    
    char    m_cCurrentPath[255];//应用程序路径 ios：/app   android：包名
    int     bCertifyPackageType;//设置认证包的顺序，0：第一次给服务器发送的包；1：第二个给服务器发的包（随机密钥结构体）
    int     iHeartBeatManagerDefaultStatus;
    char    heartTime0[16];
    char    heartTime1[16];
	
}CC_CONNECTION_INFO,*PCC_CONNECTION_INFO;


void Certify_Init(char *myContentPath,PCC_CONNECTION_INFO pInfo);
unsigned long CC_Cert_Parse(unsigned char *pCertContent,unsigned long uCertLen,char* cParseID,unsigned char *pContent,unsigned long *puContentLen);
//解析证书内容函数
unsigned long Certify_CertParse(PCC_CONNECTION_INFO pInfo);
unsigned long Certify_GeneryCltInfo(PCC_CONNECTION_INFO pInfo);//填充结构体信息，组认证包备用
unsigned long Certify_GeneryPackage(PCC_CONNECTION_INFO pInfo);//组认证包
unsigned long Certify_ConnectServer(PCC_CONNECTION_INFO pInfo);//连接服务器
unsigned long Certify_SendRecvPackage(PCC_CONNECTION_INFO pInfo);//发送认证包，接收服务器返回的结果
unsigned long Certify_GetCertifyStatusResult(PCC_CONNECTION_INFO pInfo);//获取认证结果
unsigned long Certify_GeneryPolicyAndAccessList(PCC_CONNECTION_INFO pInfo);
unsigned long Certify_GeneryApplyAccessListReal(char *m_cCurrentPath,BYTE* pBuffer,DWORD dwLen);//写客户端权限列表

unsigned long Certify_GetSessionID(PCC_CONNECTION_INFO pInfo, X509 *pX509SrvCert, char *pSessionID);//获取服务器传来的会话ID
unsigned long Certify_TAP_WriteConfig(PCC_CONNECTION_INFO pInfo,char* cConfigFileName,char* cConfigCommand);

unsigned long GeneryLogoutPackage(PCC_CONNECTION_INFO pInfo);//组离线包

unsigned long  Cert_CreateThreadForHeartBeat(PCC_CONNECTION_INFO pInfo);
void *Cert_HeartBeatProc(void *pParam);

#endif

