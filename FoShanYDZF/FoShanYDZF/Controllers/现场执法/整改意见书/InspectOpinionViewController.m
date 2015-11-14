//
//  InspectOpinionViewController.m
//  FoShanYDZF
//
//  Created by ihumor on 13-11-18.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "InspectOpinionViewController.h"
#import "InspectFirstView.h"
#import "InspectSecondView.h"
#import "PDJsonkit.h"
#import "SystemConfigContext.h"
#import "ServiceUrlString.h"
#import "RecordPrintViewController.h"

@interface InspectOpinionViewController ()
@property (nonatomic, strong) InspectFirstView *firstView;
@property (nonatomic, strong) InspectSecondView *secondView;
@end

@implementation InspectOpinionViewController
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.tableName = @"T_YDZF_XCHJJCZGYJS";
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)];
    scrollView.delaysContentTouches = NO;
    [self.view addSubview:scrollView];
    [self addAllViews];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    if (self.isHisRecord)
    {
        //如果是历史笔录表，所有的按钮都不能点击
        NSArray *aryChildViews1= [self.firstView subviews];
        NSArray *aryChildViews2= [self.secondView subviews];
        NSMutableArray *ary = [[NSMutableArray alloc] init];
        [ary addObjectsFromArray:aryChildViews1];
        [ary addObjectsFromArray:aryChildViews2];
        for(UIView *childView in ary)
        {
            if ([childView isKindOfClass:[UITextField class]] || [childView isKindOfClass:[UISegmentedControl class]]|| [childView isKindOfClass:[UITextView class]] || [childView isKindOfClass:[UISwitch class]])
            {
                UIControl *ctrl = (UIControl*)childView;
                ctrl.userInteractionEnabled = NO;
            }
        }
        
        UIBarButtonItem *printButton = [[UIBarButtonItem alloc] initWithTitle:@"打印" style:UIBarButtonItemStyleDone target:self action:@selector(onPrintClick:)];
        self.navigationItem.rightBarButtonItem = printButton;
    }
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addAllViews
{
    InspectFirstView *view1 =[[InspectFirstView alloc] init];
    view1.frame = CGRectMake(0, 0,768 ,960);
    self.firstView = view1;
    [self.scrollView addSubview:self.firstView];
    
    InspectSecondView *view2 =[[InspectSecondView alloc] init];
    view2.frame = CGRectMake(0, 980,768 ,960);
    self.secondView = view2;
    [self.scrollView addSubview:self.secondView];
    
    [scrollView setContentSize:CGSizeMake(768, 960*2+330)];
    
}

