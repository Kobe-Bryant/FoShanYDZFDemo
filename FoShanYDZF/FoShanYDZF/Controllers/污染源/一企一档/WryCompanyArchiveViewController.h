//
//  WryCompanyArchiveViewController.h
//  BoandaProject
//
//  Created by 曾静 on 13-10-22.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "QQSectionHeaderView.h"

@interface WryCompanyArchiveViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource,QQSectionHeaderViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *listTableView;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *wrymc;
@property (nonatomic, copy) NSString *primaryKey;

@end
