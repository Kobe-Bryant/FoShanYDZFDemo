//
//  ZFTZRecordDetailViewController.h
//  FoShanYDZF
//
//  Created by 曾静 on 13-11-14.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface ZFTZRecordDetailViewController : BaseViewController<UIWebViewDelegate>

@property (nonatomic, copy) NSString *type;//笔录类型
@property (nonatomic, copy) NSString *bh;

@end
