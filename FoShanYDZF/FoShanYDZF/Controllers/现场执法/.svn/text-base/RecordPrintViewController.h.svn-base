//
//  RecordPrintViewController.h
//  笔录打印【分两步进行，先发起请求由服务器生成pdf文件，生成完成后调用下载服务下载pdf文件】
//
//  Created by 曾静 on 13-12-4.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface RecordPrintViewController : BaseViewController<UIPrintInteractionControllerDelegate>

@property (nonatomic, strong) NSString *glbh;
@property (nonatomic, strong) NSString *type;

@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;

@end
