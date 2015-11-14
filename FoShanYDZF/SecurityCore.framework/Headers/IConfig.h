//
//  IConfig.h
//  MSP
//
//  Created by yangli on 11-11-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IConfig : NSObject{

    
}
-(NSString *)getConfigPath;
-(void)setValue:(NSString *)key configValue:(id)value;
-(id)getValue:( NSString *)key;
@end
