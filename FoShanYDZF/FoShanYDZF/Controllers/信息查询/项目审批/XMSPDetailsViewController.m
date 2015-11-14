//
//  ExamineDetailsView.m
//  RetrieveExamine
//
//  Created by 曾静 on 11-9-16.
//  Copyright 2011 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "XMSPDetailsViewController.h"
#import "ServiceUrlString.h"

@implementation XMSPDetailsViewController
@synthesize webView,primaryKey;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    UISegmentedControl *segCtrl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"项目审批",@"试生产",@"验收", nil]];
    segCtrl.segmentedControlStyle = UISegmentedControlStyleBar;
    segCtrl.selectedSegmentIndex = 0;
    [segCtrl addTarget:self action:@selector(segValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView  = segCtrl;
    
    //默认显示项目审批
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"DETAIL_CATEGORY_CONFIG" forKey:@"service"];
    [params setObject:primaryKey forKey:@"PRIMARY_KEY"];
    [params setObject:@"xmsp/xmspDataDetail.jsp" forKey:@"LINK"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    NSURL *url = [NSURL URLWithString:strUrl];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - UIWebView Delegate Methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

#pragma mark - Event Handler Methods

-(void)segValueChanged:(id)sender
{
    UISegmentedControl *segCtrl = (UISegmentedControl*)sender;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"DETAIL_CATEGORY_CONFIG" forKey:@"service"];
    [params setObject:primaryKey forKey:@"PRIMARY_KEY"];
    if (segCtrl.selectedSegmentIndex == 0)
    {
        [params setObject:@"xmsp/xmspDataDetail.jsp" forKey:@"LINK"];
    }
    else if (segCtrl.selectedSegmentIndex == 1)
    {
        [params setObject:@"xmsp/syxDataDetail.jsp" forKey:@"LINK"];
    }
    else if (segCtrl.selectedSegmentIndex == 2)
    {
        [params setObject:@"xmsp/ysDataDetail.jsp" forKey:@"LINK"];
    }
    
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    NSURL *url = [NSURL URLWithString:strUrl];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
}

@end
