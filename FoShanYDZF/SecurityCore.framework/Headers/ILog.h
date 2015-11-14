//
//  ILog.h
//  MSP
//
//  Created by wangbingyang on 11-11-3.
//  Copyright 2011年 wonder. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
	V_LOG_LEVEL_ERROR =   0,   // ERROR
	V_LOG_LEVEL_WARNING = 21,  // WARNING
	V_LOG_LEVEL_INFO =    35,  // INFO
	V_LOG_LEVEL_DEBUG =   55,  // DEBUG
	V_LOG_LEVEL_VERBOSE = 1000 //VERBOSE
}K_LOG_LEVEL;

@interface ILog : NSObject
{
    int nLevel;
}


-(void)writeLog;



-(void) logDebug:(NSString*) strLogTag LogInfo :(NSString*)strLogInfo, ...;

-(void) logError:(NSString*) strLogTag LogInfo :(NSString*)strLogInfo, ...;

-(void) logInfo:(NSString*) strLogTag LogInfo :(NSString*)strLogInfo, ...;

-(void) logWarn:(NSString*) strLogTag LogInfo :(NSString*)strLogInfo, ...;

-(void) logVerbose:(NSString*) strLogTag LogInfo :(NSString*)strLogInfo, ...;

-(void) logPrint:(K_LOG_LEVEL) LEVEL LogTag: (NSString*) strLogTag LogInfo :(NSString*)strLogInfo, ...;

-(void) doPrint :(NSString*)strTag Log :(NSString*)strLog LEVEL : (K_LOG_LEVEL) LEVEL;

-(void) setPrintLevel :(K_LOG_LEVEL) LEVEL;

@end
