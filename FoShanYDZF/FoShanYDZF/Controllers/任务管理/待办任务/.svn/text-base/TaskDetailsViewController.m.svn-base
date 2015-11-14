//
//  TaskDetailsViewController.m
//  BoandaProject
//
//  Created by 张仁松 on 13-10-16.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
// WORKFLOW_DETAIL_MAIN   WORKFLOW_RECORD_LIST
// 参数: PRIMARY_KEY->YWBH; LCSLBH->LCSLBH ;LCLXBH->LCLXBH; WRYBH; TASK_STATE->PROCESSED\TO_DO
// WORKFLOW_RECORD_LIST参数: XCZFBH

#import "TaskDetailsViewController.h"
#import "ServiceUrlString.h"
#import "PDJsonkit.h"
#import "UITableViewCell+Custom.h"
#import "TaskActionsHandler.h"
#import "NSStringUtil.h"

#import "SiteInforcementConroller.h"
#import "QueryWriteController.h"
#import "InvestigateEvidenceVC.h"
#import "CaiyangViewController.h"
#import "ZFBLListViewController.h"
#import "FieldMonitorViewController.h"
#import "InspectOpinionViewController.h"

@interface TaskDetailsViewController ()
@property (nonatomic, strong) NSArray *jbxxAry;//基本信息
@property (nonatomic, strong) NSArray *zfblAry;//执法笔录
@property (nonatomic, strong) NSArray *blgcAry;//办理过程
@property (nonatomic, strong) NSArray *btsdwAry;//被投诉单位
@property (nonatomic, strong) NSArray *ladjxxAry;//立案登记信息
@property (nonatomic, strong) NSArray *sectionAry;//分组数据
@property (nonatomic, strong) NSArray *djxxAry;//登记信息
@property (nonatomic, strong) TaskActionsHandler *actionsModel;
@property (nonatomic, assign) BOOL bOKFromTransfer;
@end

@implementation TaskDetailsViewController
@synthesize actionsModel,bOKFromTransfer,itemParams;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"待办任务详细";
    }
    return self;
}

