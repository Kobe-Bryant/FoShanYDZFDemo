//
//  ICertAuth.h
//  MSP
//
//  Created by yangli on 11-10-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//


#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#define CERT_AUTH_TYPE_KEY 0
#define CERT_AUTH_TYPE_PFX 1
#define CERT_AUTH_TYPE_PASSWORD 2




@interface ICertAuth : NSObject{
    
    NSOperationQueue *queue;
    
   
}
/*登录认证网关
 *intCertDeviceType 1：硬件加密设备认证；
 2：pfx；
 3：用户名口令；
 *userName :登录用户名，如果是TF卡登录，该值为NULL；
 *password :登录口令；
*/
-(long)login:(int)intCertDeviceType 
   loginType:(int)nLoginType
    userName:(NSString *)strUserName 
    password:(NSString *)strPassword;


/*客户端注销
 *intCertDeviceType 1：硬件加密设备认证；
 2：pfx；
 3：用户名口令；
 *userName :登录用户名，如果是TF卡登录，该值为NULL；
 *password :登录口令；
 */
-(long)logOut:(int)intCertDeviceType userName:(NSString *)strUserName password:(NSString *)strPassword;

/*修改TF卡Pin码或用户口令
 *intCertDeviceType 1：硬件加密设备认证；
 2：pfx；
 3：用户名口令；
 *userName :登录用户名，如果是TF卡登录，该值为NULL；
 *password :TF卡Pin码或登录口令；
 *newPassword :TF卡新Pin码或者用户新口令
 */
-(long)modifyPassword:(NSString *)strUserName 
             password:(NSString *)strPassword 
          newPassword:(NSString *)newPasswordModify;
/*发送离线通知
 *intCertDeviceType 1：硬件加密设备认证；
 2：pfx；
 3：用户名口令；
 *userName :登录用户名，如果是TF卡登录，该值为NULL；
 *password :TF卡Pin码或登录口令；
 */
-(long)sendUserOfflineNotify:(int)intCertDeviceType userName:(NSString *)strUserName password:(NSString *)strPassword;
//获取sessonID
-(char *)getSessonID;
//获取加密密钥
-(char *)getPrivateKey;
@end
