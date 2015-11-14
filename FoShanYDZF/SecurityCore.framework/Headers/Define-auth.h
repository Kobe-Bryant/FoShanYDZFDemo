#ifndef _DEFINE_AUTH_H_
#define _DEFINE_AUTH_H_

#include "AC_Error.h"

/*
操作句柄定义
*/
typedef unsigned long CC_CONNECTION_HANDLE;				
typedef CC_CONNECTION_HANDLE* PCC_CONNECTION_HANDLE;
typedef unsigned long CC_KEY_HANDLE;				
typedef CC_KEY_HANDLE* PCC_KEY_HANDLE;

#define CC_CONNECTION_HANDLE_INVALIDE 0xFFFFFFFF
#define CC_KEY_HANDLE_INVALIDE 		0xFFFFFFFF

#define CC_CONFIGNAME_PREDEFINE 	"config.ini"
#define CC_CONFIGNAME_USER		"configuser.ini"
#define CC_CONFIGNAME_MAPPORT		"configmap.ini"

#define CERT_PFX_PRODUCT_PIN_SEED "2012.wonder-soft.cn"

#define CC_CONNECTION_PARAM_CRYPTDEVICE_TYPE_AUTO			0x00000800	//指定是自动，根据后面ID里面的类型看
#define CC_CONNECTION_PARAM_CRYPTDEVICE_TYPE_KEY			0x00000100	//指定是令牌
#define CC_CONNECTION_PARAM_CRYPTDEVICE_TYPE_CSP			0x00000200	//指定是CSP里面的证书（暂时不支持）
#define CC_CONNECTION_PARAM_CRYPTDEVICE_TYPE_FILE			0x00000400	//指定是文件（PFX），标识里面指定PFX文件的位置
#define CC_CONNECTION_PARAM_CRYPTDEVICE_TYPE_USER_PASSWORD 		0x00000600	//指定是用户名口令认证
#define CC_CONNECTION_PARAM_CRYPTDEVICE_TYPE_X509   			0x00000800	//指定是X509证书

#define CC_KEY_CIPHER_OPT_TYPE_MASK			0x000000FF	//密码操作的类型
#define CC_KEY_CIPHER_OPT_TYPE_RSA_PUB_ENC		0x00000001	//是RSA的加密操作
#define CC_KEY_CIPHER_OPT_TYPE_RSA_PUB_DEC		0x00000002	//是RSA的解密操作
#define CC_KEY_CIPHER_OPT_TYPE_RSA_PRI_ENC		0x00000003	//是RSA的加密操作
#define CC_KEY_CIPHER_OPT_TYPE_RSA_PRI_DEC		0x00000004	//是RSA的解密操作
#define CC_KEY_CIPHER_OPT_TYPE_SM1_ENC			0x00000005	//是对称算法SM1的加密操作
#define CC_KEY_CIPHER_OPT_TYPE_SM1_DEC			0x00000006	//是对称算法SM1的解密操作
#define CC_KEY_CIPHER_OPT_TYPE_CERTREAD			0x00000007	//读取证书操作

#define CC_KEY_CIPHER_OPT_OBJ_MASK			0x0000FF00	//密码操作的对象码
#define CC_KEY_CIPHER_OPT_OBJ_CERT			0x00000100	//密钥来源：证书
#define CC_KEY_CIPHER_OPT_OBJ_OBJ			0x00000200	//密钥来源：对象，对象参数由PARAM参数指定
#define CC_KEY_CIPHER_OPT_OBJ_INPUT			0x00000300	//密钥来源：输入的密钥

#define CC_KEY_CIPHER_OPT_PADDING_MASK			0x000F0000	//密码操作的编码
#define CC_KEY_CIPHER_OPT_PADDING_PKCS1			0x00010000	//PKCS1编码

#define CC_INFO_TYPE_HARDWARE_ID			0x00000001	//获取硬件标识码
#define CC_INFO_TYPE_ICCID				0x00000002	//获取SIM卡的ICCID
#define CC_INFO_TYPE_ESN				0x00000003	//获取ESN,ESN号是手机CDMA通讯模块的唯一出厂编码
#define CC_INFO_TYPE_IMEI				0x00000004	//获取IMEI,IMEI号是手机GSM（含TD-SCDMA）通讯模块的唯一出厂编码
#define CC_INFO_TYPE_HARDWARE_SN			0x00000005	//手机设备的唯一出厂编码－－SN号
#define CC_INFO_TYPE_FROM_RES				0x00000010	//从Res.ini中获取相关的信息

typedef struct _CC_CONNECTION_PARAM_V1_
{
	union
	{
		unsigned char cBuffer_All[4096];	//总计大小应该是4096
		struct
		{
			//内部变量，用以指示配置文件的状态的
			unsigned long ulParamStatus;	//配置文件的状态 0尚未处理过 1已经处理过了

			//界面程序调用连接的时候，自行从界面中或者用户临时性选择填写的部分
			unsigned long ulLogLevel;		//信息显示等级，见 CC_CONNECTION_PARAM_LOG_ 系列定义
			char cPIN[32];					//用户输入的PIN码，界面程序应该先自行尝试PIN，如果成功了，那么就放这里
			char cPINTun[32];				//底层Tun认证PIN，一般为默认的123456
			char cProductPin[32];		//产品证书PIN码
			
			//服务器信息
			char cServerList[64];									//服务器地址
			unsigned long ulServerPort;						//服务器服务端口号码
			//网络连接选项
			char cDialName[64];										//拨号连接的名称，如果是空，在PC上则不预先拨号，在PDA上则拨默认Internet连接
			unsigned long ulDialRetry;						//拨号连接重试次数
			char cDialCreate_Name[32];						//拨号创建－拨号显示名称
			char cDialCreate_APN[32];							//拨号创建－接入点参数
			char cDialCreate_User[32];						//拨号创建－用户名
			char cDialCreate_Pass[32];						//拨号创建－密码
			char cDialCreate_Number[32];					//拨号创建－拨号
			unsigned long ulDialCreate_CardID;		//拨号用哪个卡0自动 1/2为指定
			//上层认证阶段选项
			unsigned long ulCertifyUseUDP;				//认证使用的协议，0为TCP 1为UDP
			unsigned long ulCertifydeviceType;		//认证使用的加密设备的类型，见 CC_CONNECTION_PARAM_CRYPTDEVICE_TYPE_
			char cCertifyDeviceIdentity[128];			//认证使用的加密设备的标识，根据不同的类型，有不同的标识
			//底层认证阶段选项
			unsigned long ulTunelCertDeviceType;	//底层通道创建的时候使用的证书，参见 CC_CONNECTION_PARAM_CRYPTDEVICE_TYPE_ 
			char cTunelCertDeviceIdentity[128];		//底层通道使用的证书标识，根据不同的类型，有不同的标识
			//底层加密设备
			unsigned long ulTunelCryptDeviceType;	//底层通道使用的加密设备，参见 CC_CONNECTION_PARAM_CRYPTDEVICE_TYPE_ 
			char cTunelCryptDeviceIdentity[128];	//底层通道使用的加密设备，根据不同的类型，有不同的标识
			
			char cUserName[32];										//用户名称
			char cPassword[100];									//用户密码
			char cNewPassword[100];								//用户新密码
		};
	};
}CC_CONNECTION_PARAM_V1,*PCC_CONNECTION_PARAM_V1;

#endif //#ifndef _DEFINE_AUTH_H_









