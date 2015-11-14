#ifndef _DEFINE_ALL_H
#define _DEFINE_ALL_H

#pragma warning(disable:4995)
#pragma warning(disable:4996)
/*
此文件为ClientCore核心库以及服务器使用的定义
如果是调用ClientCore也需要的定义，则放到CC_Define.h里面
*/

#include <openssl/err.h>
#include <openssl/ssl.h>
#include <openssl/rsa.h>
#include <openssl/pkcs12.h>

#define true 1
#define false 0
//#define bool int

#ifndef	WIN32	//sunfei add
#define INVALID_SOCKET					-1
#define	INVALID_HANDLE_VALUE				-1
#endif

#ifdef WIN32
#include "Define-win32.h"
#else
#include "Define-linux.h"
//#include <android/log.h>
#endif

#ifdef _ANDROID_
#define LOG_TAG "authCore"
#define LOGV( logInfo ... )  __android_log_print(ANDROID_LOG_VERBOSE,LOG_TAG,logInfo)
#define LOGD( logInfo ... )  __android_log_print(ANDROID_LOG_DEBUG,LOG_TAG,logInfo)
#define LOGI( logInfo ... )  __android_log_print(ANDROID_LOG_INFO,LOG_TAG,logInfo)
#define LOGW( logInfo ... )  __android_log_print(ANDROID_LOG_WARN,LOG_TAG,logInfo)
#define LOGE( logInfo ... )  __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,logInfo)
#endif

#define TIS_FLOWDIR_CLT2DEV							0x0C
#define TIS_MGMTTYPE_DEVICE							0x0A

#define TIS_CMDTYPE_DEVICE_VPN_CLIENT_CERTIFY			0x0A21	//客户端发起证书认证（证书型VPN网关 专用）
#define TIS_CMDTYPE_DEVICE_VPN_CLIENT_CERTIFY_RESULT		0x0A22	//客户端证书认证结果（证书型VPN网关 专用）
#define TIS_CMDTYPE_DEVICE_VPN_CLIENT_CHANGE_PASSWORD 		0x0A91 //修改密码
#define TIS_CMDTYPE_DEVICE_VPN_CLIENT_USER_OFFLINE 		0x0A92 //用户离线

#define E_KEYOPT_SUCCESS					0x0000  //正常返回值，说明操作成功
#define E_KEYOPT_RSA_PUBLIC_DECRYPT				0x0614  //公钥解密错误
#define E_KEYOPT_RSA_RAND_NOSAME				0x0617  //两次解密结果不同

#define E_KEYOPT_CERT_VERIFY                        0x0380//认证证书－失败，非法证书
#define E_KEYOPT_CERT_VERIFY_NO_ROOT_CERT			0x0381//认证证书－无根证书
#define E_KEYOPT_CERT_VERIFY_NO_ROOT_CRL			0x0382//认证证书－无吊销列表
#define E_KEYOPT_CERT_VERIFY_ERROR_CERT				0x0383//认证证书－证书转换失败
#define E_KEYOPT_CERT_VERIFY_NEW_STORE				0x0384//认证证书－构造证书链
#define E_KEYOPT_CERT_VERIFY_ADD_LOOKUP				0x0385//认证证书－构造证书链
#define E_KEYOPT_CERT_VERIFY_LOAD_ROOTCERT			0x0386//认证证书－构造证书链(读取根证书)
#define E_KEYOPT_CERT_VERIFY_LOAD_ROOTCRL			0x0387//认证证书－构造证书链(读取CRL)
#define E_KEYOPT_CERT_VERIFY_LOAD_HASHDIR			0x0388//认证证书－构造证书链(读取HASH DIR)
#define E_KEYOPT_CERT_VERIFY_NEW_CTX				0x0389//认证证书－构造证书链
#define E_KEYOPT_CERT_VERIFY_CTX_INIT				0x038A//认证证书－初始化认证
#define E_KEYOPT_CERT_VERIFY_NO_PREPAIR				0x038B//认证证书－需要初始化
#define E_KEYOPT_CERT_VERIFY_BYCRL                  0x038C//认证证书－失败，因为被吊销了
#define E_KEYOPT_CERT_VERIFY_GET_SERVERCERT_FAILURE 0x038D//认证证书－失败，没有获取到服务器证书
#define E_KEYOPT_CERT_READ_FAILURE                  0x038E//认证证书－失败，没有获取到证书
#define E_KEYOPT_CERT_PARSE_FAILURE                 0x038F//认证证书－失败，证书解析失败


