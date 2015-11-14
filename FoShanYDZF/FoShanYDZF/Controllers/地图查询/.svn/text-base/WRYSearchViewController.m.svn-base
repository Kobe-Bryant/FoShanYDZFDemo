//
//  WRYSearchViewController.m
//  FoShanYDZF
//
//  Created by 曾静 on 13-11-13.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "WRYSearchViewController.h"
#import "WRYConditionListViewController.h"
#import "SearchWryInMapVC.h"
#import "WRYConditionTextViewController.h"
#import "DefaultDataHelper.h"

@interface WRYSearchViewController ()
@property (nonatomic, strong) NSArray *toDisplayTitleAry;
@property (nonatomic, strong) NSMutableArray *toDisplayValueAry;
@property (nonatomic, strong) NSArray *toDisplayKeyAry;
@end

@implementation WRYSearchViewController

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
    
    self.contentSizeForViewInPopover = CGSizeMake(320, 480);
    
    self.toDisplayTitleAry = [[NSArray alloc] initWithObjects:@"污染源名称", @"监管级别", @"所在地市", @"所在区县", @"半径", nil];
    self.toDisplayValueAry = [[NSMutableArray alloc] initWithObjects:@"", @"国控", @"佛山市", @"", @"", nil];
    self.toDisplayKeyAry = [[NSArray alloc] initWithObjects:@"WRYMC", @"JGJB", @"SZDS", @"SZQX", @"RADIUS", nil];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark - UITableView DataSource & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 5;
    }
    else
    {
        return 1;
    }
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        NSString *CellIdentifier = @"Cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        NSString *title = [self.toDisplayTitleAry objectAtIndex:indexPath.row];
        NSString *value = [self.toDisplayValueAry objectAtIndex:indexPath.row];
        cell.textLabel.text = title;
        cell.detailTextLabel.text = value;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else
    {
        NSString *CellIdentifier = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        UIButton *btnSearch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnSearch.titleLabel setFont:[UIFont systemFontOfSize:20]];
        btnSearch.frame = CGRectMake(0, 0, 300, cell.contentView.frame.size.height);
        [btnSearch setTitle:@"开始查询" forState:UIControlStateNormal];
        [btnSearch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnSearch addTarget:self action:@selector(onSearchClcik:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnSearch];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        //污染源名称
        WRYConditionTextViewController *text = [[WRYConditionTextViewController alloc] initWithNibName:@"WRYConditionTextViewController" bundle:nil];
        text.delegate = self;
        text.conditionKey = [self.toDisplayKeyAry objectAtIndex:indexPath.row];
        text.selectedValue = [self.toDisplayValueAry objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:text animated:YES];
    }
    else if (indexPath.row >= 1 && indexPath.row <= 3)
    {
        //监管级别 所在地市 所属区县
        WRYConditionListViewController *list = [[WRYConditionListViewController alloc] initWithNibName:@"WRYConditionListViewController" bundle:nil];
        list.listType = indexPath.row - 1;
        list.delegate = self;
        list.conditionKey = [self.toDisplayKeyAry objectAtIndex:indexPath.row];
        list.selectedValue = [self.toDisplayValueAry objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:list animated:YES];
    }
    else if (indexPath.row == 4)
    {
        //半径
        SearchWryInMapVC *r = [[SearchWryInMapVC alloc] initWithNibName:@"SearchWryInMapVC" bundle:nil];
        r.delegate = self;
        r.conditionKey = [self.toDisplayKeyAry objectAtIndex:indexPath.row];
        r.selectedValue = [self.toDisplayValueAry objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:r animated:YES];
    }
}

#pragma mark - WRYConditionPass Delegate Method

- (void)passCondtionWithValue:(NSString *)value andWithKey:(NSString *)key
{
    if([key isEqualToString:@"WRYMC"])
    {
        //污染源名称
        if(value != nil && value.length > 0)
        {
            [self.toDisplayValueAry setObject:value atIndexedSubscript:0];
        }
    }
    if([key isEqualToString:@"JGJB"])
    {
        //监管级别
        if(value != nil && value.length > 0)
        {
            [self.toDisplayValueAry setObject:value atIndexedSubscript:1];
        }
    }
    if([key isEqualToString:@"SZDS"])
    {
        //所在地市
        if(value != nil && value.length > 0)
        {
            [self.toDisplayValueAry setObject:value atIndexedSubscript:2];
        }
    }
    if([key isEqualToString:@"SZQX"])
    {
        //所在区县
        if(value != nil && value.length > 0)
        {
            [self.toDisplayValueAry setObject:value atIndexedSubscript:3];
        }
    }
    if([key isEqualToString:@"RADIUS"])
    {
        //半径
        if(value != nil && value.length > 0)
        {
            [self.toDisplayValueAry setObject:value atIndexedSubscript:4];
        }
    }
    [self.listTableView reloadData];
}

#pragma mark - Event Handler Method

//搜索按钮点击
- (void)onSearchClcik:(id)sender
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < self.toDisplayTitleAry.count; i++)
    {
        NSString *key = [self.toDisplayKeyAry objectAtIndex:i];
        NSString *value = [self.toDisplayValueAry objectAtIndex:i];
        if(value.length > 0)
        {
            if([key isEqualToString:@"WRYMC"])
            {
                [params setObject:value forKey:key];
            }
            else if ([key isEqualToString:@"JGJB"])
            {
                NSString * v = [DefaultDataHelper getJGJBCodeByName:value];
                [params setObject:v forKey:key];
            }
            else if ([key isEqualToString:@"SZDS"])
            {
                NSString * v = @"440600000000";
                [params setObject:v forKey:key];
            }
            else if ([key isEqualToString:@"SZQX"])
            {
                NSString * v = [DefaultDataHelper getAreaCodeByName:value];
                [params setObject:v forKey:key];
            }
            else if ([key isEqualToString:@"RADIUS"])
            {
                [params setObject:value forKey:key];
            }
        }
    }
    if(params.allKeys.count > 1)
    {
        if([self.delegate respondsToSelector:@selector(passSearchConditon:)])
        {
            [self.delegate passSearchConditon:params];
        }
    }
}

@end
