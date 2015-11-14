//
//  InnerSafeHelper.h
//  FoShanYDZF
//
//  Created by 曾静 on 13-12-19.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InnerSafeConfig.h"

#import <SecurityCore/ContextManager.h>
#import <SecurityCore/ICertAuth.h>
#import <SecurityCore/CCertManager.h>

#import <SecurityCore/IConfig.h>
#import <SecurityCore/CConfigManager.h>

#import <SecurityCore/ISafeTunnel.h>
#import <SecurityCore/CSafeTunnelManager.h>

#import <SecurityCore/IPolicy.h>
#import <SecurityCore/IPolicyManager.h>
#import <SecurityCore/Certify.h>

#import <SecurityCore/ILog.h>
#import <SecurityCore/CLogManager.h>

//登录状态
#define OFFLINE_LOGIN    1
#define ONLINE           2
#define OFFLINE          3
#define LOGIN_NONE       4
#define LOGIN_FAIL       9
#define LOGIN_ERROR      10
#define OFFLINE_LOGINSUCC 1

typedef void (^InnerSafeBasicBlock)(unsigned long uRet);

@interface InnerSafeHelper : NSObject

@property (nonatomic, copy) InnerSafeBasicBlock loginCompletionBlock;
@property (nonatomic, copy) InnerSafeBasicBlock loginFailureBlock;
@property (nonatomic, copy) InnerSafeBasicBlock logoutCompletionBlock;
@property (nonatomic, copy) InnerSafeBasicBlock logoutFailureBlock;

+ (InnerSafeHelper *) sharedInstance;

//内网网关登录认证
- (BOOL)login;

/**
 *  内网网关登录认证
 *
 *  @param aCompletionBlock （必选）登录成功后的处理代码块
 *  @param aFailureBlock （必选）登录失败后的处理代码块
 */
- (void)loginWithCompletion:(InnerSafeBasicBlock)aCompletionBlock andWithFail:(InnerSafeBasicBlock)aFailureBlock;

//退出登录
- (BOOL)logout;

/**
 *  内网认证注销
 *
 *  @param aCompletionBlock （必选）注销成功后的处理代码块
 *  @param aFailureBlock （必选）注销失败后的处理代码块
 */
- (void)logoutWithCompletion:(InnerSafeBasicBlock)aCompletionBlock andWithFail:(InnerSafeBasicBlock)aFailureBlock;

//开启安全通道
- (void)startSafeTunnel;

//关闭安全通道
- (void)stopSafeTunnel;

//获取当前的登陆状态
- (int)getCurrentLoginStatus;

//错误代码信息
- (NSString *)checkErrInfo:(unsigned long)err;

@end
