//
//  DynamicRecordViewController.m
//  BoandaProject
//
//  Created by 张仁松 on 13-10-17.
//  Copyright (c) 2013年 szboanda. All rights reserved.
//
/*
 service=LIST_WRY_ZFBD&WRYBH=310000000000201300250&TYPE=1&ZFBH=1#
 获取污染源对应的表单模板
 */

/* 获取动态表单模板id
 QUERY_ZFBD_URL
 [{"MBBH":"20130723110501b6feb85b3c2e426d925b884e7ad8295d","MBMC":"污染源现场监察记录表_餐饮娱乐SH"},{"MBBH":"201308161727203dbabae3fb454215849376fa07b43c85","MBMC":"铅蓄电池检查表"},{"MBBH":"2013082815162662fd52da9c19402b9f2611775a8d5a27","MBMC":"上海市现场检查记录"},}
 */
/* 
 组合动态表单url：
 service:QUERY_ZFBD
 参数：ZFBH、recordId、templateId、&reqType=android
view=1是否能编辑，否
 loadAll=true加载完整表单
 WRYBH
 ZFBM：登录人所在部门
 */
/* 提交数据：
 OPERATE_ZFBD
 "javascript:fillJwd('"+s1+"','"+s2+"','"+locPoint.x+"','"+locPoint.y+"')
javascript:fetchTempData()");//暂存数据 
 "javascript:fillUserOrDepartment('"+typeId+"','"+USER_IDS+"','"+USER_NAMES+"')"
 */

#import "DynamicRecordViewController.h"
#import "SystemConfigContext.h"
#import "ServiceUrlString.h"
#import "PDJsonkit.h"

@interface DynamicRecordViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSString *templateid;
@end

@implementation DynamicRecordViewController
@synthesize webView,templateid;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)returnSites:(NSDictionary*)values outsideComp:(BOOL)bOutside{
    if (values == nil) {
		[self.navigationController popViewControllerAnimated:YES];
	}
	else {
        if (bOutside) {
            [btnTitleView setTitle:[values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.wrymc = self.title = [values objectForKey:@"WRYMC"];
            self.dwbh = @"";
        }
        else
        {
            self.dwbh     = [values objectForKey:@"WRYBH"];
            self.wrymc = self.title =  [values objectForKey:@"WRYMC"];
            [btnTitleView setTitle: [values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
        }
        [self  queryXCZFBH];
	}
}

-(void)xczfbhHasGenerated{
    [self loadDTBDInfo];
}

-(void)loadDTBDInfo{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"LIST_WRY_ZFBD" forKey:@"service"];
    [params setObject:self.dwbh forKey:@"WRYBH"];
    [params setObject:self.xczfbh forKey:@"ZFBH"];
    [params setObject:@"1" forKey:@"TYPE"];
    //TYPE=1表示上海
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:nil delegate:self tipInfo:@"正在获取动态表单数据..." tagID:LIST_WRY_ZFBD] ;
}

-(void)loadDTBDView{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_ZFBD" forKey:@"service"];
    [params setObject:templateid forKey:@"templateId"];
    [params setObject:self.xczfbh forKey:@"ZFBH"];
    [params setObject:@"" forKey:@"recordId"];
    [params setObject:self.dwbh forKey:@"WRYBH"];
    
    [params setObject:@"android" forKey:@"reqType"];
    [params setObject:@"true" forKey:@"loadAll"];
    
    NSDictionary *userInfo = [[SystemConfigContext sharedInstance] getUserInfo];
    
    [params setObject:[userInfo objectForKey:@"depart"] forKey:@"ZFBM"];
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commitBilu:(id)sender
{
    NSString *ret = [webView stringByEvaluatingJavaScriptFromString:@"fetchData()"];
    NSLog(@"result:%@",ret);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlString = [[request URL] absoluteString];
    
    NSArray *urlComps = [urlString componentsSeparatedByString:@":"];
    
    if([urlComps count] && [[urlComps objectAtIndex:0] isEqualToString:@"objc"])
        
    {
        
        NSString *funcStr = [urlComps objectAtIndex:1];
        
        if([funcStr isEqualToString:@"doFunc1"])
            
        {
            
            /*调用本地函数1*/
            
        }
        else if([funcStr isEqualToString:@"doFunc2"])
            
        {
            
            /*调用本地函数2*/
            
        }
        
        return NO;
        
    }
    return YES;
}

-(void) showDynaData:(NSString*) data{
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

-(void)processError:(NSError *)error{
    
}
//[{"MBBH":"2013082815162662fd52da9c19402b9f2611775a8d5a27","MBMC":"上海市现场检查记录","SIZE":0}]
-(void)processWebData:(NSData*)webData andTag:(NSInteger)tag
{
    if(tag != LIST_WRY_ZFBD)
        return [super processWebData:webData andTag:tag];
    if([webData length] <=0 )
    {
        NSString *msg = @"查询数据失败";
        [self showAlertMessage:msg];
        return;
    }
    NSString *resultJSON = [[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
    BOOL bfailed = YES;
    NSArray *aryResult = [resultJSON objectFromJSONString];
    if(aryResult && [aryResult count])
    {
        NSDictionary *dic = [aryResult objectAtIndex:0];
        if(dic){
            self.templateid = [dic objectForKey:@"MBBH"];
            bfailed = NO;
            [self loadDTBDView];
        }
    }
    if(bfailed )
    {
        NSString *msg = @"没有查询到该污染源的动态表单。";
        [self showAlertMessage:msg];

    }
    
}

@end
