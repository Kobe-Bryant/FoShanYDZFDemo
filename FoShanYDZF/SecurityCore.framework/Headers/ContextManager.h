//
//  ContextManager.h
//  MSP
//
//  Created by yangli on 11-11-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define K_MOBILE_SAFE_AUTHENTICATION_TYPE @"authType"
#define V_CERT_AUTH_TYPE_KEY        0
#define V_CERT_AUTH_TYPE_PFX        1
#define V_CERT_AUTH_TYPE_PASSWORD   2

#define K_MOBILE_SAFE_LOGIN_TYPE          @"loginType"
#define V_LOGIN_TYPE_ONLINE         0
#define V_LOGIN_TYPE_OFFLINE        1

#define K_MOBILE_SAFE_USER_LOGIN_STATUS   @"loginStatus"
#define V_MOBILE_SAFE_USER_LOGIN_STATUS_OFFLINE 0
#define V_MOBILE_SAFE_USER_LOGIN_STATUS_ONLINE  1

#define K_MOBILE_SAFE_SAFE_TUNNEL_STATUS  @"tunnelStatus"
#define V_MOBILE_SAFE_SAFE_TUNNEL_STATUS_RUNNING    1
#define V_MOBILE_SAFE_SAFE_TUNNEL_STATUS_STOPED     0


#define K_MOBILE_SAFE_VPN_SERVER_IP       @"server"
#define K_MOBILE_SAFE_VPN_SERVER_PORT     @"port"
#define K_MOBILE_SAFE_PFS_FILE_ROOT_PATH  @"dataPath"
#define V_MOBILE_SAFE_PFS_FILE_DEFAULT_ROOT_PATH    @"documents/LFSDATA"


@class CConfigManager;
@class CLogManager;
@class CCertManager;
@class CSafeTunnelManager;
@class CLFSManager;
@class CCertKeyManager;
@class CSysInfoManager;
@class CPolicyManager;
@class SystemStatusInfo;


@interface WSError : NSObject {

    long      wsErrorCode;
    NSString *wsErrorDescription;
    
}
@property(atomic,assign)long wsErrorCode;
@property(atomic,copy)NSString *wsErrorDescription;
@end


@interface ContextManager : NSObject{
    
    CConfigManager  *configManager;
    CLogManager     *logManager;
    CCertManager    *certManager;
    CSafeTunnelManager  *safeTunnelManager;
//    CLFSManager        *lfsManager; //mdf zotn
    CCertKeyManager *certKeyManager;
    CSysInfoManager *sysInfoManager;
    CPolicyManager  *policyManager;
    SystemStatusInfo *iSystemStatusInstance;
}
//构造
+ (id)getInstance;
-(void)initialize:(NSDictionary *)map;

//构析
-(void)dealloc;

//获取组件的管理接口
-(id)getConfigManager;
-(id)getLogManager;
-(id)getCertifyManager;
-(id)getSafeTunnelManager;
-(id)getLfsManger;
-(id)getSysInfoManager;
-(id)getPolicyManager;

/*登录认证网关
 *intCertDeviceType 1：硬件加密设备认证；
 2：pfx；
 3：用户名口令；
 *userName :登录用户名，如果是TF卡登录，该值为NULL；
 *password :登录口令；
 */
-(unsigned long)login:(int)intCertDeviceType loginType:(int)nLoginType userName:(NSString *)strUserName password:(NSString *)strPassword;

/*退出
 *intCertDeviceType 1：硬件加密设备认证；
 2：pfx；
 3：用户名口令；
 *userName :登录用户名，如果是TF卡登录，该值为NULL；
 *password :登录口令；
 */
-(unsigned long)logout;

/*修改用户口令
 *userName :登录用户名，如果是TF卡登录，该值为NULL；
 *password :登录口令；
 *newPassword :用户新口令
 */
-(long)modifyPassword:(NSString *)strUserName 
             password:(NSString *)strPassword 
          newPassword:(NSString *)newPasswordModify;

/*设置参数
 *1:    key     参数关键字
 *2:    value   参数值
 */
-(void)setContextParam:(NSString *)key paramValue:(id)value;

/*获取参数
 *1：    key     参数关键字
 *2:    return   返回值，参数值
 */
-(id)getContextParam:(NSString *)key;

//获取上一个错误信息
-(WSError *)getLastErrorInfo;

//获取当前认证状态
-(int)getCurrentLoginStatus;

@end






