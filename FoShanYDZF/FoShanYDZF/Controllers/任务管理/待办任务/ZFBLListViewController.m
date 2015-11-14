//
//  ZFBLListViewController.m
//  BoandaProject
//
//  Created by 曾静 on 13-10-31.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "ZFBLListViewController.h"
#import "ServiceUrlString.h"
#import "PDJsonkit.h"
#import "SiteInforcementConroller.h"
#import "InvestigateEvidenceVC.h"
#import "CaiyangViewController.h"
#import "QueryWriteController.h"
#import "FieldMonitorViewController.h"
#import "InspectOpinionViewController.h"

@interface ZFBLListViewController ()
@property (nonatomic, strong) NSArray *listDataArray;
@end

@implementation ZFBLListViewController

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
    
    [self.listTableView setBackgroundView:nil];
    [self.listTableView setBackgroundView:[[UIView alloc]init]];
    self.listTableView.backgroundView.backgroundColor = [UIColor clearColor];
    self.listTableView.backgroundColor = [UIColor clearColor];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"WORKFLOW_RECORD_LIST" forKey:@"service"];
    [params setObject:self.XCZFBH forKey:@"XCZFBH"];
    [params setObject:self.RECORDNAME forKey:@"RECORD_NAME"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在请求数据..." tagID:1];
}

#pragma mark - Network Handler Methods

- (void)processWebData:(NSData *)webData andTag:(NSInteger)tag
{
    if(webData.length <= 0)
    {
        return;
    }
    NSString *jsonStr = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSDictionary *detailDict = [jsonStr objectFromJSONString];
    BOOL bParsedError = NO;
    if(detailDict != nil)
    {
        self.listDataArray = [detailDict objectForKey:@"data"];
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

- (void)processError:(NSError *)error andTag:(NSInteger)tag
{
    [self showAlertMessage:@"获取数据出错!"];
}


- (void)viewDidUnload {
    [self setListTableView:nil];
    [super viewDidUnload];
}

#pragma mark - UITableView DataSource & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listDataArray.count;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSDictionary *dict = [self.listDataArray objectAtIndex:indexPath.section];
    cell.textLabel.text = [dict objectForKey:@"TITLE"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", [dict objectForKey:@"REMARK"], [dict objectForKey:@"TIME"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [self.listDataArray objectAtIndex:indexPath.section];
    NSString *name = self.RECORDNAME;
    if([name isEqualToString:@"XCKCBL"])
    {
        SiteInforcementConroller *controller = [[SiteInforcementConroller alloc] initWithNibName:@"SiteInforcementConroller" bundle:Nil];
        controller.basebh = [item objectForKey:@"BH"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([name isEqualToString:@"FJXX"])
    {
        InvestigateEvidenceVC *controller = [[InvestigateEvidenceVC alloc] initWithNibName:@"InvestigateEvidenceVC" bundle:Nil];
        controller.basebh = [item objectForKey:@"BH"];
        controller.xczfbh = self.XCZFBH;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([name isEqualToString:@"DCXWBL"])
    {
        QueryWriteController *controller = [[QueryWriteController alloc] initWithNibName:@"QueryWriteController" bundle:Nil];
        controller.basebh = [item objectForKey:@"BH"];
        NSLog(@"调查询问笔录编号：%@", controller.basebh);
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([name isEqualToString:@"WRYXCJCJLB"])
    {
        FieldMonitorViewController *controller = [[FieldMonitorViewController alloc] init];
        controller.basebh = [item objectForKey:@"BH"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([name isEqualToString:@"XCHJJCZGYJS"])
    {
        InspectOpinionViewController *controller = [[InspectOpinionViewController alloc] initWithNibName:@"InspectOpinionViewController" bundle:nil];
        controller.basebh = [item objectForKey:@"BH"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([name isEqualToString:@"XFDCJLD"])
    {
        
    }
}

@end
