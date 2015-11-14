//
//  CLogManager.h
//  test
//
//  Created by wangbingyang on 11-11-3.
//  Copyright 2011年 wonder. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    V_LOG_TYPE_NOLOG =    10, //NO OutPut
    V_LOG_TYPE_CONSOLE =  20, //NSLog
    V_LOG_TYPE_FILE   =   30  //Output Log FILE
}K_LOG_TYPE;

@class ILog;
@interface CLogManager : NSObject{

    ILog    *logInstance;
}

+(id)getInstance ;
-(ILog *)getLogInstance :(K_LOG_TYPE)LOGTYPE;

@end
