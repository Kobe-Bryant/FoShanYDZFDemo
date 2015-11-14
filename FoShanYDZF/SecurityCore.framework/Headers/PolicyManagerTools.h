#ifndef POLICY_MANAGER_TOOLS_H
#define POLICY_MANAGER_TOOLS_H

//Policy Define
#define	K_SAFE_POLICY_HEARTBEAT_TIME			"XinTiaoShiJian"	//int

#define	K_SAFE_POLICY_OFFLINE_TIME			"LiXianShiJian"	//int

#define	String K_SAFE_POLICY_WHETHER_LOCK_SCREEN	"SuoPing"	//0:not suo 1:yes
#define	V_SAFE_POLICY_SCREEN_UNLOCK			0
#define	V_SAFE_POLICY_SCREEN_LOCK			1

#define	K_SAFE_POLICY_WHETHER_START_SAFE_TUNNEL		"AnQuanTongDao"
#define	V_SAFE_POLICY_SAFE_TUNNEL_NOT_START 		0
#define	V_SAFE_POLICY_SAFE_TUNNEL_START 		1

#define	K_SAFE_POLICY_WHETHER_PERMISSION_OFFLINE_LOGIN "LiXianDengLu"
#define	V_SAFE_POLICY_OFFLINE_LOGIN_NOT_PERMISSION	0
#define	V_SAFE_POLICY_OFFLINE_LOGIN_PERMISSION		1

#define	K_SAFE_POLICY_AUTHENTICATION_MODE 		"RenZhengFS"	//0:password	
#define	V_SAFE_POLICY_AUTHENTICATION_MODE_PASSWORD	0
#define	V_SAFE_POLICY_AUTHENTICATION_MODE_KEY 		1

#define	K_SAFE_POLICY_WHETHER_PERMISSION_WIFI 		"WuXian"
#define	V_SAFE_POLICY_WIFI_DISABLE			0
#define	V_SAFE_POLICY_WIFI_ENABLE 			1

#define	K_SAFE_POLICY_WHETHER_PERMISSION_BLUETOOTH 	"LanYa"
#define	V_SAFE_POLICY_BLUETOOTH_DISABLE 		0
#define	V_SAFE_POLICY_BLUETOOTH_ENABLE 			1

#define	K_SAFE_POLICY_SERVER_ADDRESS_LIST		"FuWuQiDiZhi"

#define	K_SAFE_POLICY_IN_NETWORK_APPLY_LIST		"YingYongFWLB"

unsigned long Policy_WritePolicyToFile(char *pPackagePath, char *pPolicyData, int iPolicyDataLen);

unsigned long Policy_GetPolicyString(char *pPackagePath, char *pKey, char *pValue);

unsigned long Policy_GetPolicyLong(char *pPolicyFilePath, char *pKey);

unsigned long GetValue(char *pPackagePath, char *pKey, char *pValue, int *pKeyValueLen);

unsigned long Tool_XML_Data_GetValue(char *pXmlData, int iXmlDataLen, char *pSectionHeader, char *pKeyHeader, char *pKey, char *pValueHeader, char *pValue, int *pValueLen);
#endif	//POLICY_MANAGER_TOOLS_H
