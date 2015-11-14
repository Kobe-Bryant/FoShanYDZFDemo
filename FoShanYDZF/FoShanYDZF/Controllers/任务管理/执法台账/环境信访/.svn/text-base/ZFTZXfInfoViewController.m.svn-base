//
//  ZFTZXfInfoViewController.m
//  FoShanYDZF
//
//  Created by 曾静 on 13-11-14.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "ZFTZXfInfoViewController.h"
#import "ServiceUrlString.h"
#import "PDJsonkit.h"
#import "UITableViewCell+Custom.h"

@interface ZFTZXfInfoViewController ()
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) NSDictionary *detailDict;
@end

@implementation ZFTZXfInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"环境信访基本信息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self requestData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setDetailTableView:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NetWork Handler Methods

- (void)requestData
{
    self.isLoading = YES;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"XF_DETAIL" forKey:@"service"];
    [params setObject:self.xfbh forKey:@"XFBH"];//信访编号
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self];
}

- (void)processWebData:(NSData *)webData
{
    self.isLoading = NO;
    if(webData.length <= 0)
    {
        return;
    }
    NSString *jsonStr = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSArray *tmpAry = [jsonStr objectFromJSONString];
    BOOL bParsedError = NO;
    if(tmpAry != nil && tmpAry.count > 0)
    {
        self.detailDict = [tmpAry objectAtIndex:0];
    }
    else
    {
        bParsedError = YES;
    }
    [self.detailTableView reloadData];
    if(bParsedError)
    {
        [self showAlertMessage:@"解析数据出错!"];
    }
}

- (void)processError:(NSError *)error
{
    self.isLoading = NO;
    [self showAlertMessage:@"获取数据失败!"];
}

#pragma mark - UITableView DataSource & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 5;
    }
    else if (section == 1)
    {
        return 5;
    }
    else if (section == 2)
    {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
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
    NSString *sectionLabel = @"";
    if(section == 0)
    {
        sectionLabel = @"登记信息";
    }
    else if (section == 1)
    {
        sectionLabel = @"被投诉单位信息";
    }
    else if (section == 2)
    {
        sectionLabel = @"其他信息";
    }
    headerView.text = [NSString stringWithFormat:@"  %@", sectionLabel];
    return headerView;
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
        if(indexPath.row == 0)
        {
            NSString *title = @"投诉人：";
            NSString *value = [self.detailDict objectForKey:@"TSR"];
            cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:60];
        }
        else if(indexPath.row == 1)
        {
            NSString *title = @"联系电话：";
            NSString *value = [self.detailDict objectForKey:@"TSRDH"];
            cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:60];
        }
        else if(indexPath.row == 2)
        {
            NSString *title = @"联系地址：";
            NSString *value = [self.detailDict objectForKey:@"TSRDZ"];
            cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:60];
        }
        else if(indexPath.row == 3)
        {
            NSString *title = @"投诉时间：";
            NSString *value = [self.detailDict objectForKey:@"TSSJ"];
            cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:60];
        }
        else if(indexPath.row == 4)
        {
            NSString *title = @"投诉内容：";
            NSString *value = [self.detailDict objectForKey:@"TSNR"];
            cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:60];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            NSString *title = @"单位名称：";
            NSString *value = [self.detailDict objectForKey:@"BTSDWMC"];
            cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:60];
        }
        if(indexPath.row == 1)
        {
            NSString *title = @"单位地址：";
            NSString *value = [self.detailDict objectForKey:@"BTSDWDZ"];
            cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:60];
        }
        if(indexPath.row == 2)
        {
            NSString *title = @"法人代表：";
            NSString *value = [self.detailDict objectForKey:@"BTSDWFRDB"];
            cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:60];
        }
        if(indexPath.row == 3)
        {
            NSString *title = @"负责人：";
            NSString *value = [self.detailDict objectForKey:@"BTSDWFZR"];
            cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:60];
        }
        if(indexPath.row == 4)
        {
            NSString *title = @"负责人电话：";
            NSString *value = [self.detailDict objectForKey:@"BTSDWDH"];
            cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:60];
        }
    }
    else if(indexPath.section == 2)
    {
        NSString *title = @"";
        NSString *value = @"";
        cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:60];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
