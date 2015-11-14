//
//  InnerSafeHelper.m
//  FoShanYDZF
//
//  Created by 曾静 on 13-12-19.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "InnerSafeHelper.h"

static ContextManager *context         = nil;
static IConfig        *mConfig         = nil;
static ILog           *mLog            = nil;
static ICertAuth      *mCert           = nil;
static ISafeTunnel    *mSafeTunnel     = nil;
static IPolicy        *iPolicyInstanse = nil;

@implementation InnerSafeHelper

static InnerSafeHelper *_sharedSingleton = nil;

+ (InnerSafeHelper *) sharedInstance
{
    @synchronized(self)
    {
        if(_sharedSingleton == nil)
        {
            _sharedSingleton = [[InnerSafeHelper alloc] init];
            //初始化配置文件路径
            [[InnerSafeConfig sharedInstance] getConfigPath];
            //初始化SDK
            context = [ContextManager getInstance];
            mConfig = [[context getConfigManager] getIconfigInstance];
            [mConfig setValue:@"server" configValue:@"19.130.250.100"];
            mLog = [[context getLogManager] getLogInstance:V_LOG_TYPE_NOLOG];
            mCert = [[context getCertifyManager] getIcertAuthInstance];
            mSafeTunnel = [[context getSafeTunnelManager] getISafeTunnelInstance];
            iPolicyInstanse = [[context getPolicyManager] getIPolicyInstance];
        }
    }
    return _sharedSingleton;
}

//开启安全通道
- (void)startSafeTunnel
{
    if(mSafeTunnel)
    {
        [mSafeTunnel startSafeTunnel];
    }
}

//关闭安全通道
-(void)stopSafeTunnel
{
    if(mSafeTunnel)
    {
        [mSafeTunnel stopSafeTunnel];
    }
}

//登录
- (BOOL)login
{
    //步骤二:设置服务器 IP 与端口 说明:按照 map 中的 key-value 初始化默认配置参数
    [mConfig setValue:@"server" configValue:@"19.130.250.100"];
    //步骤四:调用认证接口开始认证[该步骤会比较耗时]
    __block BOOL success = NO;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        unsigned long uRet = [context login:V_CERT_AUTH_TYPE_PASSWORD
                                  loginType:V_LOGIN_TYPE_ONLINE
                                   userName:@"hb_test"
                                   password:@"1234qwer"];
        if(uRet != 0)
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                success = NO;
            });
        }
        else
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                success = YES;
            });
        }
    });
    return success;
}

//登录[aCompletionBlock表示认证成功之后执行的Block, aFailureBlock表示认证失败之后执行的Block]
- (void)loginWithCompletion:(InnerSafeBasicBlock)aCompletionBlock
                andWithFail:(InnerSafeBasicBlock)aFailureBlock
{
    self.loginCompletionBlock = aCompletionBlock;
    self.loginFailureBlock = aFailureBlock;
    
    //步骤二:设置服务器 IP 与端口 说明:按照 map 中的 key-value 初始化默认配置参数
    [mConfig setValue:@"server" configValue:@"19.130.250.100"];
    
    //步骤四:调用认证接口开始认证[该步骤会比较耗时]
    __block unsigned long uRet;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        uRet = [context login:V_CERT_AUTH_TYPE_PASSWORD loginType:V_LOGIN_TYPE_ONLINE userName:@"hb_test" password:@"1234qwer"];
        if(uRet == 0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.loginCompletionBlock(uRet);
            });
        }
        else
        {
            if(uRet == E_KETOPT_CERTI_VPN_ALREADT_ONLINE)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.loginCompletionBlock(uRet);
                });
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.loginFailureBlock(uRet);
                });
            }
        }
    });
}

//退出登录
- (BOOL)logout
{
    __block BOOL success = NO;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *username = [mConfig getValue:@"userName"];
        NSString *pwd = [mConfig getValue:@"password"];
        long uRet = [mCert logOut:CERT_AUTH_TYPE_PASSWORD userName:username password:pwd];
        [mSafeTunnel stopSafeTunnel];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (uRet != 0) {
                NSLog(@"离线失败,返回值:[%lu]",uRet);
                success = NO;
            } else {
                NSLog(@"离线成功!");
                success = YES;
            }
        });
    });
    return success;
}

- (void)logoutWithCompletion:(InnerSafeBasicBlock)aCompletionBlock andWithFail:(InnerSafeBasicBlock)aFailureBlock
{
    self.logoutCompletionBlock = aCompletionBlock;
    self.logoutFailureBlock = aFailureBlock;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *username = [mConfig getValue:@"userName"];
        NSString *pwd = [mConfig getValue:@"password"];
        __block long uRet = [mCert logOut:CERT_AUTH_TYPE_PASSWORD userName:username password:pwd];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (uRet != 0) {
                //离线失败
                self.logoutFailureBlock(uRet);
            } else {
                //离线成功!
                [mSafeTunnel stopSafeTunnel];
                self.logoutCompletionBlock(uRet);
            }
        });
    });
}

- (int)getCurrentLoginStatus
{
    if(context)
    {
        return [context getCurrentLoginStatus];
    }
    else
    {
        return -1;
    }
}

//登录错误信息
- (NSString *)checkErrInfo:(unsigned long)err
{
    NSString *errInfo = NULL;
    if (err == CC_OFFLINE_LOGIN_POLICY_NO_PERMISSION)
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"策略不允许离线登录"];
    }
    else if(err == CC_OFFLINE_LOGIN_VERIFY_FAIL)
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"离线验证失败"];
    }
    else if(err == CC_POLICY_SAFETUNNEL_NO_PERMISSION)
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"策略不允许开启通道"];
    }
    else if(err == CC_POLICY_GET_VALUE_ERROR)
    {        
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"获取策略失败"];
    }
    else if(err == E_KETOPT_CERTI_VPN_USER_OR_PWD_ERROR)
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"用户名口令错误"];
    }
    else if(err == E_KETOPT_CERTI_VPN_USER_OR_PWD_NOT_EXIT)
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"用户名或口令为空"];
    }
    else if(err == E_KETOPT_CERTI_VPN_PIN_NOT_EXIT)
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"PIN码为空"];
    }
    else if(err == 0x00000102)
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"PIN码错误"];
    }
    else if(err == E_KEYOPT_SOCKET_CONNET)
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"网络连接失败"];
    }
    else if(err == E_KEYOPT_CERTI_VPN_LICENSE_EXP)
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"客户端数超过服务器授权"];
    }
    else if(err == E_KETOPT_CERTI_VPN_NO_PERMITION_LOGIN)
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"服务器不允许登录"];
    }
    else if(err == E_KETOPT_CERTI_VPN_ALREADT_ONLINE)
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"用户已经在线"];
    }
    else if(err == E_KEYOPT_CERT_VERIFY_GET_SERVERCERT_FAILURE)
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"获取服务器证书失败"];
    }
    else if(err == E_KEYOPT_CERT_READ_FAILURE)
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"获取客户端身份证书失败"];
    }
    else if(err == E_KETOPT_CERTI_VPN_SIGNATURE_VERIF)
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%@",@"验证签名失败"];
    }
    else
    {
        errInfo = [NSString stringWithFormat:@"登录失败:%li",err];
    }
    return errInfo;
}

@end
