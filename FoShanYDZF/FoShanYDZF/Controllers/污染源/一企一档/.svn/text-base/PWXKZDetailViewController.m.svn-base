//
//  PWXKZDetailViewController.m
//  排污许可证详细信息
//
//  Created by 曾静 on 13-11-19.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "PWXKZDetailViewController.h"
#import "ServiceUrlString.h"
#import "UITableViewCell+Custom.h"
#import "PDJsonkit.h"

@interface PWXKZDetailViewController ()
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, assign) BOOL isLoading;
@end

@implementation PWXKZDetailViewController
@synthesize webView;

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
    
    self.title = @"排污许可证信息";
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network Handler Methods

/**
 * 获取污染源企业的排污许可证的详细信息
 * 参数1:service(这里固定为WRY_PWXKZ_LINK_DETAIL)
 * 参数2:PRIMARY_KEY(污染源编号,从前面带过来的)
 */
- (void)requestData
{
    self.isLoading = YES;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"WRY_PWXKZ_LINK_DETAIL" forKey:@"service"];
    [params setObject:self.primaryKey forKey:@"PRIMARY_KEY"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    NSURL *url = [NSURL URLWithString:strUrl];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
}

@end
