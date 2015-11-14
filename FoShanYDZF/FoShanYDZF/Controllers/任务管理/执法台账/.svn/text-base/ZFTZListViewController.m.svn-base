//
//  ZFTZListViewController.m
//  BoandaProject
//
//  Created by 曾静 on 13-10-28.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "ZFTZListViewController.h"
#import "ServiceUrlString.h"
#import "PDJsonkit.h"
#import "MenuHelper.h"
#import "UITableViewCell+TaskManager.h"
#import "DefaultDataHelper.h"
#import "ZFTZMainRecordViewController.h"
#import "ZFTZHJXFDetailViewController.h"

#define kTag_KSSJ_Field 1001 //开始时间
#define kTag_JSSJ_Field 1002 //结束时间
#define kTag_ZFLX_Field 1003 //执法类型

@interface ZFTZListViewController ()

@property (nonatomic, strong) NSMutableArray *listDataArray;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, assign) int totalCount;//总记录条数
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) int currentPage;//当前页
@property (nonatomic, assign) int currentTag;//当前选中的控件的Tag
@property (nonatomic, strong) UIPopoverController *popController;

@property (nonatomic, strong) NSArray *taskTypeNameAry;//任务类型名称
@property (nonatomic, strong) NSArray *taskTypeCodeAry;//任务类型对应的代码
@property (nonatomic, strong) NSString *selectedTaskTypeCode;

@end

@implementation ZFTZListViewController

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
    
    self.title = @"任务台账";
    
    //初始化任务类型数据
    [self initTaskTypeData];
    
    //初始化默认数据
    [self initDefaultData];
    
    //初始化查询区域视图控件
    [self initQueryView];
    
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
    [self setKssjField:nil];
    [self setJssjField:nil];
    [self setZflxField:nil];
    [self setWyrmcField:nil];
    [self setSearchButton:nil];
    [super viewDidUnload];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //视图消失前保证Pop已经消失
    if(self.popController)
    {
        [self.popController dismissPopoverAnimated:YES];
    }
    [super viewWillDisappear:animated];
}

#pragma mark - UITableView DataSource & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
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
    headerView.text = [NSString stringWithFormat:@"  查询结果:%d条", self.listDataArray.count];
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.listDataArray objectAtIndex:indexPath.row];
    NSString *dwmc = [dict objectForKey:@"C"];//单位名称
    NSString *rwbh = [dict objectForKey:@"F"];//任务类型编号
    NSString *rwmc = [DefaultDataHelper getTaskTypeNameByCode:rwbh];//任务类型名称
    NSString *zflx = [NSString stringWithFormat:@"任务类型：%@", rwmc];
    
    UITableViewCell *cell = nil;
    if([rwbh isEqualToString:@"43000000000000005"])
    {
        //环境信访
        NSString *btsdwmc = [NSString stringWithFormat:@"被投诉单位：%@", dwmc];
        NSString *tsr = [dict objectForKey:@"D"];//投诉人
        NSString *tssj = [dict objectForKey:@"E"];//投诉时间
        NSString *rwqk = [NSString stringWithFormat:@"投诉人：%@   投诉时间：%@", tsr, tssj];
        cell = [UITableViewCell makeSubCell:tableView andWithTitle1:btsdwmc andWithTitle2:zflx andWithTitle3:rwqk andWithTaskType:rwbh];
    }
    else if([rwbh isEqualToString:@"43000000003"])
    {
        //污染源监察
        NSString *bjcdwmc = [NSString stringWithFormat:@"被检查单位：%@", dwmc];
        NSString *fqr = [dict objectForKey:@"D"];//任务发起人
        NSString *fqsj = [dict objectForKey:@"E"];//发起时间
        NSString *rwqk = [NSString stringWithFormat:@"检查人：%@   检查时间：%@", fqr, fqsj];
        cell = [UITableViewCell makeSubCell:tableView andWithTitle1:bjcdwmc andWithTitle2:zflx andWithTitle3:rwqk andWithTaskType:rwbh];
    }
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    int pages = self.totalCount%25 == 0 ? self.totalCount/25 : self.totalCount/25+1;
    if(self.currentPage == pages || pages == 0 || self.totalCount <= 25)
    {
        return;
    }
	if (self.isLoading)
    {
        return;
    }
    if (scrollView.contentSize.height - scrollView.contentOffset.y <= 850 )
    {
        self.currentPage++;
        NSString *strUrl = [NSString stringWithFormat:@"%@&P_CURRENT=%d",self.urlString, self.currentPage];
        self.isLoading = YES;
        self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.listDataArray objectAtIndex:indexPath.row];
    NSString *rwbh = [dict objectForKey:@"F"];//任务类型编号
    if([rwbh isEqualToString:@"43000000000000005"])
    {
        //环境信访
        NSDictionary *dict = [self.listDataArray objectAtIndex:indexPath.row];
        ZFTZHJXFDetailViewController *mainRecord = [[ZFTZHJXFDetailViewController alloc] init];
        //mainRecord.wrymc = [dict objectForKey:@"TITLE"];
        mainRecord.xfbh = [dict objectForKey:@"A"];
        [self.navigationController pushViewController:mainRecord animated:YES];
    }
    else if([rwbh isEqualToString:@"43000000003"])
    {
        //污染源监察
        NSDictionary *dict = [self.listDataArray objectAtIndex:indexPath.row];
        ZFTZMainRecordViewController *mainRecord = [[ZFTZMainRecordViewController alloc] initWithNibName:@"ZFTZMainRecordViewController" bundle:nil];
        mainRecord.wrymc = [dict objectForKey:@"TITLE"];
        mainRecord.xczfbh = [dict objectForKey:@"A"];
        [self.navigationController pushViewController:mainRecord animated:YES];
    }
}

