//
//  WryCompanyArchiveViewController.m
//  BoandaProject
//
//  Created by 曾静 on 13-10-22.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "WryCompanyArchiveViewController.h"
#import "ServiceUrlString.h"
#import "UITableViewCell+Custom.h"
#import "PDJsonkit.h"
#import "DisplayAttachFileController.h"

#define kServive_MainArchives_Action 1 //获取主列表数据
#define kService_SubArchives_Action 2 //获取子列表数据

@interface WryCompanyArchiveViewController ()
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) NSArray *listDataArray;
@property (nonatomic, strong) NSMutableDictionary *dicSubTasks;
@property (nonatomic, strong) NSMutableArray *arySectionIsOpen;
@property (nonatomic, assign) int currentSelectedIndex;
@end

@implementation WryCompanyArchiveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    NSDictionary *dicInfo = [self.listDataArray objectAtIndex:section];
    NSString *title = [dicInfo objectForKey:@"TITLE"];
    NSArray *ary = [self.dicSubTasks objectForKey:title];
	return [ary count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        NSDictionary *rowInfo = [ary objectAtIndex:indexPath.row];
        cell.textLabel.text = [rowInfo objectForKey:@"DESCRIPTION"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[rowInfo objectForKey:@"TITLE"]];
        NSString *img = [rowInfo objectForKey:@"IMG"];
        NSString *desc = [rowInfo objectForKey:@"DESCRIPTION"];
        if(img.length == 0 || [desc isEqualToString:@"附件不存在"])
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dicInfo = [self.listDataArray objectAtIndex:indexPath.section];
    NSString *title = [dicInfo objectForKey:@"TITLE"];
    NSArray *ary = [self.dicSubTasks objectForKey:title];
    NSDictionary *rowInfo = [ary objectAtIndex:indexPath.row];
    NSString *img = [rowInfo objectForKey:@"IMG"];
    NSString *desc = [rowInfo objectForKey:@"DESCRIPTION"];
    if(img.length == 0 || [desc isEqualToString:@"附件不存在"])
    {
        return;
    }
    else
    {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"DOWN_OA_FILES" forKey:@"service"];
        [params setObject:@"WRY_ARCHIVES" forKey:@"GLLX"];
        [params setObject:img forKey:@"PATH"];//
        NSString *strURL = [ServiceUrlString generateUrlByParameters:params];
        NSString *fileName = [NSString stringWithFormat:@"%@.%@",[rowInfo objectForKey:@"DESCRIPTION"],[img pathExtension]];
        NSString *fileUrl = strURL;
        DisplayAttachFileController *detail = [[DisplayAttachFileController alloc] initWithNibName:@"DisplayAttachFileController" fileURL:fileUrl andFileName:fileName];
        [self.navigationController pushViewController:detail animated:YES];
    }
   
}

#pragma mark - QQ section header view delegate

-(void)sectionHeaderView:(QQSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section
{
    NSNumber *opened = [self.arySectionIsOpen objectAtIndex:section];
    [self.arySectionIsOpen replaceObjectAtIndex:section withObject:[NSNumber numberWithBool:!opened.boolValue]];
    NSInteger countOfRowsToDelete = [self.listTableView numberOfRowsInSection:section];
    if (countOfRowsToDelete > 0)
    {
        [self.listTableView reloadData];
    }
}

-(void)sectionHeaderView:(QQSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section
{
    NSDictionary *dicInfo = [self.listDataArray objectAtIndex:section];
    self.currentSelectedIndex = section;
    
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

#pragma mark - Network Handler Methods

/**
 * 获取污染源企业的档案的目录(需要手动设置下面3个参数)
 * 参数1:service(这里固定为DETAIL_CATEGORY_CONFIG)
 * 参数2:LINK(执行的路径,对应从前面带过来的LINK)
 * 参数3:PRIMARY_KEY(污染源编号,从前面带过来的)
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
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:self.urlString andParentView:self.view delegate:self tagID:kServive_MainArchives_Action];
}

/**
 * 获取污染源企业的档案的目录下面的资源列表
 * 参数1:service(这里固定为DETAIL_CATEGORY_CONFIG)
 * 参数2:TYPE_CODE(执行的路径,对应从前面带过来的LINK)
 * 参数3:PRIMARY_KEY(污染源编号,从前面带过来的)
 */
- (void)requestSubData:(NSString *)link
{
    self.isLoading = YES;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"WRY_ARCHIVES_LIST" forKey:@"service"];
    [params setObject:self.primaryKey forKey:@"PRIMARY_KEY"];
    [params setObject:link forKey:@"TYPE_CODE"];
    NSString *UrlStr = [ServiceUrlString generateUrlByParameters:params];
    self.urlString = UrlStr;
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:self.urlString andParentView:self.view delegate:self tagID:kService_SubArchives_Action];
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
    if(tag == kServive_MainArchives_Action)
    {
        BOOL bParsedError = NO;
        if(detailDict != nil)
        {
            self.title = [detailDict objectForKey:@"GLOBAL_TITLE"];
            NSMutableArray *destAry = [[NSMutableArray alloc] initWithCapacity:7];
            NSArray *ary001 = [detailDict objectForKey:@"data"];
            for (NSDictionary *tmp in ary001)
            {
                if([destAry containsObject:tmp])
                {
                    continue;
                }
                else
                {
                    [destAry addObject:tmp];
                }
            }
            self.listDataArray = destAry;
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
    else if(tag == kService_SubArchives_Action)
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

@end
