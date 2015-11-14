#ifndef _TCPHELPER_H_
#define _TCPHELPER_H_

#include "Define-all.h"
//modify yangli
#ifndef TRACKSTEP
#define TRACKSTEP printf
#endif
//====================================命令定义

//和服务器通讯用的设备基本信息结构体
typedef struct _DEVICE_IDENTIFY_INFO_ {
	union 
	{
		BYTE Buffer[10*1024];
		struct 
		{
			union
			{//第一部分，通用信息，1024字节
				BYTE Buffer_Common[1*1024];
				struct 
				{
					DWORD dwDeviceType;					//设备类型，参见上面的定义
					char  cHID[KEY_MAX_SERIAL_LEN+4];	//设备的唯一识别号码，为令牌中的HID号码
					DWORD dwIP;							//设备的IP地址
					UINT  wPort;						//设备连接使用的端口
					DWORD dwStartTime;					//设备启动时间
					DWORD dwDeviceTimeNow;				//设备当前时间（发送包的瞬间）
				};				
			};
			union
			{//第二部分，各种设备自己的状态信息，9*1024字节
				BYTE Buffer_Status[9*1024];
			};
		};
	};
}DEVICEIDENTIFYINFO,*PDEVICEIDENTIFYINFO;

typedef struct _struct_config_ip_{
	union
	{
		BYTE Buffer[128];
		struct
		{
			DWORD dwIP;
			DWORD dwMASK;
			DWORD dwGate;
			DWORD dwSVR;
			BYTE  bGateMAC[8];
		};
	};
}IPCONFIG,*PIPCONFIG;

typedef struct _struct_config_mode_{
	BYTE Buffer[128];
}MODECONFIG,*PMODECONFIG;

typedef struct _struct_config_basic_{
	int m_bOK;
	IPCONFIG m_config_ip;
	MODECONFIG m_config_mode;
}BASICCONFIG;

typedef struct _struct_device_status_{
	DEVICEIDENTIFYINFO m_device_status;	//要报送给服务器的设备状态信息
	BASICCONFIG m_config_basic;
	DWORD m_dwStartTime;			//启动时间
	char m_strHID[20];				//从BRIP中读取的硬件序列号
	DWORD m_dwIP;
	DWORD m_dwMask;
	DWORD m_dwGate;
	DWORD m_dwServer;
	DWORD m_dwProcessDec;			//是否处理解密（客户端->安全网关侧的数据）
	DWORD m_dwProcessEnc;			//是否处理发包（安全网关->客户端）
	DWORD m_dwProcessDefault;		//未知协议以及异常情况下是否全部通过
	int m_socketSvr;				//和服务器的连接sock
	int m_iCMD_Len;					//当前的策略数据长度
	char m_cCMD[MAX_LENGTH];		//当前的策略数据
}DEVICE_STATUS,*PDEVICE_STATUS;

typedef struct _struct_tcp_connect_{
	SOCKET sock;
	DWORD  dwTimeoutMS;
}TCPCONNECT,*PTCPCONNECT;

//包的组装、解析、发送、接收操作
int PackageSetHeader(FRAMEPACKAGE * PackReceived, BYTE bMgmtType, BYTE bFlowDir, WORD wCmdType );
int PackageSetContent(FRAMEPACKAGE *pfp,BYTE* buf,int length);
int PackageAddContent(FRAMEPACKAGE *pfp,BYTE* buf,int length);
int PackageGetContent(FRAMEPACKAGE *pfp,BYTE* buf,int length);
int PackageGetContentLen(FRAMEPACKAGE *pfp);

int PackageSend_TCP(SOCKET sock,FRAMEPACKAGE *pfp);
int PackageSend_UDP(SOCKET sock,FRAMEPACKAGE *pfp,struct sockaddr_in pRemoteAddr);
int PackageSend_TCPUDP(SOCKET sock,FRAMEPACKAGE *pfp,struct sockaddr_in pRemoteAddr,int bUDP);

int PackageRecv_TCP(DWORD dwID,SOCKET sock,FRAMEPACKAGE *pfp);
int PackageRecv_UDP(DWORD dwID,SOCKET sock,FRAMEPACKAGE *pfp,struct sockaddr_in *pRemoteAddr);
int PackageRecv_Dec(FRAMEPACKAGE *pfp);//解包

//直接socket操作函数
int socket_Init();
SOCKET socket_Connect_TCP(char* sip,u_short port);
SOCKET socket_Connect_TCP_DWORD(DWORD dwip,u_short port);
#ifdef UNDER_CE
static UINT Thread_socket_Connect_TCP_WithTimeout(PVOID pParam);
#endif
SOCKET socket_Connect_TCP_WithTimeout(char* sip,u_short port,DWORD dwTimeOut);
SOCKET socket_Connect_UDP(char* sip,u_short port,struct sockaddr_in *pRemoteAddr);
int socket_Listen(DWORD dwPort,DWORD dwBindIP,int iTCP,SOCKET* iSock);
int socket_SendData(SOCKET sock, char* buf,int length);
int socket_SendString(SOCKET sock,char *format,... );
int socket_RecvData_WithTimeout(DWORD dwID,SOCKET s,int iIsUDP,char* pbRecv,int iLen,DWORD dwTimeOut,struct sockaddr_in *pRemoteAddr);
int socket_RecvData(DWORD dwID,SOCKET sock,int iIsUDP,char* buf,int length);

//UDP方式发送日志
int socket_SendUDP_Content(DWORD dwIP,WORD wPort,BYTE* bBuffer,DWORD dwSize);
int socket_SendTCP_Content(DWORD dwIP,WORD wPort,WORD wCmd,BYTE* bBuffer,DWORD dwSize);
int socket_SendUDPLog(DWORD dwLogIP,const char *__fmt, ...);
int socket_SendDEBUGLog(DWORD dwLogIP,const char *__fmt, ...);

int socket_SendStatusInfo(char * clientApplyIP, int iPort, const char *fmt, ...);
int socket_SendVpnCommandtResult(struct sockaddr_in pRemoteAddr, SOCKET isocket, const char *fmt, ...);

int socket_Send_Heartbeat_Pkg(struct sockaddr_in pRemoteAddr, SOCKET isocket, char *pData, int iDataLen);
#endif //_TCPHELPER_H_

