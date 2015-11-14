//
//  PhotoProfileViewController.m
//  BoandaProject
//
//  Created by PowerData on 13-10-31.
//  Copyright (c) 2013年 szboanda. All rights reserved.
//

#import "PhotoProfileViewController.h"
#import "SystemConfigContext.h"
#import "PDJsonkit.h"
#import "ServiceUrlString.h"
#import "GUIDGenerator.h"

@interface PhotoProfileViewController ()
@property (nonatomic, strong) UIPopoverController *photoPopoverController;
@property (nonatomic, strong) ASIFormDataRequest *request;
@property (nonatomic, strong) NSDictionary *profileData;
@end

@implementation PhotoProfileViewController
@synthesize request;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"现场取证";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:self.filePath];
    self.thumbImageView.image = image;
}

- (void)viewWillDisappear:(BOOL)animated
{
    //如果不予以清除的话在iOS7里面会崩溃
    if(self.request)
    {
        [self.request cancel];
    }
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setThumbImageView:nil];
    [self setFileNameField:nil];
    [self setFileLocationField:nil];
    [self setFileDescField:nil];
    [self setProgressView:nil];
    [super viewDidUnload];
}

- (IBAction)uploadPhotoClick:(id)sender
{
   NSMutableDictionary *recordData = [[NSMutableDictionary alloc] init];

    if(self.fileNameField.text != nil && self.fileNameField.text.length > 0)
    {
        [recordData setObject:self.fileNameField.text forKey:@"FJMC"];
    }
    else
    {
        [recordData setObject:@"" forKey:@"FJMC"];
    }
    //图片拍摄地点
    if(self.fileLocationField.text != nil && self.fileLocationField.text.length > 0)
    {
        [recordData setObject:self.fileLocationField.text forKey:@"PSDD"];
    }
    else
    {
        [recordData setObject:@"" forKey:@"PSDD"];
    }
    //证据描述
    if(self.fileDescField.text != nil && self.fileDescField.text.length > 0)
    {
        [recordData setObject:self.fileDescField.text forKey:@"FJBZ"];
    }
    else
    {
        [recordData setObject:@"ipad上传" forKey:@"FJBZ"];
    }

    
    
    //提交记录表数据
    NSDictionary *userInfo = [[SystemConfigContext sharedInstance] getUserInfo];
    NSString *userId = [userInfo objectForKey:@"userId"];
    NSString *ORGID = [userInfo objectForKey:@"orgid"];
    NSString *sjqx = [userInfo objectForKey:@"sjqx"];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *now = [NSDate date];
    NSString *dateStr = [df stringFromDate:now];
    
    
    [recordData setObject:[GUIDGenerator generateGUID] forKey:@"BH"];
    [recordData setObject:self.xczfbh forKey:@"XCZFBH"];
    [recordData setObject:[userInfo objectForKey:@"uname"] forKey:@"PSR"];
    [recordData setObject:@".jpg" forKey:@"FJLX"];
    
    NSString *fileDesc = @"";
    if(self.fileDescField.text.length > 0)
    {
        fileDesc = self.fileDescField.text;
    }
    
    NSString *fileName = @"";
    if(self.fileNameField.text != nil && self.fileNameField.text.length > 0)
    {
        fileName = self.fileNameField.text;
    }
    [recordData setObject:self.filePath forKey:@"FJDZ"];
    [recordData setObject:sjqx forKey:@"SJQX"];
    [recordData setObject:userId forKey:@"CJR"];
    [recordData setObject:dateStr forKey:@"CJSJ"];
    [recordData setObject:userId forKey:@"XGR"];
    [recordData setObject:dateStr forKey:@"XGSJ"];
    [recordData setObject:ORGID forKey:@"ORGID"];
    
    NSMutableDictionary *tmpPicItem = [[NSMutableDictionary alloc] init];
    [tmpPicItem setObject:@"" forKey:@"FILE_CODE"];
    [tmpPicItem setObject:fileName forKey:@"FILE_NAME"];
    [tmpPicItem setObject:[recordData objectForKey:@"CJR"] forKey:@"FILE_Author"];
    [tmpPicItem setObject:[recordData objectForKey:@"CJSJ"] forKey:@"FILE_Date"];
    [tmpPicItem setObject:fileDesc forKey:@"FILE_DESC"];
    [tmpPicItem setObject:[self.filePath lastPathComponent] forKey:@"FILE_PATH"];
    [tmpPicItem setObject:self.filePath forKey:@"FILE_LOCAL_PATH"];
    [tmpPicItem setObject:@"1" forKey:@"FILE_EXIST"];
    self.profileData = tmpPicItem;
    
    [self commitFile:recordData];
}


//上传文件
-(void)commitFile:(NSDictionary *)value
{
    self.progressView.hidden = NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //上传文件的地址
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"UPLOAD_FILE" forKey:@"service"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    NSURL *url =[NSURL URLWithString :strUrl];
    //设置POST HEADER FIELDS
    NSString *jsonStr = [value JSONString];
    self.request = [ASIFormDataRequest requestWithURL:url];
    [self.request setPostValue:jsonStr forKey:@"FILE_FIELDS"];
    SystemConfigContext *context = [SystemConfigContext sharedInstance];
    NSDictionary *loginUsr = [context getUserInfo];
    NSString *userId = [loginUsr objectForKey:@"userId"];
    NSString *password = [loginUsr objectForKey:@"password"];
    [request addPostValue :userId forKey :@"userid"];
    [request addPostValue :password forKey :@"password"];
    [request addPostValue :[context getDeviceID] forKey :@"imei"];
    [request addPostValue :[context getAppVersion] forKey :@"version"];
    [request addPostValue :@"UPLOAD_FILE" forKey :@"service"];
    [request setFile:self.filePath withFileName:[self.filePath lastPathComponent] andContentType:@"application/octet-stream" forKey: [self.filePath lastPathComponent]];
    //[self.request setFile:self.filePath forKey :@"FJDZ"];
    [self.request setDelegate:self ];
    [self.request setUploadProgressDelegate:self.progressView];
    [self.request setDidFinishSelector:@selector(responseComplete)];
    [self.request setDidFailSelector:@selector(responseFailed)];
    [self.request startAsynchronous];
}

-( void )responseComplete
{
    NSString *str = self.request.responseString;
    self.progressView.hidden = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSDictionary *dic = [str objectFromJSONString];
    if( dic && [[dic objectForKey:@"result"] boolValue])
    {
        [self.delegate uploadWithStatus:YES andWithInfo:self.profileData];
        [self showAlertMessage:@"文件上传成功!"];
    }
    else
    {
        [self.delegate uploadWithStatus:NO andWithInfo:self.profileData];
        [self showAlertMessage:@"上传失败!"];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView.message isEqualToString:@"文件上传成功!"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-( void )respnoseFailed
{
    self.progressView.hidden = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self showAlertMessage:@"上传失败!"];
}

@end
