//
//  WryCompanyInfoViewController.h
//  企业基本概况
//
//  Created by 曾静 on 13-10-22.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WryCompanyInfoViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *detailTableView;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *wrymc;
@property (nonatomic, copy) NSString *primaryKey;

@end
