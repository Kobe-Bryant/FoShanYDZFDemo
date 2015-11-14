//
//  RecordPrintViewController.m
//  笔录打印
//
//  Created by 曾静 on 13-12-4.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "RecordPrintViewController.h"
#import "ServiceUrlString.h"
#import "PDJsonkit.h"
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "PDFileManager.h"

@interface RecordPrintViewController ()
@property (nonatomic, strong) ASINetworkQueue *networkQueue;
@property (nonatomic, strong) PDFileManager *defaultFileManager;
@property (nonatomic, strong) NSString *savePath;
@property (nonatomic, strong) NSData *myPDFData;
@end

@implementation RecordPrintViewController
@synthesize networkQueue, defaultFileManager;

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
    
    self.descLabel.hidden = YES;
    self.progressBar.hidden = YES;
    
    [self requestPrintData];
    
    //打印按钮
    UIBarButtonItem *printButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(onPrintClick:)];
    self.navigationItem.rightBarButtonItem = printButton;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestPrintData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params setObject:@"XCZF_DATA_PRINT" forKey:@"service"];
    [params setObject:self.glbh forKey:@"GLBH"];
    [params setObject:self.type forKey:@"TYPE"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在获取打印文稿数据……" tagID:1];
}

- (void)viewWillDisappear:(BOOL)animated
{
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    if(pic)
    {
        [pic dismissAnimated:YES];
    }
    [super viewWillDisappear:animated];
}

- (void)downPrintFile:(NSString *)attachName
{
    self.descLabel.hidden = NO;
    self.progressBar.hidden = NO;
    
    //生成下载服务地址
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"DOWN_OA_FILES" forKey:@"service"];
    [params setObject:attachName forKey:@"PATH"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    DLog(@"打印表单下载地址：%@", strUrl);
    
    //下载文件到默认文件夹
    self.defaultFileManager = [[PDFileManager alloc] init];
    NSString *docsDir = self.defaultFileManager.defaultFolderPath;
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir;
    if(![fm fileExistsAtPath:docsDir isDirectory:&isDir])
    {
        [fm createDirectoryAtPath:docsDir withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSString *path=[docsDir stringByAppendingPathComponent:attachName];
    self.savePath = path;
    //如果文件存在先删除文件
    if([fm fileExistsAtPath:path])
    {
        [fm removeItemAtPath:path error:nil];
    }
    
    //开始下载文件
    if(!networkQueue)
    {
        self.networkQueue = [[ASINetworkQueue alloc] init];
    }
    
    [networkQueue reset];// 队列清零
    [networkQueue setShowAccurateProgress:YES]; // 进度精确显示
    [networkQueue setDelegate:self]; // 设置队列的代理对象
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strUrl]];
    [request setDownloadProgressDelegate:self.progressBar];
    [request setDownloadDestinationPath:path];
    
    [request setCompletionBlock :^( void ){
        self.navigationItem.rightBarButtonItem.enabled = YES;
        // 使用 complete 块，在下载完时做一些事情
        NSString *pathExt = [path pathExtension];
        if([pathExt compare:@"pdf" options:NSCaseInsensitiveSearch] == NSOrderedSame)
        {
            self.myWebView.scalesPageToFit = YES;
            self.descLabel.hidden = YES;
            self.progressBar.hidden = YES;
            NSURL *url = [NSURL fileURLWithPath:self.savePath];
            [self.myWebView loadRequest:[NSURLRequest requestWithURL:url]];
        }
    }];
    [request setFailedBlock :^( void ){
        // 使用 failed 块，在下载失败时做一些事情
        self.myWebView.scalesPageToFit = YES;
        self.descLabel.hidden = YES;
        self.progressBar.hidden = YES;
        [self.myWebView loadHTMLString:@"下载文件失败！" baseURL:nil];
    }];
    
    [networkQueue addOperation :request];
    [networkQueue go]; // 队列任务开始
}

- (void)processWebData:(NSData *)webData andTag:(NSInteger)tag
{
    NSString *log = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    if(tag == 1)
    {
        NSDictionary *dict = [log objectFromJSONString];
        if(dict != nil)
        {
            Boolean result = [[dict objectForKey:@"result"] boolValue];
            if(result)
            {
                //获取文件名称
                NSString *attachName = [dict objectForKey:@"serverpath"];
                if(attachName == nil || attachName.length == 0)
                {
                    return;
                }
                //下载附件
                [self downPrintFile:attachName];
            }
            else
            {
                NSString *msg = [dict objectForKey:@"message"];
                [self showAlertMessage:msg];
            }
        }
    }
}

- (void)processError:(NSError *)error andTag:(NSInteger)tag
{
    [self showAlertMessage:@"获取数据出错."];
}

- (void)viewDidUnload
{
    [self setProgressBar:nil];
    [self setMyWebView:nil];
    [self setDescLabel:nil];
    [super viewDidUnload];
}

//打印
- (void)onPrintClick:(UIBarButtonItem *)sender
{
    self.myPDFData = [NSData dataWithContentsOfFile:self.savePath];
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    if(pic && [UIPrintInteractionController canPrintData:self.myPDFData])
    {
        pic.delegate = self;
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = [self.savePath lastPathComponent];
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        pic.printInfo = printInfo;
        pic.showsPageRange = YES;
        pic.printingItem = self.myPDFData;
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
        ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
            //self.myPDFData = nil;
            if (!completed && error)
            {
                NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
            }
        };
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [pic presentFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES
                        completionHandler:completionHandler];
        }
        else
        {
            [pic presentAnimated:YES completionHandler:completionHandler];
        }
    }
}


@end
