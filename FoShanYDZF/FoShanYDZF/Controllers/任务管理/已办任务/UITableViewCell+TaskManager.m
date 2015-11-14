//
//  UITableViewCell+TaskManager.m
//  FoShanYDZF
//
//  Created by 曾静 on 13-11-5.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "UITableViewCell+TaskManager.h"

@implementation UITableViewCell (TaskManager)

+(UITableViewCell*)makeSubCell:(UITableView *)tableView andWithTitle1:(NSString *)aTitle1 andWithTitle2:(NSString *)aTitle2 andWithTitle3:(NSString *)aTitle3 andWithTaskType:(NSString *)taskType
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"CustomTaskCell_%@", taskType];
	UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (aCell == nil)
    {
        aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UIImageView *typeImageView = nil;
    UILabel* lblTitle1 = nil;
	UILabel* lblTitle2 = nil;
    UILabel* lblTitle3 = nil;
    
	if (aCell.contentView != nil)
	{
        typeImageView = (UIImageView *)[aCell.contentView viewWithTag:1];
		lblTitle1 = (UILabel *)[aCell.contentView viewWithTag:2];
		lblTitle2 = (UILabel *)[aCell.contentView viewWithTag:3];
        lblTitle3 = (UILabel *)[aCell.contentView viewWithTag:4];
	}
	
	if (typeImageView == nil)
    {
        CGRect tRect1 = CGRectMake(14, 20, 80, 80);
		typeImageView = [[UIImageView alloc] initWithFrame:tRect1];
		[typeImageView setBackgroundColor:[UIColor clearColor]];
        typeImageView.tag = 1;
		[aCell.contentView addSubview:typeImageView];
        
		CGRect tRect2 = CGRectMake(110, 5, 590, 35);
		lblTitle1 = [[UILabel alloc] initWithFrame:tRect2];
		[lblTitle1 setBackgroundColor:[UIColor clearColor]];
		[lblTitle1 setTextColor:[UIColor blackColor]];
		lblTitle1.font = [UIFont fontWithName:@"Helvetica" size:19.0];
		lblTitle1.textAlignment = UITextAlignmentLeft;
		lblTitle1.tag = 2;
        lblTitle1.numberOfLines = 1;
		[aCell.contentView addSubview:lblTitle1];
        
		
		CGRect tRect3 = CGRectMake(110, 40, 600, 35);
		lblTitle2 = [[UILabel alloc] initWithFrame:tRect3];
		[lblTitle2 setBackgroundColor:[UIColor clearColor]];
		[lblTitle2 setTextColor:[UIColor blackColor]];
		lblTitle2.font = [UIFont fontWithName:@"Helvetica" size:19.0];
		lblTitle2.textAlignment = UITextAlignmentLeft;
		lblTitle2.tag = 3;
        lblTitle2.numberOfLines = 1;
		[aCell.contentView addSubview:lblTitle2];
        
        CGRect tRect4 = CGRectMake(110, 77, 600, 35);
		lblTitle3 = [[UILabel alloc] initWithFrame:tRect4];
		[lblTitle3 setBackgroundColor:[UIColor clearColor]];
		[lblTitle3 setTextColor:[UIColor blackColor]];
		lblTitle3.font = [UIFont fontWithName:@"Helvetica" size:19.0];
		lblTitle3.textAlignment = UITextAlignmentLeft;
		lblTitle3.tag = 1;
        lblTitle3.numberOfLines = 1;
		[aCell.contentView addSubview:lblTitle3];
        
	}
    
	if (aTitle1 == nil) aTitle1 = @"";
    if (aTitle2 == nil) aTitle2 = @"";
    if (aTitle3 == nil) aTitle3 = @"";
    if([taskType isEqualToString:@"43000000003"])
    {
        //污染源监察 
        [typeImageView setImage:[UIImage imageNamed:@"type_icon_inspect.png"]];
    }
    else if([taskType isEqualToString:@"43000000002"])
    {
        //专项行动
        [typeImageView setImage:[UIImage imageNamed:@"type_icon_special.png"]];
    }
    else if([taskType isEqualToString:@"43000000000000005"])
    {
        //环境信访
        [typeImageView setImage:[UIImage imageNamed:@"type_icon_hjxf.png"]];
    }
    else if([taskType isEqualToString:@"43000000000000009"])
    {
        //行政处罚
        [typeImageView setImage:[UIImage imageNamed:@"type_icon_case.png"]];
    }
    else if([taskType isEqualToString:@"31000000000090001"])
    {
        //应急处置
        [typeImageView setImage:[UIImage imageNamed:@"type_icon_emergency.png"]];
    }
	if (lblTitle1 != nil) [lblTitle1 setText:[NSString stringWithFormat:@"%@",aTitle1]];
    if (lblTitle2 != nil) [lblTitle2 setText:[NSString stringWithFormat:@"%@",aTitle2]];
    if (lblTitle3 != nil) [lblTitle3 setText:[NSString stringWithFormat:@"%@",aTitle3]];
	
    aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return aCell;
}

