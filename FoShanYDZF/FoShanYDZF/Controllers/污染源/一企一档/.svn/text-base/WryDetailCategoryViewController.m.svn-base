//
//  WryDetailCategoryViewController.m
//  BoandaProject
//
//  Created by 曾静 on 13-10-17.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "WryDetailCategoryViewController.h"
#import "PDJsonkit.h"
#import "ServiceUrlString.h"
#import "UITableViewCell+Custom.h"
#import "WryDetailCategoryViewController.h"
#import "WryCompanyInfoViewController.h"
#import "WryCompanyArchiveViewController.h"
#import "XMSPDetailsViewController.h"
#import "HJXFDetailViewController.h"
#import "XZCFDetailsViewController.h"
#import "PWSFDetailViewController.h"
#import "PWXKZDetailViewController.h"
#import "WryLocationModifyViewController.h"

@interface WryDetailCategoryViewController ()
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) NSArray *listDataArray;
@property (nonatomic, strong) NSMutableDictionary *dicSubTasks;
@property (nonatomic, strong) NSMutableArray *arySectionIsOpen;
@property (nonatomic, assign) int currentSelectedIndex;
@end

@implementation WryDetailCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"经纬度校准" style:UIBarButtonItemStyleBordered target:self action:@selector(onRightBarClick:)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    [self requestData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setListTableView:nil];
    [super viewDidUnload];
}

#pragma mark - UITableView DataSource & Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 59;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.listDataArray count];
}