#define E_KEYOPT_SOCKET_CONNECT				0x0500//发起连接失败
#define E_KEYOPT_SOCKET_SEND_ERROR			0x0501//发送数据失败
#define E_KEYOPT_SOCKET_RECV_HEAD			0x0502//接受头数据失败
#define E_KEYOPT_SOCKET_RECV_CLOSE			0x0503//接受数据时，对方关闭SOCKET
#define E_KEYOPT_SOCKET_RECV_DATA			0x0504//接受其他数据失败
#define E_KEYOPT_SOCKET_RECV_FRAME			0x0505//组建传输层包失败
#define E_KEYOPT_SOCKET_RECV_APP			0x0506//获取应用层包失败
#define E_KEYOPT_SOCKET_RECV_ERROR			0x0507//接受到的包不正确
#define E_KEYOPT_SOCKET_RECV_BUFFER			0x0508//接受数据的缓冲区不够
#define E_KEYOPT_SOCKET_RECV_MEM			0x0509//分配接受缓冲区失败
//#define E_KEYOPT_SOCKET_UNKNOWNCMD			0x050A//未知命令（不能用这个命令，否则网络会断开）
#define E_KEYOPT_SOCKET_UNKNOWNOPT			0x050B//操作时的操作代码参数有错误
#define E_KEYOPT_SOCKET_NEED_PARAM			0x050C//没有设置服务器的参数
#define E_KEYOPT_SOCKET_INIT				0x050D//初始化SOCKET失败
#define E_KEYOPT_SOCKET_BIND				0x050E//绑定本地IP失败
#define E_KEYOPT_SOCKET_LISTEN				0x050F//监听失败
#define E_KEYOPT_SOCKET_SERVER				0x0510//解析地址失败
#define E_KEYOPT_SOCKET_CONNET				0x0511//连接失败
#define E_KEYOPT_SOCKET_TIMEOUT				0x0512//超时没有收到数据包，但应该SOCKET没有关闭
#define E_KEYOPT_SOCKET_UNCOMPRESS			0x0513//解压应用层包失败
#define E_KEYOPT_SOCKET_MMC_INVALID			0x0514//控制台未登陆
#define E_KEYOPT_SOCKET_RECV_SET_APP			0x0515//组建应用层包失败
#define E_KEYOPT_SOCKET_SEND_BUSY			0x0520//发送数据失败-原因：忙
#define E_KEYOPT_SOCKET_SEND_TIMEOUT			0x0521//发送数据失败-原因：超时
#define E_KEYOPT_SOCKET_SEND_ERROR_ZERO			0x0522//发送数据失败-原因：0长度发送
#define E_KEYOPT_SOCKET_SEND_ERROR_INCOM		0x0523//发送数据失败-原因：发送长度不对
#define E_KEYOPT_GENERY_CONFIGMAP_FAILURE       0x0504//生成map表失败

#define E_KEYOPT_COMPRESS_INIT					0x0660	//压缩时初始化失败
#define E_KEYOPT_COMPRESS_EXEC					0x0661	//压缩失败
#define E_KEYOPT_COMPRESS_CATCH					0x0662
#define E_KEYOPT_COMPRESS_OUTMEM				0x0663
#define E_KEYOPT_COMPRESS_LARGER				0x0664
#define E_KEYOPT_DECOMPRESS_INIT				0x0668
#define E_KEYOPT_DECOMPRESS_EXEC				0x0669
#define E_KEYOPT_DECOMPRESS_CATCH				0x066A

#define E_KEYOPT_CERTI_NO_PERMITTION				0x090C//服务器端没有登陆策略 

#define E_KEYOPT_CERTI_VPN_NEWCLT_DEFNO				0x091A//新VPN客户端，缺省没有登录权限
#define E_KEYOPT_CERTI_VPN_NEWCLT_DEFYES			0x091B//新VPN客户端，缺省有登录权限
#define E_KEYOPT_CERTI_VPN_REQUEST				0x091C//客户端请求登录

