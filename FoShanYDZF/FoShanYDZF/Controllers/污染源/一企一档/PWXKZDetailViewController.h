//
//  PWXKZDetailViewController.h
//  排污许可证详细信息
//
//  Created by 曾静 on 13-11-19.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface PWXKZDetailViewController : BaseViewController <UIWebViewDelegate>

@property (nonatomic,strong) NSString *link;
@property (nonatomic,strong) NSString *primaryKey;
@property (nonatomic,strong) UIWebView *webView;

@end
