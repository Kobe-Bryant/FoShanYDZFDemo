#ifndef KEYRSATOOLS_H
#define KEYRSATOOLS_H

#include "Certify.h"


unsigned long KM_SD_OpenDevice(int iDevType, void **pHandle, char *pP12CertPath, char *pPassword,char *cSDPath, char *cApplyPackageName);

unsigned long KM_SD_ReadCert(int iDevType, void *pHandle, char *pPfxFilePath, char *pPassword, unsigned char *pCertContent,unsigned long *puCertLen);

unsigned long KM_SD_ModifyPassword(int iDevType, void *pHandle, char *pP12CertPath, char *pPassword, char *pNewPassword);

unsigned long KM_SD_Encrypt(int iDevType, void *pHandle, char *pP12CertPath, X509 *pX509Cert, char *pPassword, char *pInData, int iInDataLen, char *pOutData, int *pOutDataLen);

unsigned long KM_SD_Decrypt(int iDevType, void *pHandle, char *pP12CertPath, X509 *pX509Cert, char *pPassword, char *pInData, int iInDataLen, char *pOutData, int *pOutDataLen);

unsigned long KM_SD_Sign(int iDevType, void *pHandle, char *pP12CertPath, char * mdname, unsigned char *pPin, char *pUnSignData, int iUnSignDataLen, char *pSignedData, int *pSignedDataLen);

unsigned long KM_SD_VerifySign(int iDevType, void *pHandle, char *pP12CertPath, X509 *pX509Cert, char * mdname, unsigned char *pPin, unsigned char *pSignedData,unsigned long iSignedDataLen,unsigned char *pUnSignData,unsigned long iUnSignDataLen);

unsigned long KM_SD_Close(int iDevType, void *pHandle);

#endif //KEYRSATOOLS_H