#define E_KEYOPT_CERTI_VPN_VERIFY_OK_REQUEST			0x0930//认证证书成功，继续
#define E_KEYOPT_CERTI_VPN_VERIFY_OK_NEWCLT_DEFYES		0x0931//认证证书，服务器已经认证通过了，新VPN客户端，缺省没有登录权限
#define E_KEYOPT_CERTI_VPN_VERIFY_OK_NEWCLT_DEFNO		0x0932//认证证书，服务器已经认证通过了,新VPN客户端，缺省有登录权限
#define E_KEYOPT_CERTI_VPN_LICENSE_EXP				0x0933//服务器已经超过最大授权数:如需帮助请联系售后
#define E_KEYOPT_CERTI_VPN_CLT_VERSION_ERR			0x0934//客户端版本错误,策略不符
#define E_KEYOPT_CERTI_VPN_BIND_ERROR				0x0935//无权登陆（VPN）绑定错误
#define E_KEYOPT_CERTI_VPN_VERIFY_OK_WITH_MAPPORT		0x0936//认证成功，并且返回了MapPort的信息

#define E_KEYOPT_CERTI_VPN_UPD_DATA_NUMBER_EXCEED		0x0940//Data包超过限制了
#define E_KEYOPT_CERTI_VPN_UPD_DATA_SAME			0x0941//Data包CRC一致，不用下载了
#define E_KETOPT_CERTI_VPN_UNKNOWN_ERROR			0x0942//未知错误
#define	E_KETOPT_CERTI_VPN_NO_PERMITION_LOGIN			0x0944//无权登陆
#define	E_KETOPT_CERTI_VPN_ALREADT_ONLINE			0x0945//已经在线
#define E_KETOPT_CERTI_VPN_USER_OR_PWD_ERROR			0x0946//用户名或密码错误
#define E_KETOPT_CERTI_VPN_USER_OR_PWD_NOT_EXIT     0x0947//用户名或口令为空
#define E_KETOPT_CERTI_VPN_PIN_NOT_EXIT             0x0948//pin为空
#define E_KETOPT_CERTI_VPN_SIGNATURE_VERIF			0x0949//验证签名错误，签名非法
#define E_KETOPT_CERTI_VPN_OFFLINE_NOT_PERMISION		0x0950//不允许非合法用户主动离线
#define E_KETOPT_CERTI_VPN_NOT_HAVE_SESSION_ID			0x0951//session_id丢失

#define KEY_MIN_PIN_LEN		4	//KEY的PIN码最短的长度
#define KEY_MAX_PIN_LEN		16	//KEY的PIN码最长的长度
#define KEY_MAX_NAME_LEN	32	//KEY的名称最长的长度
#define KEY_MAX_CERT_SN_LEN 0x10  	//证书序列号长度
#define KEY_MAX_SERIAL_LEN	16	//KEY的SID/HID码的长度
#define KEY_LENGTH 128
#define MAX_LENGTH 1024*50

#ifndef WIN32
#ifndef BYTE
#define BYTE unsigned char
#endif
#endif

//移动设备操作系统编码表iMobileDeviceOSType
#define MOBILE_DEVICE_OS_TYPE_ANDROID		1000
#define MOBILE_DEVICE_OS_TYPE_IOS           2000
#define MOBILE_DEVICE_OS_TYPE_MAC_OS		2100
#define MOBILE_DEVICE_OS_TYPE_WINDOWS_XP_32	3000
#define MOBILE_DEVICE_OS_TYPE_WINDOWS_XP_64	3001
#define MOBILE_DEVICE_OS_TYPE_WINDOWS_7_32	3100
#define MOBILE_DEVICE_OS_TYPE_WINDOWS_7_64	3101
#define MOBILE_DEVICE_OS_TYPE_WINDOWS_8_64	3201
#define MOBILE_DEVICE_OS_TYPE_MOBILE_61		3300
#define MOBILE_DEVICE_OS_TYPE_MOBILE_65		3301
#define MOBILE_DEVICE_OS_TYPE_WINCE_5		3400
#define MOBILE_DEVICE_OS_TYPE_WINCE_6		3401
#define MOBILE_DEVICE_OS_TYPE_PHONE_7		3500
#define MOBILE_DEVICE_OS_TYPE_SYMBIAN		4000
#define MOBILE_DEVICE_OS_TYPE_LINUX		9000


