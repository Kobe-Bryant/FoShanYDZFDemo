//
//  ZFTZChildRecordViewController.m
//  BoandaProject
//
//  Created by 曾静 on 13-10-28.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "ZFTZChildRecordViewController.h"
#import "ServiceUrlString.h"
#import "PDJsonkit.h"
#import "UITableViewCell+TaskManager.h"
#import "ZFTZRecordDetailViewController.h"
#import "DisplayAttachFileController.h"

@interface ZFTZChildRecordViewController ()
@property (nonatomic, strong) NSArray *listDataArray;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, assign) BOOL isLoading;
@end

@implementation ZFTZChildRecordViewController
@synthesize listDataArray, urlString, isLoading;

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
    
    //设置导航栏标题
    if([self.taskType isEqualToString:@"DCXWBL"])
    {
        self.title = DCXWBL_NAME;
    }
    else if([self.taskType isEqualToString:@"XCKCBL"])
    {
        self.title = XCKCBL_NAME;
    }
    else if([self.taskType isEqualToString:@"WRYXCJCJLB"])
    {
        self.title = WRYXCJCJLB_NAME;
    }
    else if([self.taskType isEqualToString:@"FJXX"])
    {
        self.title = FJXX_NAME;
    }
    else if([self.taskType isEqualToString:@"XCHJJCZGYJS"])
    {
        self.title = XCHJJCZGYJS_NAME;
    }
    
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

