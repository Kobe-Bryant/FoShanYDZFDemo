//
//  DefaultDataHelper.h
//  系统中的常量处理
//
//  Created by 曾静 on 13-11-7.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefaultDataHelper : NSObject

/**
    @brief 获取所有的任务名称列表
    @return 名称列表
 */
+ (NSArray *)getTaskTypeNameList;

/**
    @brief 获取任务的代码值列表
    @return 代码值列表
 */
+ (NSArray *)getTaskTypeCodeList;

/**
    @brief 获取指定任务代码值所对应的任务名称
    @param code 任务的代码值
    @return 任务对应的名称
 */
+ (NSString *)getTaskTypeNameByCode:(NSString *)code;

/**
    @brief 获取指定任务名称所对应的代码值
    @param name 任务的名称
    @return 任务对应的代码值
 */
+ (NSString *)getTaskTypeCodeByName:(NSString *)name;

/**
    @brief 获取所有的区域名称列表
    @return 区域的名称列表
 */
+ (NSArray *)getAreaNameList;

/**
    @brief 获取所有的区域代码列表
    @return 区域的代码列表
 */
+ (NSArray *)getAreaCodeList;

/**
    @brief 根据区域的代码值获取区域对应的名称
    @param name 区域代码值
    @return 区域的名称
 */
+ (NSString *)getAreaNameByCode:(NSString *)code;

/**
    @brief 根据区域的名称获取区域对应的代码值
    @param name 区域名称
    @return 区域的代码值
 */
+ (NSString *)getAreaCodeByName:(NSString *)name;

/**
    @brief 获取所有的监管级别代码列表
    @return 监管级别列表
 */
+ (NSArray *)getJGJBCodeList;

/**
    @brief 获取所有的监管级别名称列表
    @return 监管界别名称列表
 */
+ (NSArray *)getJGJBNameList;

/**
    @brief 根据监管级别的名称获取对应的代码值
    @param name 监管级别名称
    @return 监管级别的代码值
 */
+ (NSString *)getJGJBCodeByName:(NSString *)name;

/**
    @brief 根据监管级别的名称获取对应的代码值
    @param name 监管级别代码值
    @return 监管级别名称
 */
+ (NSString *)getJGJBNameByCode:(NSString *)code;

@end
