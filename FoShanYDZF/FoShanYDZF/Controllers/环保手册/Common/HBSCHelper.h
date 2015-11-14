//
//  HBSCHelper.h
//  BoandaProject
//
//  Created by PowerData on 13-10-16.
//  Copyright (c) 2013年 szboanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqliteHelper.h"

@interface HBSCHelper : SqliteHelper



- (NSArray*) searchByFIDH:(NSString*)strFIDH;


- (NSArray*) searchByFGMC:(NSString*)keywords;

@end
