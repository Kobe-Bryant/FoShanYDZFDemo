//
//  ZFTZHJXFDetailViewController.h
//  FoShanYDZF
//
//  Created by 曾静 on 13-11-18.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface ZFTZHJXFDetailViewController : BaseViewController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *myWebView;
@property (nonatomic, strong) NSString *xfbh;

@end
