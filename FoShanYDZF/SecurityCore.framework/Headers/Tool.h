//
//  Tool.h
//  interface
//
//  Created by yangli on 11-12-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#ifndef interface_Tool_h
#define interface_Tool_h
#include <stdio.h>
#include <sys/file.h>
#include "time.h"
#include "Define-all.h"
#include "Define-auth.h"
#include "TcpHelper.h"
#include <CommonCrypto/CommonDigest.h>

#define RANDOMKEYLEN 16

#define PROCESS_MODE_READ_TO_STRUCT		0x01
#define PROCESS_MODE_READ_TO_CHAR		0x02
#define PROCESS_MODE_WRITE_FROM_CHAR	0x04

#ifndef MAX_PATH
#define MAX_PATH 512
#endif
void _strupr(char *cItems);
char* Tools_DwToStrIP(DWORD dwIP);//工具函数，转换IP
//获取当前系统时间
long Tool_GetSystemCurrentTime(void);
void Tool_GetSystemHardInfo(PCLIENTBASEINFO cltInfo, char *pDeviceOSVersion, char *pcHardWareID);//获取设备硬件信息 IOS：UDID    Android：IMEI
X509 *Tool_Client_GetX509(FRAMEPACKAGE *pfp);//获取x509证书
unsigned long Tool_Cert_ByRootCert_Verify(char *rootCertPath, X509 *pX509UserCert);//验证服务器证书身份

//工具函数
unsigned long Tool_Config_Set_CHAR(char* cConfigFilenamePredefine,char* cConfigFilenameUser,char* cConfigName,char *cParam);
unsigned long Tool_Process_Param_SingleFile(char* cConfigFilename,int iMode,char* cContentName,unsigned char *pParamContent,unsigned long *puParamSize);
unsigned long Tool_Process_Param_SingleLine(char* cItem,char* cContent,PCC_CONNECTION_PARAM_V1 pParam);
DWORD  Tools_Info_GetFileSize(char *cFileName);
int Tools_File_Read(char* cFileName,int iPos,char* cBuffer,int iReadLen);
int Tools_File_Write(char* cFileName,int iPos,char* cBuffer,size_t iWriteLen,int iBuildNew);

int Tools_Base64Dec(char *buf,char*in_text,int size);
int Tools_Base64Dec_Real(char *buf,char*in_text,int size);
int Tools_Base64Enc(char *buf, char*in_text,int size);
int Tools_Base64Detect(char* in_text,int size); 
char Tools_GetBase64Value(char ch);

unsigned char *Tools_GenerateProductPin(unsigned char *cSeed,unsigned char *cSHA1);

//int WriteLog(const char* szFilePath, const char* format, ...);
#endif
