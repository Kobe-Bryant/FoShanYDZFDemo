//
//  TodoTaskListViewController.m
//  BoandaProject
//
//  Created by 张仁松 on 13-10-12.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//  工作流待办任务查询，分两步加载：先查询出工作流的任务分类，根据任务类型再查待办任务

#import "TodoTaskListViewController.h"
#import "ServiceUrlString.h"
#import "PDJsonkit.h"
#import "QQSectionHeaderView.h"
#import "TaskDetailsViewController.h"

@interface TodoTaskListViewController ()<QQSectionHeaderViewDelegate>
@property(nonatomic,strong)UITableView *listTableView;
@property(nonatomic,strong)NSArray *aryTaskCount;//各种类型的待办任务总数
@property(nonatomic,strong)NSMutableDictionary *dicSubTasks;
@property(nonatomic,assign) NSInteger taskTypeIndex; //在aryTaskCount中的索引
@property (nonatomic,strong) NSMutableArray *arySectionIsOpen;

@end

#define DATA_COUNT -1


@implementation TodoTaskListViewController
@synthesize listTableView,dicSubTasks,taskTypeIndex,aryTaskCount,arySectionIsOpen;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"待办任务列表";
    }
    return self;
}

//获取指定类型的待办任务个数
-(void)requestTaskList:(NSString*)lclxbh
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_TODO_TASK_LIST" forKey:@"service"];
    [params setObject:lclxbh forKey:@"TASK_TYPE"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在请求数据..." tagID:taskTypeIndex] ;
}

//获取待办任务的类型以及个数
-(void)requestTaskCount
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_TASK_TYPE_COUNT" forKey:@"service"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在请求数据..." tagID:DATA_COUNT] ;
}

-(void)processWebData:(NSData*)webData andTag:(NSInteger)tag
{
    if([webData length] <=0 )
    {
        NSString *msg = @"没有获取到相关数据。";
        [self showAlertMessage:msg];
        return;
    }
    NSString *resultJSON = [[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
    
    if(tag == DATA_COUNT)
    {
        self.aryTaskCount = [resultJSON objectFromJSONString];
        if(aryTaskCount == nil)
        {
            [self showAlertMessage:@"没有待办任务。"];
            return;
        }
        self.arySectionIsOpen = [NSMutableArray arrayWithCapacity:5];
        for (NSInteger i = 0; i < [aryTaskCount count]; i++)
        {
            [arySectionIsOpen addObject:[NSNumber numberWithBool:NO]];
        }
        [self.listTableView reloadData];
    }
    else
    {
        NSArray *ary = [resultJSON objectFromJSONString];
        NSDictionary *dicInfo = [aryTaskCount objectAtIndex:taskTypeIndex];
        //NSString *name = [dicInfo objectForKey:@"LCMC"];
        NSString *LCLXBH = [dicInfo objectForKey:@"LCLXBH"];
        if(dicSubTasks == nil)
        {
            self.dicSubTasks = [NSMutableDictionary dictionaryWithCapacity:3];
        }
        if(ary == nil)
        {
            ary = [NSArray array];
        }
        [dicSubTasks setObject:ary forKey:LCLXBH];
        [self.listTableView reloadData];
    }
}

-(void)processError:(NSError *)error{
    [self showAlertMessage:@"请求数据失败,请检查网络."];
    
    return;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.dicSubTasks = nil;
    [self requestTaskCount];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768, 960) style:UITableViewStylePlain];
    [self.view addSubview:listTableView];
    listTableView.dataSource = self;
    listTableView.delegate = self;
    [self requestTaskCount];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Table view data source

#define HEADER_HEIGHT 59

#pragma mark -
#pragma mark Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return HEADER_HEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [aryTaskCount count]; // 分组数
}



