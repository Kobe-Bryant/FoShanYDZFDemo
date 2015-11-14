//
//  DoneTaskListViewController.h
//  BoandaProject
//
//  Created by 曾静 on 13-10-25.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "CommenWordsViewController.h"
#import "PopupDateViewController.h"
#import "UITableViewCell+TaskManager.h"

@interface DoneTaskListViewController : BaseViewController <UITextFieldDelegate, WordsDelegate, PopupDateDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *taskTypeField;
@property (strong, nonatomic) IBOutlet UITextField *startDateField;
@property (strong, nonatomic) IBOutlet UITextField *endDateField;
@property (strong, nonatomic) IBOutlet UITableView *listTableView;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@end
