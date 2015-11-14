//
//  RecordsHelper.m
//  BoandaProject
//
//  Created by 王哲义 on 13-10-8.
//  Copyright (c) 2013年 szboanda. All rights reserved.
//

#import "RecordsHelper.h"
#import "GUIDGenerator.h"
#import "FMDatabaseAdditions.h"

@implementation RecordsHelper

//查询本地暂存的数据
-(NSDictionary *)queryRecordByWrymc:(NSString*)mc andWryBH:(NSString*)wrybh andTableName:(NSString*)tableName
{
    if(isDbOpening == NO)
    {
        [self openDataBase];
    }
    
    NSMutableArray *__block ary = [[NSMutableArray alloc] initWithCapacity:10];
    NSString *sql  =  nil;
    if ([wrybh length] > 0)
    {
        sql = [NSString stringWithFormat:@"SELECT * from %@ where WRYBH  ='%@' order by CJSJ desc ",tableName,wrybh];
    }
    else
    {
        sql = [NSString stringWithFormat:@"SELECT * from %@  where WRYMC ='%@' order by CJSJ desc ",tableName,mc];
    }
    [self.dbQueue inDatabase:^(FMDatabase *db)
    {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            [ary addObject:[rs resultDictionary]];
            break;
        }
        [rs close];
    }];
    if([ary count] > 0)
    {
        return [ary objectAtIndex:0];
    }
    return nil;
}

//暂存数据
-(BOOL)saveRecord:(NSDictionary*)values  andTableName:(NSString*)tableName
{
    if(isDbOpening == NO)
    {
        [self openDataBase];
    }
    
    NSMutableString *sqlstr = [NSMutableString stringWithCapacity:100];
    NSMutableString *fieldStr = [NSMutableString stringWithCapacity:50];
    NSMutableString *valueStr = [NSMutableString stringWithCapacity:50];
    NSArray *aryKeys = [values allKeys];
    FMDatabase *db = [self.dbQueue database];
    
    if(db == nil)
    {
        return NO;
    }
    
    for(NSString *field in aryKeys)
    {
        //查看是否有该列
        if([db columnExists:field inTableWithName:tableName])
        {
            [fieldStr appendFormat:@"%@,",field];
            [valueStr appendFormat:@"'%@',",[values objectForKey:field]];
        }
    }
    
    if([fieldStr length] >0 && [valueStr length] >0)
    {
        [sqlstr appendFormat:@"insert into %@(%@) values(%@)",tableName,[fieldStr substringToIndex:([fieldStr length]-1)],[valueStr substringToIndex:([valueStr length]-1)]];
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            BOOL rs = [db executeUpdate:sqlstr];
            if (rs == NO) {
                NSLog(@"sql err data:%@",sqlstr);
            }
        }];
        return YES;
    }
    return NO;
}

//查询问答记录
-(NSArray *)queryWDRecordByBH:(NSString*)blbh
{
    if(isDbOpening == NO)
    {
        [self openDataBase];
    }
    NSMutableArray *__block ary = [[NSMutableArray alloc] initWithCapacity:10];
    if ([blbh length] == 0)
    {
        return nil;
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT * from T_YDZF_WDB where BLBH  ='%@'  order by PXH ",blbh];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            [ary addObject:[rs resultDictionary] ];
        }
        [rs close];
    }];
    return ary;
}

//存储问答表数据
-(BOOL)saveWDRecordWT:(NSArray*)wtAry andDA:(NSArray*)daAry BLBH:(NSString*)bh
{
    if(isDbOpening == NO)
    {
        [self openDataBase];
    }
    if(wtAry == nil || [wtAry count] == 0)
    {
        return NO;
    }
    if([wtAry count] != [daAry count])
    {
        return NO;
    }
    FMDatabase *db = [self.dbQueue database];
    if(db == nil)return NO;
    [db beginTransaction];
    int i = 0;
    for(NSString *strWT in wtAry)
    {
        NSString *sqlstr = [NSString stringWithFormat:@"insert into T_YDZF_WDB(BH,BLBH,WT,DA,PXH) values(%d,'%@','%@','%@',%d)",i,bh,strWT,[daAry objectAtIndex:i],i];
        i++;
        [db executeUpdate:sqlstr];
    }
    [db commit];
    return YES;
}

@end
