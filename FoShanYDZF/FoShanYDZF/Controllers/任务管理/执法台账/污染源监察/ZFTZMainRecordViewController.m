//
//  ZFTZMainRecordViewController.m
//  BoandaProject
//
//  Created by 曾静 on 13-10-28.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "ZFTZMainRecordViewController.h"
#import "ServiceUrlString.h"
#import "PDJsonkit.h"
#import "UITableViewCell+Custom.h"
#import "ZFTZChildRecordViewController.h"

@interface ZFTZMainRecordViewController ()
@property (nonatomic, strong) NSDictionary *detailDataDict;
@property (nonatomic, strong) NSArray *toDisplayKeyAry;
@property (nonatomic, strong) NSArray *toDisplayTitleAry;
@property (nonatomic, strong) NSArray *toDisplayRecordTitleAry;//执法笔录名称
@property (nonatomic, strong) NSArray *toDisplayRecordKeyAry;//执法笔录对应的KEY
@property (nonatomic, strong) NSArray *toDisplayRecordTypeAry;//执法笔录对应的Type
@end

@implementation ZFTZMainRecordViewController
@synthesize detailDataDict;
@synthesize toDisplayKeyAry, toDisplayTitleAry;
@synthesize toDisplayRecordTitleAry, toDisplayRecordKeyAry;

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

    //初始化默认数据
    [self initDefaultData];
    
    //请求数据
    [self requestData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setListTableView:nil];
    [super viewDidUnload];
}

#pragma mark - Network Handler Methods

/**
 * 获取执法台账执法记录列表
 * 参数1:service(这里固定为RSS_DATA_LIST, 必选)
 * 参数2:MENU_SERIES(菜单编号, 必选)
 */
- (void)requestData
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"XCZF_BASE_RECORD_COUNT" forKey:@"service"];
    [params setObject:self.xczfbh forKey:@"XCZFBH"];
    NSString *UrlStr = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:UrlStr andParentView:self.view delegate:self];
}

