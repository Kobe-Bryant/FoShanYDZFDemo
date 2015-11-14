//
//  IPolicy.h
//  MSP
//
//  Created by 杨利 on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPolicy : NSObject

-(unsigned long)getPolicyValue:(char *)key value:(char *)policyValue;

@end
