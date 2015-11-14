//
//  InnerSafeConfig.m
//  FoShanYDZF
//
//  Created by 曾静 on 13-12-23.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "InnerSafeConfig.h"

static InnerSafeConfig *_sharedSingleton = nil;

@implementation InnerSafeConfig

+ (InnerSafeConfig *)sharedInstance
{
    @synchronized(self)
    {
        if(_sharedSingleton == nil)
        {
            _sharedSingleton = [[InnerSafeConfig alloc] init];
        }
    }
    return _sharedSingleton;
}

//获取配置文件的路径
-(NSString *)getConfigPath
{
    BOOL success;
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask,
                                                        YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    NSString *configPath = [documentDirectory stringByAppendingPathComponent:kConfigPath];
    
    success = [fileManager fileExistsAtPath:configPath];//确认文件是否存在
	if (!success)
	{
		NSLog(@"文件不存在，需要沙盒中查找并转存，请等待");
        //如果没有，则寻址找到config并且copy到ConfigPath；
        NSString *defaultPath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:kConfigPath];
        NSLog(@"defaultPath is %@",defaultPath);
        success = [fileManager copyItemAtPath:defaultPath toPath:configPath error:&error];
        if (!success) {
            NSLog(@"ConfigPath not found !!!");
        }
        NSLog(@"ConfigPath is %@",configPath);
	}
    return configPath;
    
}

@end