- (void)requestDetailData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"WORKFLOW_DETAIL_MAIN" forKey:@"service"];
    [params setObject:self.YWBH forKey:@"PRIMARY_KEY"];
    [params setObject:self.LCSLBH forKey:@"LCSLBH"];
    [params setObject:self.LCLXBH forKey:@"LCLXBH"];
    [params setObject:self.WRYBH forKey:@"WRYBH"];
    [params setObject:@"TO_DO" forKey:@"TASK_STATE"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在请求数据..." tagID:1] ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bOKFromTransfer = NO;
     
    self.actionsModel = [[TaskActionsHandler alloc] initWithTarget:self andParentView:self.view];
    [actionsModel handleActionInfo:itemParams];
    
    [self requestDetailData];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    if(self.bOKFromTransfer)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionLabel = [self.sectionAry objectAtIndex:section];
    if([sectionLabel isEqualToString:@"登记信息"])
    {
        return self.djxxAry.count;
    }
    else if([sectionLabel isEqualToString:@"基本信息"])
    {
        return self.jbxxAry.count;
    }
    else if([sectionLabel isEqualToString:@"立案登记信息"])
    {
        return self.ladjxxAry.count;
    }
    else if([sectionLabel isEqualToString:@"被投诉单位"])
    {
        return self.btsdwAry.count;
    }
    else if([sectionLabel isEqualToString:@"办理过程"])
    {
        return self.blgcAry.count;
    }
    else if([sectionLabel isEqualToString:@"执法笔录"])
    {
        return self.zfblAry.count;
    }
    else
    {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionLabel = [self.sectionAry objectAtIndex:indexPath.section];
    if([sectionLabel isEqualToString:@"登记信息"])
    {
        NSDictionary *item = [self.djxxAry objectAtIndex:indexPath.row];
        NSString *value = [item objectForKey:@"CONTENT"];
        return [self getCellHeight:value];
    }
    else if([sectionLabel isEqualToString:@"基本信息"])
    {
        NSDictionary *item = [self.jbxxAry objectAtIndex:indexPath.row];
        NSString *value = [item objectForKey:@"CONTENT"];
        return [self getCellHeight:value];
    }
    else if([sectionLabel isEqualToString:@"立案登记信息"])
    {
        NSDictionary *item = [self.ladjxxAry objectAtIndex:indexPath.row];
        NSString *value = [item objectForKey:@"CONTENT"];
        return [self getCellHeight:value];
    }
    else if([sectionLabel isEqualToString:@"被投诉单位"])
    {
        NSDictionary *item = [self.btsdwAry objectAtIndex:indexPath.row];
        NSString *value = [item objectForKey:@"CONTENT"];
        return [self getCellHeight:value];
    }
    else if([sectionLabel isEqualToString:@"办理过程"])
    {
        return 100;
    }
    else if([sectionLabel isEqualToString:@"执法笔录"])
    {
        return 60.0f;
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
    NSString *sectionLabel = [self.sectionAry objectAtIndex:section];
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
    NSString *sectionLabel = [self.sectionAry objectAtIndex:indexPath.section];
    if([sectionLabel isEqualToString:@"登记信息"])
    {
        NSDictionary *item = [self.djxxAry objectAtIndex:indexPath.row];
        NSString *title = [item objectForKey:@"TITLE"];
        NSString *value = [item objectForKey:@"CONTENT"];
        CGFloat height = [self getCellHeight:value];
        cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:height];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if([sectionLabel isEqualToString:@"基本信息"])
    {
        NSDictionary *item = [self.jbxxAry objectAtIndex:indexPath.row];
        NSString *title = [item objectForKey:@"TITLE"];
        NSString *value = [item objectForKey:@"CONTENT"];
        CGFloat height = [self getCellHeight:value];
        cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:height];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if([sectionLabel isEqualToString:@"立案登记信息"])
    {
        NSDictionary *item = [self.ladjxxAry objectAtIndex:indexPath.row];
        NSString *title = [item objectForKey:@"TITLE"];
        NSString *value = [item objectForKey:@"CONTENT"];
        CGFloat height = [self getCellHeight:value];
        cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:height];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if([sectionLabel isEqualToString:@"被投诉单位"])
    {
        NSDictionary *item = [self.btsdwAry objectAtIndex:indexPath.row];
        NSString *title = [item objectForKey:@"TITLE"];
        NSString *value = [item objectForKey:@"CONTENT"];
        CGFloat height = [self getCellHeight:value];
        cell = [UITableViewCell makeSubCell:tableView withTitle:title value:value andHeight:height];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if([sectionLabel isEqualToString:@"办理过程"])
    {
        NSDictionary *item = [self.blgcAry objectAtIndex:indexPath.row];
        NSString *content = [NSString stringWithFormat:@"%@\n%@ %@",[item objectForKey:@"TITLE"], [item objectForKey:@"CONTENT"], [item objectForKey:@"TAG_02"]];
        NSString *remark = [item objectForKey:@"REMARK"];
        NSString *CellIdentifier = @"Step_Cell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
        cell.textLabel.text = content;
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:17.0f];
        cell.detailTextLabel.text = remark;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if([sectionLabel isEqualToString:@"执法笔录"])
    {
        NSDictionary *item = [self.zfblAry objectAtIndex:indexPath.row];
        NSString *name = [item objectForKey:@"RECORD_NAME"];
        NSString *count = [item objectForKey:@"RECORD_COUNT"];
        NSString *value = [NSString stringWithFormat:@"%@ : %@条", name, count];
        BOOL canAdd = [[item objectForKey:@"ADD_ENABLE"] boolValue];
        NSString *CellIdentifier = @"Normal_Cell";
        if(canAdd)
        {
            CellIdentifier = @"Edit_Cell";
        }
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = value;
        if([count intValue] > 0)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if(canAdd)
        {
            UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
            addButton.tag = indexPath.row;
            addButton.frame = CGRectMake(650, 15, 30, 30);
            [cell.contentView addSubview:addButton];
            [addButton addTarget:self action:@selector(addNewZFBL:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionLabel = [self.sectionAry objectAtIndex:indexPath.section];
    if([sectionLabel isEqualToString:@"执法笔录"])
    {
        NSDictionary *item = [self.zfblAry objectAtIndex:indexPath.row];
        NSString *name = [item objectForKey:@"RECORD_NAME"];
        int count = [[item objectForKey:@"RECORD_COUNT"] intValue];
        if(count > 0)
        {
            ZFBLListViewController *list = [[ZFBLListViewController alloc] initWithNibName:@"ZFBLListViewController" bundle:nil];
            list.title = name;
            if([name isEqualToString:XCKCBL_NAME])
            {
                list.RECORDNAME = @"XCKCBL";
            }
            else if([name isEqualToString:FJXX_NAME])
            {
                list.RECORDNAME = @"FJXX";
            }
            else if([name isEqualToString:DCXWBL_NAME])
            {
                list.RECORDNAME = @"DCXWBL";
            }
            else if([name isEqualToString:WRYXCJCJLB_NAME])
            {
                list.RECORDNAME = @"WRYXCJCJLB";
            }
            else if([name isEqualToString:XCHJJCZGYJS_NAME])
            {
                list.RECORDNAME = @"XCHJJCZGYJS";
            }
            else if([name isEqualToString:XFDCJLD_NAME])
            {
                list.RECORDNAME = @"XFDCJLD";
            }
            list.XCZFBH = self.YWBH;
            list.WRYBH = self.WRYBH;
            list.YWBH = self.YWBH;
            list.WRYMC = @"";
            [self.navigationController pushViewController:list animated:YES];
        }
    }
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
        self.sectionAry = [[detailDict objectForKey:@"GROUP_LABEL"] componentsSeparatedByString:@";"];
        self.jbxxAry    = [detailDict objectForKey:@"基本信息"];
        self.djxxAry    = [detailDict objectForKey:@"登记信息"];
        self.ladjxxAry  = [detailDict objectForKey:@"立案登记信息"];
        self.btsdwAry   = [detailDict objectForKey:@"被投诉单位"];
        self.blgcAry    = [detailDict objectForKey:@"办理过程"];
        self.zfblAry    = [detailDict objectForKey:@"执法笔录"];
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

- (void)processError:(NSError *)error andTag:(NSInteger)tag
{
    [self showAlertMessage:@"获取数据出错!"];
}

- (void)viewDidUnload
{
    [self setDetailTableView:nil];
    [super viewDidUnload];
}

- (CGFloat)getCellHeight:(NSString *)itemTitle
{
    if([itemTitle isEqual:[NSNull null]])
    {
        return 60;
    }
    if(itemTitle == nil || itemTitle.length <= 0)
    {
        return 60;
    }
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:19.0];
    CGFloat cellHeight = [NSStringUtil calculateTextHeight:itemTitle byFont:font andWidth:520.0]+20;
    if(cellHeight < 60)
        cellHeight = 60;
    return cellHeight;
}

#pragma mark - Event Handler Methods

- (void)addNewZFBL:(UIButton *)sender
{
    NSDictionary *item = [self.zfblAry objectAtIndex:sender.tag];
    NSString *name = [item objectForKey:@"RECORD_NAME"];
    if([name isEqualToString:XCKCBL_NAME])
    {
        //现场检查（勘查）笔录
        SiteInforcementConroller *controller = [[SiteInforcementConroller alloc] initWithNibName:@"SiteInforcementConroller" bundle:Nil];
        controller.dwbh = self.WRYBH;
        controller.wrymc = [itemParams objectForKey:@"DWMC"];
        controller.xczfbh = self.YWBH;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([name isEqualToString:FJXX_NAME])
    {
        //现场监察附件
        InvestigateEvidenceVC *controller = [[InvestigateEvidenceVC alloc] initWithNibName:@"InvestigateEvidenceVC" bundle:Nil];
        controller.dwbh = self.WRYBH;
        controller.wrymc = [itemParams objectForKey:@"DWMC"];
        controller.xczfbh = self.YWBH;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([name isEqualToString:DCXWBL_NAME])
    {
        //调查询问笔录
        QueryWriteController *controller = [[QueryWriteController alloc] initWithNibName:@"QueryWriteController" bundle:Nil];
        controller.dwbh = self.WRYBH;
        controller.wrymc = [itemParams objectForKey:@"DWMC"];
        controller.xczfbh = self.YWBH;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([name isEqualToString:WRYXCJCJLB_NAME])
    {
        //污染源现场检查记录表
        FieldMonitorViewController *controller = [[FieldMonitorViewController alloc] init];
        controller.dwbh = self.WRYBH;
        controller.wrymc = [itemParams objectForKey:@"DWMC"];
        controller.xczfbh = self.YWBH;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([name isEqualToString:XCHJJCZGYJS_NAME])
    {
        //现场环境监察整改意见书
        InspectOpinionViewController *controller = [[InspectOpinionViewController alloc] initWithNibName:@"InspectOpinionViewController" bundle:nil];
        controller.dwbh = self.WRYBH;
        controller.wrymc = [itemParams objectForKey:@"DWMC"];
        controller.xczfbh = self.YWBH;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)HandleGWResult:(BOOL)ret
{
    self.bOKFromTransfer = ret;
}

@end
