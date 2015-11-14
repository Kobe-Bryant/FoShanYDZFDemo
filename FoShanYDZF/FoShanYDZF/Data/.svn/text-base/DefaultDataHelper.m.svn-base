//
//  DefaultDataHelper.m
//  系统中常量处理
//
//  Created by 曾静 on 13-11-7.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "DefaultDataHelper.h"

@implementation DefaultDataHelper

/**
    @brief 获取所有的任务名称列表
    @return 名称列表
 */
+ (NSArray *)getTaskTypeNameList
{
    NSArray *ary = [[NSArray alloc] initWithObjects:@"环境信访", @"行政处罚", @"污染源监察", nil];
    return ary;
}

/**
    @brief 获取任务的代码值列表
    @return 代码值列表
 */
+ (NSArray *)getTaskTypeCodeList
{
    NSArray *ary = [[NSArray alloc] initWithObjects:@"43000000000000005", @"43000000000000009", @"43000000003", nil];
    return ary;
}

/**
    @brief 获取指定任务代码值所对应的任务名称
    @param code 任务的代码值
    @return 任务对应的名称
 */
+ (NSString *)getTaskTypeNameByCode:(NSString *)code
{
    NSArray *ary1 = [[NSArray alloc] initWithObjects:@"环境信访", @"行政处罚", @"污染源监察", nil];
    NSArray *ary2 = [[NSArray alloc] initWithObjects:@"43000000000000005", @"43000000000000009", @"43000000003", nil];
    int index = -1;
    for(int i = 0; i < ary2.count; i++)
    {
        NSString *c =  [ary2 objectAtIndex:i];
        if([c isEqualToString:code])
        {
            index = i;
            break;
        }
    }
    if(index == -1)
        return @"";
    return ary1[index];
}

/**
    @brief 获取指定任务名称所对应的代码值
    @param name 任务的名称
    @return 任务对应的代码值
 */
+ (NSString *)getTaskTypeCodeByName:(NSString *)name
{
    NSArray *ary1 = [[NSArray alloc] initWithObjects:@"环境信访", @"行政处罚", @"污染源监察", nil];
    NSArray *ary2 = [[NSArray alloc] initWithObjects:@"43000000000000005", @"43000000000000009", @"43000000003", nil];
    int index = -1;
    for(int i = 0; i < ary1.count; i++)
    {
        NSString *c =  [ary1 objectAtIndex:i];
        if([c isEqualToString:name])
        {
            index = i;
            break;
        }
    }
    if(index == -1)
        return @"";
    return ary2[index];
}

/**
    @brief 获取所有的区域名称列表
    @return 区域的名称列表
 */
+ (NSArray *)getAreaNameList
{
    NSArray *ary = [[NSArray alloc] initWithObjects:@"市辖区", @"禅城区", @"南海区", @"顺德区", @"三水区", @"高明区", nil];
    return ary;
}

/**
    @brief 获取所有的区域代码列表
    @return 区域的代码列表
 */
+ (NSArray *)getAreaCodeList
{
    NSArray *ary = [[NSArray alloc] initWithObjects:@"440601000000", @"440604000000", @"440605000000", @"440606000000", @"440607000000", @"440608000000", nil];
    return ary;
}

/**
    @brief 根据区域的代码值获取区域对应的名称
    @param name 区域代码值
    @return 区域的名称
 */
+ (NSString *)getAreaNameByCode:(NSString *)code
{
    NSArray *ary1 = [[NSArray alloc] initWithObjects:@"市辖区", @"禅城区", @"南海区", @"顺德区", @"三水区", @"高明区", nil];
    NSArray *ary2 = [[NSArray alloc] initWithObjects:@"440601000000", @"440604000000", @"440605000000", @"440606000000", @"440607000000", @"440608000000", nil];
    int index = -1;
    for(int i = 0; i < ary2.count; i++)
    {
        NSString *c =  [ary2 objectAtIndex:i];
        if([c isEqualToString:code])
        {
            index = i;
            break;
        }
    }
    if(index == -1)
        return @"";
    return ary1[index];
}

/**
    @brief 根据区域的名称获取区域对应的代码值
    @param name 区域名称
    @return 区域的代码值
 */
+ (NSString *)getAreaCodeByName:(NSString *)name
{
    NSArray *ary1 = [[NSArray alloc] initWithObjects:@"市辖区", @"禅城区", @"南海区", @"顺德区", @"三水区", @"高明区", nil];
    NSArray *ary2 = [[NSArray alloc] initWithObjects:@"440601000000", @"440604000000", @"440605000000", @"440606000000", @"440607000000", @"440608000000", nil];
    int index = -1;
    for(int i = 0; i < ary1.count; i++)
    {
        NSString *c =  [ary1 objectAtIndex:i];
        if([c isEqualToString:name])
        {
            index = i;
            break;
        }
    }
    if(index == -1)
        return @"";
    return ary2[index];
}

/**
    @brief 获取所有的监管级别代码列表
    @return 监管级别列表
 */
+ (NSArray *)getJGJBCodeList
{
    NSArray *ary = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    return ary;
}

/**
    @brief 获取所有的监管级别名称列表
    @return 监管界别名称列表
 */
+ (NSArray *)getJGJBNameList
{
    NSArray *ary = [[NSArray alloc] initWithObjects:@"国控", @"省控", @"市控", @"区控", @"非控", nil];
    return ary;
}

/**
    @brief 根据监管级别的名称获取对应的代码值
    @param name 监管级别名称
    @return 监管级别的代码值
 */
+ (NSString *)getJGJBCodeByName:(NSString *)name
{
    NSArray *ary1 = [[NSArray alloc] initWithObjects:@"国控", @"省控", @"市控", @"区控", @"非控", nil];
    NSArray *ary2 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    int index = -1;
    for(int i = 0; i < ary1.count; i++)
    {
        NSString *c =  [ary1 objectAtIndex:i];
        if([c isEqualToString:name])
        {
            index = i;
            break;
        }
    }
    if(index == -1)
        return @"";
    return ary2[index];
}

/**
    @brief 根据监管级别的名称获取对应的代码值
    @param name 监管级别代码值
    @return 监管级别名称
 */
+ (NSString *)getJGJBNameByCode:(NSString *)code
{
    NSArray *ary1 = [[NSArray alloc] initWithObjects:@"国控", @"省控", @"市控", @"区控", @"非控", nil];
    NSArray *ary2 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    int index = -1;
    for(int i = 0; i < ary2.count; i++)
    {
        NSString *c =  [ary2 objectAtIndex:i];
        if([c isEqualToString:code])
        {
            index = i;
            break;
        }
    }
    if(index == -1)
        return @"";
    return ary1[index];
}

@end