#define SYSTEM_PRODUCT_CERT_DEFAULT_PIN "123456"
#define SQLITE_DB_PRIVATE_kEY_TYPE_ENC  0
#define SQLITE_DB_PRIVATE_kEY_TYPE_DEC  1
typedef struct _tag_Frame_Header_
{
	BYTE	bVer;				//协议版本号:  8 bits
	BYTE    bTos;				//产品编号:    8 bits
	BYTE    bZip;				//是否压缩     8 bits
	BYTE    bReserved;			//保留数据1    8 bits 版本标识
	DWORD   dwTotalLen;			//帧总长度:   32 bits （字节为单位）
	WORD    wKeyLen;			//加密通讯密钥实际长度: 16 bits （字节为单位）
	WORD    wFrameChksum;   		//包校验值:   16 bits 
	DWORD   dwOrgLen;			//原始数据长度
} FRAMEHEADER;

typedef struct _tag_App_Header_
{
	BYTE    bMgmtType;			//命令类型：8 bits
	BYTE    bFlowDir;			//命令流向：8 bits
	WORD	wCmdType;			//命令内容：16 bits
	DWORD   dwStatus;			//命令状态：32 bits

} APPHEADER,*PAPPHEADER;

typedef struct _tag_Frame_Package_
{
	FRAMEHEADER Header;			//传输层头数据
	BYTE		CommKey[KEY_LENGTH];    //加密后的通讯密钥
	APPHEADER	HeaderA;		//应用层的头数据
	BYTE		EncRandPub[KEY_LENGTH];	//采用对方公钥加密的随机数
	BYTE		EncRandPri[KEY_LENGTH];	//采用自身私钥加密的随机数
	BYTE            Content[MAX_LENGTH];    //传输数据
}FRAMEPACKAGE;

typedef struct _SERVER_CERTIFY_RESULT_
{
	union
	{
		BYTE Buffer[1024];
		struct {
			DWORD dwServerVersion;							//服务器版本号码			4字节

			//VPN服务参数				12字节
			BYTE  bOwnTraffic;									//是否将所有包都通过VPN网关发
			BYTE  bProcessNumber;								//是否有多进程
			BYTE  bRev[2];
			DWORD dwEncType;										//加密算法标识 0-BF 1-3DES 2-SCB2
			DWORD dwMTU;												//网关设置的MTU值
			DWORD dwClientUPDVersion;						//服务器上客户端升级文件版本号码 4字节

			//负载服务器情况，服务器发送负载量最小的8个服务器给客户端 96字节
			DWORD dwSubServerIP[8];							//负载服务器地址
			DWORD dwSubServerInnerAddress[8];		//负载服务器的eth1地址，内部测试需要使用这个地址
			WORD  wSubServerPort[8];						//负载服务器服务基础端口
			WORD  wSubServerOnline[8];					//负载服务器上面的在线客户端数量
			
			//服务器自身参数
			DWORD dwServerTime_Now;
		};
		struct{
			BYTE Buffer_Small[1023];
			BYTE bVerify;
		};
	};
}SERVERCERTIFYRESULT,*PSERVERCERTIFYRESULT;

typedef struct _SERVER_CERTIFY_RESULT_BIG_
{
	SERVERCERTIFYRESULT result;
	union
	{
		BYTE Buffer[2048];
		struct {
			DWORD dwCertServerSize;
			BYTE bCertServer[2044];
		};
	};
}SERVERCERTIFYRESULT_BIG,*PSERVERCERTIFYRESULT_BIG;

typedef struct _ClientBaseInfo
{
    
    //1000 PAD;2000 SmartPhone;3000 Pos;4000 PC //十进制
    int     iMobileDeviceType;
    //参考附录4 移动设备操作系统编码表
    int  iMobileDeviceOSType; //MOBILE_DEVICE_OS_TYPE_ANDROID
    char  cMobileDeviceOSVersion[16]; //Android 2.3
    int  iMobileDeviceOSVersionLen; //Android 2.3 length
    char  cMobileClientSoftWareVersion[16]; //3.0.1
    int  iMobileClientSoftWareVersionLen; //3.0.1 length
    char  cMobileDeviceOwner[32]; //xxx iPad
    int  iMobileDeviceOwnerLen; //xxx iPad Length
    int  iHardWareID0Len;
    int  iHardWareID1Len;
    int  iHardWareID2Len;
    int  iHardWareID3Len;
    int  iHardWareID4Len; 
    int  iHardWareID5Len; 
    int  iHardWareID6Len; 
    //Android-IMEI,IOS-UDID,Mobile-IMEI,PC-MAC
    char  cHardWareID0[64]; // 硬件标识IMEI/UDID
    char  cHardWareID1[64]; //硬件型号或品牌htc
    char  cHardWareID2[64]; //手机号码
    char  cHardWareID3[64]; //SIM号
    char  cHardWareID4[64]; //预留
    char  cHardWareID5[64]; //存储空间大小 预留
    char  cHardWareID6[256]; //存储空间大小 预留
     
}CLIENTBASEINFO,*PCLIENTBASEINFO;

