//
//  WryDetailCategoryViewController.h
//  污染源目录
//
//  Created by 曾静 on 13-10-17.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "QQSectionHeaderView.h"

@interface WryDetailCategoryViewController : BaseViewController <QQSectionHeaderViewDelegate>

@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *wrymc;
@property (nonatomic, copy) NSString *primaryKey;
@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@end