-(void)returnSites:(NSDictionary*)values outsideComp:(BOOL)bOut
{
	if (values == nil)
    {
		[self.navigationController popViewControllerAnimated:YES];
	}
	else
    {
        if (bOut)
        {
            [btnTitleView setTitle:[values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.wrymc = self.title =  [values objectForKey:@"WRYMC"];
            self.dwbh = @"";
            
        }
        else
        {
            self.dwbh = [values objectForKey:@"WRYBH"];
            self.wrymc = self.title =  [values objectForKey:@"WRYMC"];
            [btnTitleView setTitle: [values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.dicWryInfo = values;
            self.firstView.wrymcField.text = self.wrymc;
            self.firstView.dzField.text = [values objectForKey:@"DWDZ"];
            self.firstView.fzrField.text = [values objectForKey:@"FDDBR"];
            self.firstView.lxfsField.text = [values objectForKey:@"LXDH"];

        }
        bOutSide = bOut;
        [self queryXCZFBH];
        [super returnSites:values outsideComp:bOut];
	}
}

//根据值来显示值
-(void)displayRecordDatas:(id)object
{
    NSDictionary* values = (NSDictionary*)object;
    [self.firstView loadData:values];
    [self.secondView loadData:values];
}

-(void)saveBilu:(id)sender
{
    [super saveBilu:sender];
    NSDictionary *dicData1 = [self.firstView getValueData];
    NSDictionary *dicData2 = [self.secondView getValueData];
    NSMutableDictionary *dicData = [[NSMutableDictionary alloc] init];
    [dicData setValuesForKeysWithDictionary:dicData1];
    [dicData setValuesForKeysWithDictionary:dicData2];
    [dicData setObject:self.dwbh forKey:@"WRYBH"];
    [dicData setObject:self.wrymc forKey:@"WRYMC"];
    [self saveLocalRecord:dicData];
}

-(NSDictionary*)getValueData
{
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithCapacity:25];
    if(self.dicWryInfo)
    {
        [dicParams setDictionary:self.dicWryInfo];
    }
    NSDictionary *dicData1 = [self.firstView getValueData];
    NSDictionary *dicData2 = [self.secondView getValueData];
    [dicParams setValuesForKeysWithDictionary:dicData1];
    [dicParams setValuesForKeysWithDictionary:dicData2];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    NSDictionary *userInfo = [[SystemConfigContext sharedInstance] getUserInfo];
    
    [dicParams setObject:[userInfo objectForKey:@"userId"] forKey:@"CJR"];
    [dicParams setObject:[userInfo objectForKey:@"userId"] forKey:@"JCR"];
    [dicParams setObject:dateString forKey:@"CJSJ"];
    [dicParams setObject:[userInfo objectForKey:@"userId"]  forKey:@"XGR"];
    [dicParams setObject:dateString forKey:@"XGSJ"];
    [dicParams setObject:[userInfo objectForKey:@"orgid"] forKey:@"ORGID"];
    [dicParams setObject:@"iPad" forKey:@"ZDLX"];
    [dicParams setObject:[userInfo objectForKey:@"sjqx"] forKey:@"SJQX"];
    [dicParams setObject:dateString forKey:@"JSSJ"];
    
    [dicParams setObject:self.xczfbh forKey:@"XCZFBH"];
    [dicParams setObject:self.basebh forKey:@"BH"];
    [dicParams setObject:self.dwbh forKey:@"WRYBH"];
    
    return dicParams;
}

-(void)commitBilu:(id)sender
{
    NSDictionary *dicData = [self getValueData];
	[self commitRecordDatas:dicData];
}

-(NSMutableDictionary*)createBaseTableFromWryData:(NSDictionary*)value
{
    NSMutableDictionary *dicParams = [super createBaseTableFromWryData:value];
    return dicParams;
}

//提交数据到对应的笔录表中服务名：COMIT_BL_XCHJJCZGYJS
-(void)commitRecordDatas:(NSDictionary*)value
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"COMIT_BL_XCHJJCZGYJS" forKey:@"service"];
    NSArray *ary = [[NSArray alloc] initWithObjects:@"BH",@"WRYBH",@"WRYMC",@"XCZFBH",@"FDDBR",@"FDDBRLXDH",@"SCQK",@"QTSCQK",@"GSZZ",@"XKGJXMQK",@"HPSPWH",@"HPSPSJ",@"SSCWH",@"SSCSJ",@"HBYSWH",@"HBYSSJ",@"ZYSCSB",@"FQZLSS",@"FQSFZCYX",@"FSZLSS",@"FSSFZCYX",@"GFZLSS",@"GFSFZCYX",@"QTZLSS",@"QTSFZCYX",@"CZWT",@"XCCLYJ",@"QT",@"CJR",@"CJSJ",@"XGR",@"XGSJ",@"ORGID",@"ZLSS",@"WRYDZ",@"JCR",@"ZFZH",@"WSP",@"WYS",@"SPF",nil];
    NSMutableDictionary *jsonValue = [[NSMutableDictionary alloc] init];
    for (NSString *str in ary)
    {
        NSString * valueStr = [value objectForKey:str];
        if(valueStr == nil)
        {
            valueStr = @"";
        }
        [jsonValue setObject:valueStr forKey:str];
    }
    NSLog(@"%@", [jsonValue JSONString]);
    [params setObject:[jsonValue JSONString] forKey:@"jsonString"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在提交笔录..." tagID:COMMIT_BL_XCJCYJS];
}

//获取历史记录表
-(void)requestHistoryData
{
    [super requestHistoryData];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_XCHJJCZGYJS_HISTORY" forKey:@"service"];
    [params setObject:self.basebh forKey:@"BH"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在查询数据..." tagID:QUERY_XCJCYJS_HISTORY] ;
}

-(void)processError:(NSError *)error
{
    
}

-(void)processWebData:(NSData*)webData andTag:(NSInteger)tag
{
    if(tag != COMMIT_BL_XCJCYJS && tag != QUERY_XCJCYJS_HISTORY)
    {
        return [super processWebData:webData andTag:tag];
    }
    if([webData length] <=0 )
    {
        NSString *msg = @"提交笔录失败";
        [self showAlertMessage:msg];
        return;
    }
    NSString *resultJSON = [[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
    if (tag == COMMIT_BL_XCJCYJS)
    {
        NSRange result = [resultJSON rangeOfString:@"success"];
        if(result.location!= NSNotFound)
        {
            NSDictionary *dicValue = [self getValueData];
            NSDictionary *baseTableJson = [self createBaseTableFromWryData:dicValue];
            [self commitBaseRecordData:baseTableJson];
            return;
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"错误"
                                  message:@"提交数据到服务器失败！"  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            [[[alert subviews] objectAtIndex:2] setBackgroundColor:[UIColor colorWithRed:0.5 green:0.0f blue:0.0f alpha:1.0f]];
            [alert show];
        }
    }
    else if(tag == QUERY_XCJCYJS_HISTORY)
    {
        NSLog(@"%@",resultJSON);
        NSDictionary *dicInfo = [resultJSON objectFromJSONString];
        if(dicInfo)
        {
            NSArray *ary = [dicInfo objectForKey:@"data"];
            if ([ary count] > 0)
            {
                NSDictionary *dicRecordData = [ary objectAtIndex:0];
                self.xczfbh = [dicRecordData objectForKey:@"XCZFBH"];
                [self displayRecordDatas:dicRecordData];
            }
        }
    }
}

- (void)onPrintClick:(id)sender
{
    if(sender)
    {
        RecordPrintViewController *recordPrint = [[RecordPrintViewController alloc] initWithNibName:@"RecordPrintViewController" bundle:nil];
        recordPrint.type = @"XCHJJCZGYJS";
        recordPrint.glbh = self.xczfbh;
        [self.navigationController pushViewController:recordPrint animated:YES];
    }
}

@end
