//
//  ZFTZRecordDetailViewController.m
//  FoShanYDZF
//
//  Created by 曾静 on 13-11-14.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "ZFTZRecordDetailViewController.h"
#import "ServiceUrlString.h"

@interface ZFTZRecordDetailViewController ()
@property (nonatomic, strong) UIWebView *myWebView;
@end

@implementation ZFTZRecordDetailViewController
@synthesize myWebView;

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
    
    //创建UIWebView
    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)];
    self.myWebView.delegate = self;
    myWebView.scalesPageToFit = YES;
    [self.view addSubview:myWebView];
    
    //请求数据
    [self requestData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network Handler Methods

- (void)requestData
{
    NSString *serviceName = [NSString stringWithFormat:@"%@_DETAIL", self.type];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:serviceName forKey:@"service"];
    [params setObject:self.bh forKey:@"BH"];
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self];
}

- (void)processWebData:(NSData *)webData
{
    if (webData.length <= 0)
    {
        return;
    }
    NSString *str = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    [self.myWebView loadHTMLString:str baseURL:nil];
}

- (void)processError:(NSError *)error
{
    [self.myWebView loadHTMLString:@"获取数据出错" baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.myWebView.dataDetectorTypes = UIDataDetectorTypeNone;
}

@end
