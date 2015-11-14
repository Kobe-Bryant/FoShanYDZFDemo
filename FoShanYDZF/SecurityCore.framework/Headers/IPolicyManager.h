//
//  IPolicyManager.h
//  MSP
//
//  Created by 杨利 on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IPolicy;
@interface IPolicyManager : NSObject{

    IPolicy     *iPolicyInstance;
}

+(id)getInstance;
-(IPolicy *)getIPolicyInstance;
@end