- (void)requestData
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"TZ_ZFBD_LIST" forKey:@"service"];
    [params setObject:self.taskType forKey:@"TYPE"];
    [params setObject:self.xczfbh forKey:@"XCZFBH"];
    NSString *UrlStr = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:UrlStr andParentView:self.view delegate:self];
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
        self.listDataArray = listAry;
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
    return 120.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
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
    NSDictionary *dict = [self.listDataArray objectAtIndex:indexPath.row];
    NSString *bjcdwmc = [dict objectForKey:@"WRYMC"];//被检查单位名称
    if([self.taskType isEqualToString:@"XCKCBL"])
    {
        //现场勘查笔录
        NSString *jcr = [dict objectForKey:@"JCR"];
        NSString *jskssj = [dict objectForKey:@"KCKSSJ"];
        NSString *jsjssj = [dict objectForKey:@"KCJSSJ"];
        NSString *title01 = [NSString stringWithFormat:@"被检查单位：%@", bjcdwmc];
        NSString *title02 = [NSString stringWithFormat:@"检查人：%@", jcr];
        NSString *title03 = [NSString stringWithFormat:@"开始时间：%@   结束时间：%@", jskssj, jsjssj];
        cell = [UITableViewCell makeSubCell:tableView andWithTitle1:title01 andWithTitle2:title02 andWithTitle3:title03 andWithRecordType:self.taskType];
    }
    else if([self.taskType isEqualToString:@"DCXWBL"])
    {
        //调查询问笔录
        NSString *jcr = [dict objectForKey:@"XWR"];
        NSString *jskssj = [dict objectForKey:@"KSSJ"];
        NSString *jsjssj = [dict objectForKey:@"JSSJ"];
        NSString *title01 = [NSString stringWithFormat:@"被检查单位：%@", bjcdwmc];
        NSString *title02 = [NSString stringWithFormat:@"询问人：%@", jcr];
        NSString *title03 = [NSString stringWithFormat:@"开始时间：%@   结束时间：%@", jskssj, jsjssj];
        cell = [UITableViewCell makeSubCell:tableView andWithTitle1:title01 andWithTitle2:title02 andWithTitle3:title03 andWithRecordType:self.taskType];
    }
    else if([self.taskType isEqualToString:@"WRYXCJCBL"])
    {
        //污染源现场检查笔录
        NSString *jcr = [dict objectForKey:@"JCR"];
        NSString *jcsj = [dict objectForKey:@"ZFSJ"];
        NSString *title01 = [NSString stringWithFormat:@"被检查单位：%@", bjcdwmc];
        NSString *title02 = [NSString stringWithFormat:@"检查人：%@", jcr];
        NSString *title03 = [NSString stringWithFormat:@"检查时间：%@", jcsj];
        cell = [UITableViewCell makeSubCell:tableView andWithTitle1:title01 andWithTitle2:title02 andWithTitle3:title03 andWithRecordType:self.taskType];
    }
    else if ([self.taskType isEqualToString:@"WRYXCJCJLB"])
    {
        NSString *jcr = [dict objectForKey:@"JCR"];
        NSString *jcsj = [dict objectForKey:@"ZFSJ"];
        NSString *title01 = [NSString stringWithFormat:@"被检查单位：%@", bjcdwmc];
        NSString *title02 = [NSString stringWithFormat:@"检查人：%@", jcr];
        NSString *title03 = [NSString stringWithFormat:@"检查时间：%@", jcsj];
        cell = [UITableViewCell makeSubCell:tableView andWithTitle1:title01 andWithTitle2:title02 andWithTitle3:title03 andWithRecordType:self.taskType];
    }
    else if ([self.taskType isEqualToString:@"XCHJJCZGYJS"])
    {
        //现场环境监察整改意见书
        NSString *jcr = [dict objectForKey:@"JCR"];
        NSString *jcsj = [dict objectForKey:@"ZFSJ"];
        NSString *title01 = [NSString stringWithFormat:@"被检查单位：%@", bjcdwmc];
        NSString *title02 = [NSString stringWithFormat:@"检查人：%@", jcr];
        NSString *title03 = [NSString stringWithFormat:@"检查时间：%@", jcsj];
        cell = [UITableViewCell makeSubCell:tableView andWithTitle1:title01 andWithTitle2:title02 andWithTitle3:title03 andWithRecordType:self.taskType];
    }
    else if ([self.taskType isEqualToString:@"FJXX"])
    {
        //附件信息
        NSString *jcr = [dict objectForKey:@"CJR"];
        NSString *bz = [dict objectForKey:@"FJBZ"];
        NSString *fjmc = [dict objectForKey:@"FJMC"];
        NSString *fjlx = [dict objectForKey:@"FJLX"];
        NSString *title01 = [NSString stringWithFormat:@"附件名称：%@", fjmc];
        NSString *title02 = [NSString stringWithFormat:@"上传人：%@ 附件类型：%@",jcr, fjlx];
        NSString *title03 = [NSString stringWithFormat:@"备注：%@", bz];
        cell = [UITableViewCell makeSubCell:tableView andWithTitle1:title01 andWithTitle2:title02 andWithTitle3:title03 andWithRecordType:self.taskType];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.taskType isEqualToString:@"FJXX"])
    {
        NSDictionary *dict = [self.listDataArray objectAtIndex:indexPath.row];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"DOWN_OA_FILES" forKey:@"service"];
        [params setObject:@"DOWNLOAD_XCQZ_FILE" forKey:@"GLLX"];
        [params setObject:@".jpg" forKey:@"FJLX"];
        [params setObject:[dict objectForKey:@"BH"] forKey:@"BH"];
        NSString *FJDZ = [[dict objectForKey:@"FJDZ"] lastPathComponent];
        [params setObject:FJDZ forKey:@"PATH"];
        NSString *strURL = [ServiceUrlString generateUrlByParameters:params];
        NSString *fileName = [NSString stringWithFormat:@"%@%@",[dict objectForKey:@"FJMC"],[dict objectForKey:@"FJLX"]];
        DisplayAttachFileController *detail = [[DisplayAttachFileController alloc] initWithNibName:@"DisplayAttachFileController" fileURL:strURL andFileName:fileName];
        [self.navigationController pushViewController:detail animated:YES];
    }
    else
    {
        NSDictionary *dict = [self.listDataArray objectAtIndex:indexPath.row];
        ZFTZRecordDetailViewController *detail = [[ZFTZRecordDetailViewController alloc] initWithNibName:@"ZFTZRecordDetailViewController" bundle:nil];
        detail.bh = [dict objectForKey:@"BH"];
        detail.type = self.taskType;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

@end