#pragma mark - Network Handler Methods

/**
    @brief 获取任务台账数据
    @see 服务名:TZ_LIST,参数默认为空时获取全部
 */
- (void)requestData
{
    self.isLoading = YES;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"TZ_LIST" forKey:@"service"];
    NSString *UrlStr = [ServiceUrlString generateUrlByParameters:params];
    self.urlString = UrlStr;
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:self.urlString andParentView:self.view delegate:self];
}

- (void)processWebData:(NSData *)webData
{
    self.isLoading = NO;
    if(webData.length <= 0)
    {
        return;
    }
    NSString *jsonStr = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSArray *listAry = [jsonStr objectFromJSONString];
    BOOL bParsedError = NO;
    if(listAry != nil)
    {
        if(listAry.count > 0)
        {
            [self.listDataArray addObjectsFromArray:listAry];
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

- (void)processError:(NSError *)error
{
    self.isLoading = NO;
    [self showAlertMessage:@"获取数据出错!"];
}

#pragma mark - UITextField Delegate Method

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return NO;
}

#pragma mark - Event Handler Methods

//搜索按钮点击事件处理
- (void)searchButtonClick:(id)sender
{
    if(self.listDataArray)
    {
        [self.listDataArray removeAllObjects];
    }
    [self.listTableView reloadData];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"TZ_LIST" forKey:@"service"];
    if(self.wyrmcField.text != nil && self.wyrmcField.text.length > 0)
    {
        [params setObject:self.wyrmcField.text forKey:@"dwmc"];
    }
    if(self.zflxField.text != nil && self.zflxField.text.length > 0)
    {
        [params setObject:self.selectedTaskTypeCode forKey:@"TASK_TYPE"];
    }
    if(self.kssjField.text != nil && self.kssjField.text.length > 0)
    {
        [params setObject:self.kssjField.text forKey:@"kssj"];
    }
    if(self.jssjField.text != nil && self.jssjField.text.length > 0)
    {
        [params setObject:self.jssjField.text forKey:@"jssj"];
    }
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    self.urlString = urlStr;
    self.isLoading = YES;
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:self.urlString andParentView:self.view delegate:self];
}

//按下控件选择时间
-(void)touchFromDate:(id)sender
{
	UIControl *btn =(UIControl*)sender;
    self.currentTag = btn.tag;
    PopupDateViewController *dateController = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDate];
	dateController.delegate = self;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	[self.popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

//按下控件选择类型
-(void)touchFromType:(id)sender
{
    UIControl *btn =(UIControl*)sender;
    self.currentTag = btn.tag;
    CommenWordsViewController *wordController = [[CommenWordsViewController alloc] initWithNibName:@"CommenWordsViewController" bundle:nil];
    wordController.delegate = self;
    wordController.wordsAry = self.taskTypeNameAry;
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:wordController];
    popover.popoverContentSize = CGSizeMake(200, 300);
    self.popController = popover;
	[self.popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - PopupDateViewController Delegate Method

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date
{
    [self.popController dismissPopoverAnimated:YES];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    if(self.currentTag == kTag_KSSJ_Field)
    {
        self.kssjField.text = dateString;
    }
    else if(self.currentTag == kTag_JSSJ_Field)
    {
        self.jssjField.text = dateString;
    }
}

#pragma mark - CommenWordsViewController Delegate Method

- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row
{
    if(self.popController)
    {
        [self.popController dismissPopoverAnimated:YES];
    }
    if(self.currentTag == kTag_ZFLX_Field)
    {
        self.zflxField.text = words;
        self.selectedTaskTypeCode = [self.taskTypeCodeAry objectAtIndex:row];
    }
}

#pragma mark - Private Methods

//初始化查询区域视图控件
- (void)initQueryView
{
    self.kssjField.tag = kTag_KSSJ_Field;
    [self.kssjField addTarget:self action:@selector(touchFromDate:) forControlEvents:UIControlEventTouchDown];
    self.jssjField.tag = kTag_JSSJ_Field;
    [self.jssjField addTarget:self action:@selector(touchFromDate:) forControlEvents:UIControlEventTouchDown];
    self.zflxField.tag = kTag_ZFLX_Field;
    self.zflxField.delegate = self;
    [self.zflxField addTarget:self action:@selector(touchFromType:) forControlEvents:UIControlEventTouchDown];
    [self.searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

//初始化默认数据
- (void)initDefaultData
{
    self.totalCount = 0;
    self.currentPage = 0;
    self.isLoading = NO;
}

//初始化任务类型数据
- (void)initTaskTypeData
{
    self.taskTypeNameAry = [DefaultDataHelper getTaskTypeNameList];
    self.taskTypeCodeAry = [DefaultDataHelper getTaskTypeCodeList];;
    self.listDataArray = [[NSMutableArray alloc] init];
}

@end