- (void)processWebData:(NSData *)webData
{
    if(webData.length <= 0)
    {
        return;
    }
    NSString *jsonStr = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSArray *parsedJsonAry = [jsonStr objectFromJSONString];
    if(parsedJsonAry != nil && parsedJsonAry.count > 0)
    {
        NSDictionary *detailDict = [parsedJsonAry objectAtIndex:0];
        BOOL bParsedError = NO;
        if(detailDict != nil)
        {
            self.title = [detailDict objectForKey:@"WRYMC"];
            self.detailDataDict = detailDict;
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
    
}

- (void)processError:(NSError *)error
{
    [self showAlertMessage:@"获取数据出错!"];
}

#pragma mark - UITableView DataSource & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 7;
    }
    else if (section == 1)
    {
        return self.toDisplayRecordTitleAry.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectZero];
    headerView.font = [UIFont systemFontOfSize:19.0];
    headerView.backgroundColor = [UIColor colorWithRed:170.0/255 green:223.0/255 blue:234.0/255 alpha:1.0];
    headerView.textColor = [UIColor blackColor];
    if(section == 0)
    {
        headerView.text = [NSString stringWithFormat:@"  %@", @"基本信息"];
    }
    else if (section == 1)
    {
        headerView.text = [NSString stringWithFormat:@"  %@", @"执法笔录"];
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if(indexPath.section == 0)
    {
        if(indexPath.row <= 1)
        {
            NSString *title = [self.toDisplayTitleAry objectAtIndex:indexPath.row];
            NSString *key = [self.toDisplayKeyAry objectAtIndex:indexPath.row];
            NSString *value = [self.detailDataDict objectForKey:key];
            cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:60.0f];
        }
        else if(indexPath.row > 1 && indexPath.row < 4)
        {
            NSString *title1 = [self.toDisplayTitleAry objectAtIndex:indexPath.row*2-2];
            NSString *key1 = [self.toDisplayKeyAry objectAtIndex:indexPath.row*2-2];
            NSString *value1 = [self.detailDataDict objectForKey:key1];
            
            NSString *title2 = [self.toDisplayTitleAry objectAtIndex:indexPath.row*2-1];
            NSString *key2 = [self.toDisplayKeyAry objectAtIndex:indexPath.row*2-1];
            NSString *value2 = [self.detailDataDict objectForKey:key2];
            cell = [UITableViewCell makeSubCell:tableView withValue1:title1 value2:title2 value3:value1 value4:value2 height:60];
        }
        else if(indexPath.row == 4)
        {
            NSString *title = [self.toDisplayTitleAry objectAtIndex:6];
            NSString *key = [self.toDisplayKeyAry objectAtIndex:6];
            NSString *value = [self.detailDataDict objectForKey:key];
            cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:60.0f];
        }
        else if (indexPath.row == 5)
        {
            NSString *title1 = [self.toDisplayTitleAry objectAtIndex:7];
            NSString *key1 = [self.toDisplayKeyAry objectAtIndex:7];
            NSString *value1 = [self.detailDataDict objectForKey:key1];
            
            NSString *title2 = [self.toDisplayTitleAry objectAtIndex:8];
            NSString *key2 = [self.toDisplayKeyAry objectAtIndex:8];
            NSString *value2 = [self.detailDataDict objectForKey:key2];
            cell = [UITableViewCell makeSubCell:tableView withValue1:title1 value2:title2 value3:value1 value4:value2 height:60];
        }
        else if (indexPath.row == 6)
        {
            NSString *title = [self.toDisplayTitleAry objectAtIndex:9];
            NSString *key = [self.toDisplayKeyAry objectAtIndex:9];
            NSString *value = [self.detailDataDict objectForKey:key];
            cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:60.0f];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if (indexPath.section == 1)
    {
        NSString *CellIdentifier = @"Cell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        NSString *key = [self.toDisplayRecordKeyAry objectAtIndex:indexPath.row];
        int count = [[self.detailDataDict objectForKey:key] integerValue];
        NSString *value = [NSString stringWithFormat:@"%@：%d条", [self.toDisplayRecordTitleAry objectAtIndex:indexPath.row], count];
        cell.textLabel.text = value;
        if(count > 0)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        NSString *key = [self.toDisplayRecordKeyAry objectAtIndex:indexPath.row];
        NSString *type = [self.toDisplayRecordTypeAry objectAtIndex:indexPath.row];
        int count = [[self.detailDataDict objectForKey:key] integerValue];
        if(count > 0)
        {
            ZFTZChildRecordViewController *child = [[ZFTZChildRecordViewController alloc] initWithNibName:@"ZFTZChildRecordViewController" bundle:nil];
            child.xczfbh = self.xczfbh;
            child.taskType = type;
            [self.navigationController pushViewController:child animated:YES];
        }
    }
}

#pragma mark - Private Methods

//初始化默认数据
- (void)initDefaultData
{
    self.toDisplayKeyAry = [[NSArray alloc] initWithObjects:@"WRYMC",@"WRYDZ", @"FDDBR", @"FDDBRDH", @"HBFZR", @"HBFZRDH", @"JCR",@"KSSJ",@"JSSJ",@"ZFLXXLDMNR", nil];
    self.toDisplayTitleAry = [[NSArray alloc] initWithObjects:@"污染源名称：",@"污染源地址：", @"法人代表：", @"联系电话：", @"环保负责人：", @"联系电话：", @"检查人：",@"检查开始时间：",@"检查结束时间：",@"任务类型：", nil];
    self.toDisplayRecordTitleAry = [[NSArray alloc] initWithObjects:XCKCBL_NAME, FJXX_NAME, DCXWBL_NAME, WRYXCJCJLB_NAME, XCHJJCZGYJS_NAME, nil];
    self.toDisplayRecordKeyAry = [[NSArray alloc] initWithObjects:@"KCBLKCCOUNT", @"FJXX_COUNT", @"DCXWBLCOUNT", @"WRYXCJCJLBCOUNT", @"XCHJJCZGYJSCOUNT", nil];
    self.toDisplayRecordTypeAry = [[NSArray alloc] initWithObjects:@"XCKCBL", @"FJXX", @"DCXWBL", @"WRYXCJCJLB", @"XCHJJCZGYJS", nil];
}

@end
