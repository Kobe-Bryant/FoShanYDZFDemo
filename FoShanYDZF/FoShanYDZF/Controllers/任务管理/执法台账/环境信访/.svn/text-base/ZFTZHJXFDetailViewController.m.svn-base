//
//  ZFTZHJXFDetailViewController.m
//  FoShanYDZF
//
//  Created by 曾静 on 13-11-18.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "ZFTZHJXFDetailViewController.h"
#import "ServiceUrlString.h"
#import "SystemConfigContext.h"
#import "ASIHTTPRequest.h"

@interface ZFTZHJXFDetailViewController ()
@property (nonatomic, assign) BOOL isLoading;
@end

@implementation ZFTZHJXFDetailViewController
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
    
    self.title = @"信访详细";
    
    UISegmentedControl *segCtrl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"案件基本信息",@"调查回复情况",@"案件办理过程", nil]];
    segCtrl.segmentedControlStyle = UISegmentedControlStyleBar;
    segCtrl.selectedSegmentIndex = 0;
    [segCtrl addTarget:self action:@selector(segValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView  = segCtrl;
    
    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)];
    myWebView.delegate = self;
    myWebView.scalesPageToFit = YES;
    myWebView.dataDetectorTypes=0;
    [self.view addSubview:myWebView];
    
    [self requestXFXQ:self.xfbh];
	// Do any additional setup after loading the view.
}



- (void)segValueChanged:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self requestXFXQ:self.xfbh];
            break;
        case 1:
            [self requestDCHF:self.xfbh];
            break;
        case 2:
            [self requestBLGC:self.xfbh];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network Handler Methods

- (void)requestXFXQ:(NSString *)xfbh
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"XFXQ_DETAIL" forKey:@"service"];
    [params setObject:xfbh forKey:@"XFBH"];
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.myWebView loadRequest:request];
}

- (void)requestDCHF:(NSString *)xfbh
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"DCHF_DETAIL" forKey:@"service"];
    [params setObject:xfbh forKey:@"XFBH"];
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.myWebView loadRequest:request];
}

- (void)requestBLGC:(NSString *)xfbh
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"BLGC_DETAIL" forKey:@"service"];
    [params setObject:xfbh forKey:@"XFBH"];
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.myWebView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.myWebView.dataDetectorTypes = UIDataDetectorTypeNone;
}

@end