/*
 *用户名登陆结构体
 */
typedef struct  _passwordloginInfo
{
    int iClientPort;								//客户端端口.//测试需要的
    int iUserNameLen; 							//用户名长度
    int iPWDSourceLen;							//明文密码长度
    int iDPWDSourceLen;							//动态口令原文长度	
    int iPWDEncLen; 								//产品证书公钥加密后的密码长度
    int iDPWDEncLen; 								//产品证书公钥加密后的动态口令长度
    int iPrivateKeySourceLen;				//会话密钥明文长度（privatekey）
    int iPrivateKeyEncLen;					//产品证书公钥加密后的会话密钥（privatekey）长度
    char cUserName[128];						//用户名明文
    char cPWDEnc[256]; 							//加密后的密码
    char cDPWDEnc[256]; 						//加密后的密码
    char cPrivateKeyEnc[256];				//加密后的privatekey  ；加密后的回话ID
    CLIENTBASEINFO cLientBaseInfo;	//填充客户端信息
    char cSign[256];								//对此项以前的结构体内容签名;
    int iSignLen;										//数据包签名长度。这个有私钥长度决定可以	
    
}USERNAMELOGININFO, *PUSERNAMELOGININFO;

//修改口令
typedef struct  _ChangePwd
{
    int iUserNameLen; 										//用户名长度
    int iOldPWDSourceLen;									//旧密码明文密码长度
    int iNewPWDSourceLen;									//新密码原文长度	
    int iOldPWDEncLen; 										//产品证书公钥加密后的旧密码长度
    int iNewPWDEncLen; 										//产品证书公钥加密后的新密码长度
    char cUserName[128];									//用户名明文
    char cOldPWDEnc[256]; 								//加密后的旧密码
    char cNewPWDEnc[256]; 								//加密后的新密码
    char cSign[256];											//对此项以前的结构体内容签名;
    int iSignLen;													//数据包签名长度。这个有私钥长度决定可以	
    
}CHANGPWD, *PCHANGPWD;

