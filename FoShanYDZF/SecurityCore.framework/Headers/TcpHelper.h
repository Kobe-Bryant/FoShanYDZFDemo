#ifndef _TCPHELPER_H_
#define _TCPHELPER_H_

#include "Define-all.h"
//modify yangli
#ifndef TRACKSTEP
#define TRACKSTEP printf
#endif
//====================================�����

//�ͷ�����ͨѶ�õ��豸������Ϣ�ṹ��
typedef struct _DEVICE_IDENTIFY_INFO_ {
	union 
	{
		BYTE Buffer[10*1024];
		struct 
		{
			union
			{//��һ���֣�ͨ����Ϣ��1024�ֽ�
				BYTE Buffer_Common[1*1024];
				struct 
				{
					DWORD dwDeviceType;					//�豸���ͣ��μ�����Ķ���
					char  cHID[KEY_MAX_SERIAL_LEN+4];	//�豸��Ψһʶ����룬Ϊ�����е�HID����
					DWORD dwIP;							//�豸��IP��ַ
					UINT  wPort;						//�豸����ʹ�õĶ˿�
					DWORD dwStartTime;					//�豸����ʱ��
					DWORD dwDeviceTimeNow;				//�豸��ǰʱ�䣨���Ͱ���˲�䣩
				};				
			};
			union
			{//�ڶ����֣������豸�Լ���״̬��Ϣ��9*1024�ֽ�
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
	DEVICEIDENTIFYINFO m_device_status;	//Ҫ���͸����������豸״̬��Ϣ
	BASICCONFIG m_config_basic;
	DWORD m_dwStartTime;			//����ʱ��
	char m_strHID[20];				//��BRIP�ж�ȡ��Ӳ�����к�
	DWORD m_dwIP;
	DWORD m_dwMask;
	DWORD m_dwGate;
	DWORD m_dwServer;
	DWORD m_dwProcessDec;			//�Ƿ�����ܣ��ͻ���->��ȫ���ز�����ݣ�
	DWORD m_dwProcessEnc;			//�Ƿ���������ȫ����->�ͻ��ˣ�
	DWORD m_dwProcessDefault;		//δ֪Э���Լ��쳣������Ƿ�ȫ��ͨ��
	int m_socketSvr;				//�ͷ�����������sock
	int m_iCMD_Len;					//��ǰ�Ĳ������ݳ���
	char m_cCMD[MAX_LENGTH];		//��ǰ�Ĳ�������
}DEVICE_STATUS,*PDEVICE_STATUS;

typedef struct _struct_tcp_connect_{
	SOCKET sock;
	DWORD  dwTimeoutMS;
}TCPCONNECT,*PTCPCONNECT;

//������װ�����������͡����ղ���
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
int PackageRecv_Dec(FRAMEPACKAGE *pfp);//���

//ֱ��socket��������
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

//UDP��ʽ������־
int socket_SendUDP_Content(DWORD dwIP,WORD wPort,BYTE* bBuffer,DWORD dwSize);
int socket_SendTCP_Content(DWORD dwIP,WORD wPort,WORD wCmd,BYTE* bBuffer,DWORD dwSize);
int socket_SendUDPLog(DWORD dwLogIP,const char *__fmt, ...);
int socket_SendDEBUGLog(DWORD dwLogIP,const char *__fmt, ...);

int socket_SendStatusInfo(char * clientApplyIP, int iPort, const char *fmt, ...);
int socket_SendVpnCommandtResult(struct sockaddr_in pRemoteAddr, SOCKET isocket, const char *fmt, ...);

int socket_Send_Heartbeat_Pkg(struct sockaddr_in pRemoteAddr, SOCKET isocket, char *pData, int iDataLen);
#endif //_TCPHELPER_H_