- (UIView*) tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat headerHeight = 59;
    NSDictionary *tmpDic = [self.listDataArray objectAtIndex:section];
    NSString *title = [tmpDic objectForKey:@"TITLE"];
    BOOL opened = YES;
    if(section < [self.arySectionIsOpen count])
    {
        opened = [[self.arySectionIsOpen objectAtIndex:section] boolValue];
    }
	QQSectionHeaderView *sectionHeadView = [[QQSectionHeaderView alloc]
                                            initWithFrame:CGRectMake(0.0, 0.0, self.listTableView.bounds.size.width, headerHeight)
                                            title:title
                                            section:section
                                            opened:opened
                                            delegate:self];
	return sectionHeadView ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section < [self.arySectionIsOpen count])
    {
        BOOL opened = [[self.arySectionIsOpen objectAtIndex:section] boolValue];
        if(opened == NO) return 0;
    }
    
    NSDictionary *item = [self.listDataArray objectAtIndex:section];
    NSString *link = [item objectForKey:@"LINK"];
    if([link isEqualToString:@"wry/wryItemJbxx.jsp"])
    {
        //企业概况
        return 1;
    }
    else if([link isEqualToString:@"wry/archives/archiveDetailCategory.jsp"])
    {
        //企业档案
       return 1;
    }
    else if([link isEqualToString:@"wry/pwsb/pwsbDetailCategory.jsp"])
    {
        //排污申报收费
        return 0;
    }
    NSDictionary *dicInfo = [self.listDataArray objectAtIndex:section];
    NSString *title = [dicInfo objectForKey:@"TITLE"];
    NSArray *ary = [self.dicSubTasks objectForKey:title];
	return [ary count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [self.listDataArray objectAtIndex:indexPath.section];
    NSString *link = [item objectForKey:@"LINK"];
    if([link isEqualToString:@"wry/wryItemJbxx.jsp"] || [link isEqualToString:@"wry/archives/archiveDetailCategory.jsp"] || [link isEqualToString:@"wry/pwsb/pwsbDetailCategory.jsp"])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Normal_Cell"];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Normal_Cell"];
        }
        if([link isEqualToString:@"wry/wryItemJbxx.jsp"])
        {
            //企业概况
            cell.textLabel.text = @"查看污染源企业概况";
        }
        else if([link isEqualToString:@"wry/archives/archiveDetailCategory.jsp"])
        {
            //企业档案
            cell.textLabel.text = @"查看污染源企业档案";
        }
        else if([link isEqualToString:@"wry/pwsb/pwsbDetailCategory.jsp"])
        {
            //排污申报收费
            cell.textLabel.text = @"查看排污申报收费信息";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dicInfo = [self.listDataArray objectAtIndex:indexPath.section];
    NSString *title = [dicInfo objectForKey:@"TITLE"];
    NSArray *ary = [self.dicSubTasks objectForKey:title];
    if(indexPath.row < [ary count])
    {
        if([link isEqualToString:@"xmsp/wryXmspDataList.jsp"])
        {
            //项目审批
            NSDictionary *rowInfo = [ary objectAtIndex:indexPath.row];
            cell.textLabel.text = [rowInfo objectForKey:@"TITLE"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"项目编号：%@    %@",[rowInfo objectForKey:@"XMBH"],[rowInfo objectForKey:@"CONTENT"]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if([link isEqualToString:@"hjxf/hjxfDataList.jsp"])
        {
            //环境信访
            NSDictionary *rowInfo = [ary objectAtIndex:indexPath.row];
            cell.textLabel.text = [rowInfo objectForKey:@"TITLE"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@    %@",[rowInfo objectForKey:@"REMARK"],[rowInfo objectForKey:@"TIME"]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if ([link isEqualToString:@"wry/penalty/penaltyDataList.jsp"])
        {
            //行政处罚
            NSDictionary *rowInfo = [ary objectAtIndex:indexPath.row];
            cell.textLabel.text = [rowInfo objectForKey:@"TITLE"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@    %@",[rowInfo objectForKey:@"CONTENT"],[rowInfo objectForKey:@"REMARK"]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if([link isEqualToString:@"wry/pwxkz/pwxkzDataList.jsp"])
        {
            //排污许可证
            NSDictionary *rowInfo = [ary objectAtIndex:indexPath.row];
            cell.textLabel.text = [rowInfo objectForKey:@"TITLE"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[rowInfo objectForKey:@"CONTENT"]];
        }
        else
        {
            NSDictionary *rowInfo = [ary objectAtIndex:indexPath.row];
            cell.textLabel.text = [rowInfo objectForKey:@"TITLE"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[rowInfo objectForKey:@"CONTENT"]];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [self.listDataArray objectAtIndex:indexPath.section];
    NSString *link = [item objectForKey:@"LINK"];
    if([link isEqualToString:@"xmsp/wryXmspDataList.jsp"])
    {
        //项目审批
        NSString *title = [item objectForKey:@"TITLE"];
        NSArray *ary = [self.dicSubTasks objectForKey:title];
        NSDictionary *rowInfo = [ary objectAtIndex:indexPath.row];
        XMSPDetailsViewController *detailsController = [[XMSPDetailsViewController alloc] init];
        detailsController.primaryKey = [rowInfo objectForKey:@"PRIMARY_KEY"];
        [self.navigationController pushViewController:detailsController animated:YES];
    }
    else if([link hasPrefix:@"hjxf/hjxfDataList.jsp"])
    {
        //信访投诉
        NSString *title = [item objectForKey:@"TITLE"];
        NSArray *ary = [self.dicSubTasks objectForKey:title];
        NSDictionary *rowInfo = [ary objectAtIndex:indexPath.row];
        HJXFDetailViewController *detail = [[HJXFDetailViewController alloc] init];
        detail.primaryKey = [rowInfo objectForKey:@"PRIMARY_KEY"];
        detail.link = [rowInfo objectForKey:@"LINK"];
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if([link isEqualToString:@"wry/wryItemJbxx.jsp"])
    {
        //企业概况
        WryCompanyInfoViewController *info = [[WryCompanyInfoViewController alloc] initWithNibName:@"WryCompanyInfoViewController" bundle:nil];
        info.link = link;
        info.wrymc = self.wrymc;
        info.primaryKey = self.primaryKey;
        [self.navigationController pushViewController:info animated:YES];
    }
    else if([link isEqualToString:@"wry/archives/archiveDetailCategory.jsp"])
    {
        //企业档案
        WryCompanyArchiveViewController *info = [[WryCompanyArchiveViewController alloc] initWithNibName:@"WryCompanyArchiveViewController" bundle:nil];
        info.link = link;
        info.wrymc = self.wrymc;
        info.primaryKey = self.primaryKey;
        [self.navigationController pushViewController:info animated:YES];
    }
    else if ([link isEqualToString:@"wry/penalty/penaltyDataList.jsp"])
    {
        //行政处罚
        NSString *title = [item objectForKey:@"TITLE"];
        NSArray *ary = [self.dicSubTasks objectForKey:title];
        NSDictionary *rowInfo = [ary objectAtIndex:indexPath.row];
        XZCFDetailsViewController *detail = [[XZCFDetailsViewController alloc] init];
        detail.primaryKey = [rowInfo objectForKey:@"PRIMARY_KEY"];
        detail.link = [rowInfo objectForKey:@"LINK"];
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if([link isEqualToString:@"wry/pwsb/pwsbDetailCategory.jsp"])
    {
        //排污申报收费
        PWSFDetailViewController *detail = [[PWSFDetailViewController alloc] init];
        detail.link = link;
        detail.wrymc = self.wrymc;
        detail.primaryKey = self.primaryKey;
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if([link isEqualToString:@"wry/pwxkz/pwxkzDataList.jsp"])
    {
        //排污许可证
        NSString *title = [item objectForKey:@"TITLE"];
        NSArray *ary = [self.dicSubTasks objectForKey:title];
        NSDictionary *rowInfo = [ary objectAtIndex:indexPath.row];
        PWXKZDetailViewController *detail = [[PWXKZDetailViewController alloc] init];
        detail.link = link;
        detail.primaryKey = [rowInfo objectForKey:@"PRIMARY_KEY"];;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark - QQ section header view delegate

-(void)sectionHeaderView:(QQSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section
{
    NSDictionary *dicInfo = [self.listDataArray objectAtIndex:section];
    NSString * count = [dicInfo objectForKey:@"COUNT"];
    if([count integerValue] > 0 && count != nil)
    {
        NSNumber *opened = [self.arySectionIsOpen objectAtIndex:section];
        [self.arySectionIsOpen replaceObjectAtIndex:section withObject:[NSNumber numberWithBool:!opened.boolValue]];
        NSInteger countOfRowsToDelete = [self.listTableView numberOfRowsInSection:section];
        if (countOfRowsToDelete > 0)
        {
            [self.listTableView reloadData];
        }
    }
    else
    {
        NSDictionary *item = [self.listDataArray objectAtIndex:section];
        NSString *link = [item objectForKey:@"LINK"];
        if([link isEqualToString:@"wry/wryItemJbxx.jsp"] || [link isEqualToString:@"wry/archives/archiveDetailCategory.jsp"] || [link isEqualToString:@"wry/pwsb/pwsbDetailCategory.jsp"])
        {
            NSNumber *opened = [self.arySectionIsOpen objectAtIndex:section];
            [self.arySectionIsOpen replaceObjectAtIndex:section withObject:[NSNumber numberWithBool:!opened.boolValue]];
            [self.listTableView reloadData];
        }
    }
}

-(void)sectionHeaderView:(QQSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section
{
    NSDictionary *dicInfo = [self.listDataArray objectAtIndex:section];
    NSString * count = [dicInfo objectForKey:@"COUNT"];
    self.currentSelectedIndex = section;
    if([count integerValue] > 0 && count != nil)
    {
        NSNumber *opened = [self.arySectionIsOpen objectAtIndex:section];
        [self.arySectionIsOpen replaceObjectAtIndex:section withObject:[NSNumber numberWithBool:!opened.boolValue]];
        NSString *link = [dicInfo objectForKey:@"LINK"];
        if(self.dicSubTasks == nil)
        {
            //没有请求过对应的数据
            [self requestSubData:link];
        }
        else
        {
            //之前请求过数据
            NSArray *ary = [self.dicSubTasks objectForKey:[dicInfo objectForKey:@"TITLE"]];
            if(ary == nil)
            {
                [self requestSubData:link];
            }
            else
            {
                [self.listTableView reloadData];
            }
        }
    }
    else
    {
        NSDictionary *item = [self.listDataArray objectAtIndex:section];
        NSString *link = [item objectForKey:@"LINK"];
        if([link isEqualToString:@"wry/wryItemJbxx.jsp"] || [link isEqualToString:@"wry/archives/archiveDetailCategory.jsp"] || [link isEqualToString:@"wry/pwsb/pwsbDetailCategory.jsp"])
        {
            NSNumber *opened = [self.arySectionIsOpen objectAtIndex:section];
            [self.arySectionIsOpen replaceObjectAtIndex:section withObject:[NSNumber numberWithBool:!opened.boolValue]];
            [self.listTableView reloadData];
        }
    }
}

#pragma mark - Network Handler Methods

/**
 * 获取污染源企业信息目录列表
 * 参数1:service(这里固定为DETAIL_CATEGORY_CONFIG, 必选)
 * 参数2:LINK(对应前面污染源企业列表中的LINK字段, 必选)
 * 参数3:PRIMARY_KEY(污染源编号，对应前面污染源企业列表中的PRIMARY_KEY字段, 必选)
 */
- (void)requestData
{
    self.isLoading = YES;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"DETAIL_CATEGORY_CONFIG" forKey:@"service"];
    [params setObject:self.link forKey:@"LINK"];
    [params setObject:self.primaryKey forKey:@"PRIMARY_KEY"];
    NSString *UrlStr = [ServiceUrlString generateUrlByParameters:params];
    self.urlString = UrlStr;
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:self.urlString andParentView:self.view delegate:self tagID:1];
}

/**
 * 获取污染源企业信息子目录
 * 参数1:service(这里固定为DETAIL_CATEGORY_CONFIG, 必选)
 * 参数2:LINK(对应前面的LINK字段, 必选)
 * 参数3:PRIMARY_KEY(污染源编号，对应前面的PRIMARY_KEY字段, 必选)
 */
- (void)requestSubData:(NSString *)link
{
    self.isLoading = YES;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"DETAIL_CATEGORY_CONFIG" forKey:@"service"];
    [params setObject:link forKey:@"LINK"];
    [params setObject:self.primaryKey forKey:@"PRIMARY_KEY"];
    NSString *UrlStr = [ServiceUrlString generateUrlByParameters:params];
    self.urlString = UrlStr;
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:self.urlString andParentView:self.view delegate:self tagID:2];
}

- (void)processWebData:(NSData *)webData andTag:(NSInteger)tag
{
    self.isLoading = NO;
    if(webData.length <= 0)
    {
        return;
    }
    NSString *jsonStr = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSDictionary *detailDict = [jsonStr objectFromJSONString];
    if(tag == 1)
    {
        BOOL bParsedError = NO;
        if(detailDict != nil)
        {
            self.title = [detailDict objectForKey:@"GLOBAL_TITLE"];
            self.listDataArray = [detailDict objectForKey:@"data"];
            self.arySectionIsOpen = [NSMutableArray arrayWithCapacity:5];
            for (NSInteger i = 0; i < [self.listDataArray count]; i++)
            {
                [self.arySectionIsOpen addObject:[NSNumber numberWithBool:NO]];
            }
        }
        else
        {
            bParsedError = YES;
        }
        [self.listTableView reloadData];
        if(bParsedError)
        {
            [self showAlertMessage:@"解析数据出错!"];
        }
    }
    else
    {
        if(self.dicSubTasks == nil)
        {
            self.dicSubTasks = [NSMutableDictionary dictionaryWithCapacity:3];
        }
        NSArray *ary = [detailDict objectForKey:@"data"];
        if(ary == nil)
        {
            ary = [NSArray array];
        }
        NSString *title = [[self.listDataArray objectAtIndex:self.currentSelectedIndex] objectForKey:@"TITLE"];
        [self.dicSubTasks setObject:ary forKey:title];
        [self.listTableView reloadData];
    }
}

- (void)processError:(NSError *)error
{
    self.isLoading = NO;
    [self showAlertMessage:@"获取数据出错!"];
}

- (void)onRightBarClick:(id)sender
{
    WryLocationModifyViewController *locationModify = [[WryLocationModifyViewController alloc] init];
    locationModify.wrymc = self.wrymc;
    locationModify.wrybh = self.primaryKey;
    [self.navigationController pushViewController:locationModify animated:YES];
}

@end