/*
*   客户端信息结构体
*   包括通讯包结构等
*/
typedef struct _Client_Info_Single_
{
	union
	{
		BYTE Buffer[10*1024];
		struct 
		{
			DWORD dwNodeId;			//系统的自动编号
            
			DWORD dwEnable;			//接入权限：是否允许接入 0-不允许 1-允许（绑定HD/NET） 2-允许（不和硬件绑定），由服务器修改
            
			DWORD dwKeyLen;			//公钥长度
			char  cName[128];		//客户端的名字
            //  证书：使用证书名字
            //  安全SIM卡，这个名字默认为SIM_CCID，共20+4字符
            //  TF卡写卡，使用？
			BYTE  bSN[16];			//客户端唯一序列号
            //  证书：证书序列号			
            //  安全SIM卡，这个就是CCID，长度10字节
			BYTE  bKey[1024];		//预留的公钥长度
            //  安全SIM卡，这里临时存放下载下来的公钥
			BYTE  bCert[1024*5];	//证书内容，最大5K
            //  证书：证书的具体内容，存放到服务器上应该用Base64进行编码处理
            //  安全SIM卡，这个是用自身私钥加密的CCID，如果公钥解密正确，说明是那个KEY
            //   安全SIM卡，bCert的结构是：前128字节是明文，第一个4字节是DWORD时间，后面接CCID，10字节
            //   接着的128字节是私钥加密后的数据，可用于验证前面数据的正确性
            //   由于有时间参数在里面，因此可以保证这个过程的正确性
			int   iCertLen;			//内容长度
            //  证书：证书数据长度
            
			DWORD dwLastLogin;		//用户状态：上次登录时间，服务器修改
			DWORD dwLastErrorCode;	//用户状态：上次登录的错误值，服务器修改
            
			DWORD	dwClientVpnIP;	//用户状态：客户端汇报分配到的客户端IP地址
			DWORD	dwLastDisconn;	//用户状态：上次断开时间，服务器修改
			DWORD	dwStatus;		//用户状态：当前连接状态，服务器修改
            
			//证书的详细信息，客户端自行解析后发送上来
			char cert_usedepart[96];	//证书使用单位       cert_usedepart char[96]
			char cert_managedepart[96]; //发证单位       cert_managedepart char[96]
			char cert_cardid[32];		//证书使用人身份证号码  cert_cardid char[30]
			char cert_usrname[48];		//证书使用人姓名       usrname char[48]
			char certid[48];			//证书的序列号（字符形式的）
            
			//其他权限
			DWORD dwCanOutNet;			//是否允许上外网
			char cComputer_HD_SN[64];	//计算机第一硬盘序列号，PDA为IMEI号码
			char cComputer_NET_MAC[64]; //计算机第一网卡地址，PDA为ESN
            
			BYTE  bUserType;	//用户类型：0普通证书 1安全SIM卡 2 用户名和密码 modified by jinhaohe,2011-07-05,21:33
			BYTE  bNeedScan;	//0 不需要再次确认 1 需要再次确认
			WORD  wLastResult;	//0 上次确认不存在 1 上次确认存在
            
			//客户端版本相关信息
			DWORD dwClientSoftwareType;	//客户端类型：0 以前版本 VPN_CLIENT_PLATFORM 系列定义
			DWORD dwClientVersion_Main;	//客户端大版本号码
			DWORD dwClientVersion_Build;//客户端Build号码，暂时未适用
            
			// TF 卡序号
			char cTF_ID[16];
			char cSIM_ID[32];
			
			DWORD dwClientNeedMapport;	//客户端是否需要MapPort的信息
			CLIENTBASEINFO cLientBaseInfo;
			long lTC;               // Client time;
			long lTS;               // Server time;
		};
	};
	char cSign[256]; 		// certify prick;
	int  iSignLen;	
}CLIENTINFOSINGLE,*PCLIENTINFOSINGLE;


typedef struct _RandomKey
{
    int iEncLen;   												//KEY或者会话ID的加密长度   
    int iSourceLen; 											//key或者会话ID的原长度;
    char cSecretBuff[256];  							//1key服务器公钥加密后的缓冲;(服务器公钥加密) 2会话ID原文
    char cSign[256];         							//对cSecretBuff的签名缓冲;(1:Key客户端的私钥签名<iEncLen+iSourceLen+cSecretBuff> 2:Sessionid 用服务器私钥签名)
    int iSignLen; 
} RandomKey, *pRandomKey;

//心跳结构体
typedef struct  _Sessioninfo
{
	int iSessionIDLen;											//SessionID长度
	int iKeyBriefLen;												//ckeyBrief长度
	long lNowTime;													//当前系统时间累积毫秒
	char cSessionID[32];										//SessionID原文
	char cKeyBrief[128];										//会话密钥的MD5. 这次算到字节。只用前个
	char cSign[256];												//前项的产品证书签名离线包需要签名。心跳包不需要
	int iSignLen;														//cSign长度
}SESSIONINFO, *PSESSIONINFO;

typedef struct _acl_single_struct
{
	unsigned short  iID;										//ID号码
	unsigned short  target_mapport;					//映射端口号码
	unsigned char   iprotocal;							//TCP:17 UDP:6 ICMP:
	unsigned char   ilog_type;							//0:不记录 1:仅记录起始和流量 2:记录全部详细信息
	unsigned short  target_port;						//端口
	unsigned long   target_address;					//地址
	int   itime_start;											//起始日期
	int   iflow_send;												//总计流量（发送）
	int   iflow_recv;												//总计流量（接受）
	unsigned short 		target_apptype;				//0:CS应用 1:BS应用
	unsigned char 		target_appname[50];		//应用名称
	unsigned char		target_apphome[255];		//应用的主页
}ACLSINGLE,*PACLSINGLE;

#endif //_DEFINE_LINUX_H