+(UITableViewCell*)makeSubCell:(UITableView *)tableView andWithTitle1:(NSString *)aTitle1 andWithTitle2:(NSString *)aTitle2 andWithTitle3:(NSString *)aTitle3 andWithRecordType:(NSString *)recordType
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"CustomRecordCell_%@", recordType];
	UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (aCell == nil)
    {
        aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UIImageView *typeImageView = nil;
    UILabel* lblTitle1 = nil;
	UILabel* lblTitle2 = nil;
    UILabel* lblTitle3 = nil;
    
	if (aCell.contentView != nil)
	{
        typeImageView = (UIImageView *)[aCell.contentView viewWithTag:1];
		lblTitle1 = (UILabel *)[aCell.contentView viewWithTag:2];
		lblTitle2 = (UILabel *)[aCell.contentView viewWithTag:3];
        lblTitle3 = (UILabel *)[aCell.contentView viewWithTag:4];
	}
	
	if (typeImageView == nil)
    {
        CGRect tRect1 = CGRectMake(14, 20, 80, 80);
		typeImageView = [[UIImageView alloc] initWithFrame:tRect1];
		[typeImageView setBackgroundColor:[UIColor clearColor]];
        typeImageView.tag = 1;
		[aCell.contentView addSubview:typeImageView];
        
		CGRect tRect2 = CGRectMake(110, 5, 590, 35);
		lblTitle1 = [[UILabel alloc] initWithFrame:tRect2];
		[lblTitle1 setBackgroundColor:[UIColor clearColor]];
		[lblTitle1 setTextColor:[UIColor blackColor]];
		lblTitle1.font = [UIFont fontWithName:@"Helvetica" size:19.0];
		lblTitle1.textAlignment = UITextAlignmentLeft;
		lblTitle1.tag = 2;
        lblTitle1.numberOfLines = 1;
		[aCell.contentView addSubview:lblTitle1];
        
		
		CGRect tRect3 = CGRectMake(110, 40, 600, 35);
		lblTitle2 = [[UILabel alloc] initWithFrame:tRect3];
		[lblTitle2 setBackgroundColor:[UIColor clearColor]];
		[lblTitle2 setTextColor:[UIColor blackColor]];
		lblTitle2.font = [UIFont fontWithName:@"Helvetica" size:19.0];
		lblTitle2.textAlignment = UITextAlignmentLeft;
		lblTitle2.tag = 3;
        lblTitle2.numberOfLines = 1;
		[aCell.contentView addSubview:lblTitle2];
        
        CGRect tRect4 = CGRectMake(110, 77, 600, 35);
		lblTitle3 = [[UILabel alloc] initWithFrame:tRect4];
		[lblTitle3 setBackgroundColor:[UIColor clearColor]];
		[lblTitle3 setTextColor:[UIColor blackColor]];
		lblTitle3.font = [UIFont fontWithName:@"Helvetica" size:19.0];
		lblTitle3.textAlignment = UITextAlignmentLeft;
		lblTitle3.tag = 4;
        lblTitle3.numberOfLines = 1;
		[aCell.contentView addSubview:lblTitle3];
        
	}
    
	if (aTitle1 == nil) aTitle1 = @"";
    if (aTitle2 == nil) aTitle2 = @"";
    if (aTitle3 == nil) aTitle3 = @"";
    if([recordType isEqualToString:@"DCXWBL"])
    {
        //调查询问笔录
        [typeImageView setImage:[UIImage imageNamed:@"type_icon_dcxwbl.png"]];
    }
    else if([recordType isEqualToString:@"XCKCBL"])
    {
        //现场勘查笔录
        [typeImageView setImage:[UIImage imageNamed:@"type_icon_xckcbl.png"]];
    }
    else if([recordType isEqualToString:@"WRYXCJCJLB"])
    {
        //污染源现场监察记录表
        [typeImageView setImage:[UIImage imageNamed:@"type_icon_wryxcjcjlb.png"]];
    }
    else if ([recordType isEqualToString:@"FJXX"])
    {
        //现场取证
        [typeImageView setImage:[UIImage imageNamed:@"icon_xcqz.png"]];
    }
    else if ([recordType isEqualToString:@"XCHJJCZGYJS"])
    {
        //现场环境监察整改意见书
        [typeImageView setImage:[UIImage imageNamed:@"icon_xzcf.png"]];
    }
	if (lblTitle1 != nil) [lblTitle1 setText:[NSString stringWithFormat:@"%@",aTitle1]];
    if (lblTitle2 != nil) [lblTitle2 setText:[NSString stringWithFormat:@"%@",aTitle2]];
    if (lblTitle3 != nil) [lblTitle3 setText:[NSString stringWithFormat:@"%@",aTitle3]];
	
    aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return aCell;
}

@end
