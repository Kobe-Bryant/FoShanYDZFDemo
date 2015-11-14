//
//  RecordsHelper.h
//  BoandaProject
//
//  Created by 王哲义 on 13-10-8.
//  Copyright (c) 2013年 szboanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqliteHelper.h"

@interface RecordsHelper : SqliteHelper

-(NSDictionary *)queryRecordByWrymc:(NSString*)mc andWryBH:(NSString*)wrybh andTableName:(NSString*)tableName;


-(BOOL)saveRecord:(NSDictionary*)values  andTableName:(NSString*)tableName;


-(NSArray *)queryWDRecordByBH:(NSString*)blbh;
//存储问答表数据
-(BOOL)saveWDRecordWT:(NSArray*)wtAry andDA:(NSArray*)daAry BLBH:(NSString*)bh;



@end
