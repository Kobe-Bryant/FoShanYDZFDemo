#ifndef KEY_MANAGER_TOOLS_H
#define KEY_MANAGER_TOOLS_H

void  PKM_GenerateRanddomKey(int iKeyLenType, char * pKeyValue);

unsigned long PKM_GetEncryptData (char *pPackageName, int iCerId, int iArithmeticId, char * pCertFilePath, char *pPass, char *pRandKey, int *pRandKeyLen);

unsigned long PKM_GetDecryptData (char *pPackageName, int iCerId, int iArithmeticId, char * pCertFilePath, char *pPass, char *pUserKey, int *pUserKeyLen);

unsigned long PKM_SignData (char *pPackageName, int iCerId, int iArithmeticId, char * pCertFilePath, char *pPass, char *pUnSignData, int iUnSignDataLen, char *pSignedData, int *pSignedDataLen);

unsigned long PKM_VerifySignData (char *pPackageName, int iCerId, int iArithmeticId, char * pCertFilePath, char *pPass, char *pUnSignData, int iUnSignDataLen, char *pSignedData, int *pSignedDataLen);

unsigned long PKM_ModifyPassword(char *pPackageName, int iCerId, char *pCertFilePath, char *pPassword, char *pNewPassword);

unsigned long PKM_Databases_PrivateKey(char *pPackageName, int iOperateType, char * pCertFilePath, char *pPass, char *pDatabasePath, char *pKeyValue, int *pKeyValueLen);

unsigned long DatabaseConfigSetValue(char *pPackageName, char* pConfigName,char *cParam);
#endif	//KEY_MANAGER_TOOLS_H