-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat headerHeight = HEADER_HEIGHT;
    NSDictionary *tmpDic = [aryTaskCount objectAtIndex:section];
    
    NSString *title = [NSString stringWithFormat:@"%@（%d）",[tmpDic objectForKey:@"LCMC"],[[tmpDic objectForKey:@"TASKCOUNT"] integerValue]];
    BOOL opened = YES;
    if(section < [arySectionIsOpen count]){
        opened = [[arySectionIsOpen objectAtIndex:section] boolValue];
    }
    
	QQSectionHeaderView *sectionHeadView = [[QQSectionHeaderView alloc]
                                            initWithFrame:CGRectMake(0.0, 0.0, self.listTableView.bounds.size.width, headerHeight)
                                            title:title
                                            section:section
                                            opened:opened
                                            delegate:self];
	return sectionHeadView ;
}

#pragma mark - QQ section header view delegate

-(void)sectionHeaderView:(QQSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section
{
    NSNumber *opened = [arySectionIsOpen objectAtIndex:section];
    [arySectionIsOpen replaceObjectAtIndex:section withObject:[NSNumber numberWithBool:!opened.boolValue]];
	
	// 收缩+动画 (如果不需要动画直接reloaddata)
	NSInteger countOfRowsToDelete = [listTableView numberOfRowsInSection:section];
    if (countOfRowsToDelete > 0)
    {
		[self.listTableView reloadData];
        
    }
}


-(void)sectionHeaderView:(QQSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section
{
    NSDictionary *dicInfo = [aryTaskCount objectAtIndex:section];
    if([[dicInfo objectForKey:@"TASKCOUNT"] integerValue] == 0)
        return;
    
	NSNumber *opened = [arySectionIsOpen objectAtIndex:section];
    [arySectionIsOpen replaceObjectAtIndex:section withObject:[NSNumber numberWithBool:!opened.boolValue]];
    taskTypeIndex = section;
    
    // NSString *name = [dicInfo objectForKey:@"LCMC"];
    NSString *LCLXBH = [dicInfo objectForKey:@"LCLXBH"];
    
    
    if(dicSubTasks == nil){ //没有请求过对应的数据
        [self requestTaskList:LCLXBH];
    }else {
        NSArray *ary = [dicSubTasks objectForKey:LCLXBH];
        if(ary == nil)
            [self requestTaskList:LCLXBH];
        else
            [self.listTableView reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section < [arySectionIsOpen count]){
        BOOL opened = [[arySectionIsOpen objectAtIndex:section] boolValue];
        if(opened == NO) return 0;
    }
    NSDictionary *dicInfo = [aryTaskCount objectAtIndex:section];
    // NSString *name = [dicInfo objectForKey:@"LCMC"];
    NSString *LCLXBH = [dicInfo objectForKey:@"LCLXBH"];
    NSArray *ary = [dicSubTasks objectForKey:LCLXBH];
	return [ary count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // if(indexPath.row%2 == 0)
    //    cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *identifier = @"CellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
    NSDictionary *dicInfo = [aryTaskCount objectAtIndex:indexPath.section];
    NSString *LCLXBH = [dicInfo objectForKey:@"LCLXBH"];
    NSArray *ary = [dicSubTasks objectForKey:LCLXBH];
    if(indexPath.row < [ary count]){
        NSDictionary *rowInfo = [ary objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [rowInfo objectForKey:@"DWMC"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"交办人：%@    流程期限：%@    步骤名称：%@",[rowInfo objectForKey:@"BZCJR"],[rowInfo objectForKey:@"BZQX"],[rowInfo objectForKey:@"BZMC"]];
    }
    
    
    
	
	return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    TaskDetailsViewController *details = [[TaskDetailsViewController alloc] initWithNibName:@"TaskDetailsViewController" bundle:nil];
    NSDictionary *dicInfo = [aryTaskCount objectAtIndex:indexPath.section];
    NSString *LCLXBH = [dicInfo objectForKey:@"LCLXBH"];
    NSArray *ary = [dicSubTasks objectForKey:LCLXBH];
    NSDictionary *rowInfo = [ary objectAtIndex:indexPath.row];
    
    details.YWBH = [rowInfo objectForKey:@"YWBH"];
	details.LCSLBH = [rowInfo objectForKey:@"LCSLBH"];
    details.LCLXBH = [rowInfo objectForKey:@"LCLXBH"];
    details.WRYBH = [rowInfo objectForKey:@"WRYBH"];
    details.itemParams = rowInfo;
    [self.navigationController pushViewController:details animated:YES];
}



@end
