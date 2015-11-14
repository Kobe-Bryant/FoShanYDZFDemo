//
//  InspectFirstView.h
//  FoShanYDZF
//
//  Created by ihumor on 13-11-18.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseInspectView.h"
#import "PersonChooseVC.h"
#import "PopupDateViewController.h"

@interface InspectFirstView : BaseInspectView <PopupDateDelegate, PersonChooseResult>

@property (nonatomic, strong) IBOutlet UITextField *wrymcField;
@property (nonatomic, strong) IBOutlet UITextField *fzrField;
@property (nonatomic, strong) IBOutlet UITextField *dzField;
@property (nonatomic, strong) IBOutlet UITextField *lxfsField;
@property (nonatomic, strong) IBOutlet UITextField *jcryField;
@property (nonatomic, strong) IBOutlet UITextField *zfzhField;
@property (nonatomic, strong) IBOutlet UISegmentedControl *scqkSeg;
@property (strong, nonatomic) IBOutlet UILabel *qtscqkLabel;
@property (nonatomic, strong) IBOutlet UITextField *qtscqkField;//生产情况其他
@property (nonatomic, strong) IBOutlet UISegmentedControl *gszzSeg;//工商执照
@property (nonatomic, strong) IBOutlet UISegmentedControl *xkgjxmqkSeg;//新扩改建情况
//环评审批
@property (strong, nonatomic) IBOutlet UISwitch *hpspSwitch;
@property (strong, nonatomic) IBOutlet UITextField *hpspwhField;
@property (strong, nonatomic) IBOutlet UITextField *hpspsjField;
@property (strong, nonatomic) IBOutlet UILabel *hpsbLabel;
//试生产批复
@property (strong, nonatomic) IBOutlet UISwitch *sscpfSwitch;
@property (strong, nonatomic) IBOutlet UITextField *sscwhField;
@property (strong, nonatomic) IBOutlet UITextField *sscpfsjField;
@property (strong, nonatomic) IBOutlet UILabel *sscpfLabel;
//环保验收
@property (strong, nonatomic) IBOutlet UISwitch *hbysSwitch;
@property (strong, nonatomic) IBOutlet UITextField *hbyswhField;
@property (strong, nonatomic) IBOutlet UITextField *hbyssjField;
@property (strong, nonatomic) IBOutlet UILabel *hbysLabel;

@property (strong, nonatomic) IBOutlet UITextField *zyscsbField;//主要生产设备

@property (strong, nonatomic) IBOutlet UISwitch *fqSwitch;
@property (strong, nonatomic) IBOutlet UISegmentedControl *fqzlsSeg;
@property (strong, nonatomic) IBOutlet UISegmentedControl *fqsfzcyxSeg;
@property (strong, nonatomic) IBOutlet UILabel *fqLabel;

@property (strong, nonatomic) IBOutlet UISwitch *fsSwitch;
@property (strong, nonatomic) IBOutlet UISegmentedControl *fszlsSeg;
@property (strong, nonatomic) IBOutlet UISegmentedControl *fssfzcyxSeg;
@property (strong, nonatomic) IBOutlet UILabel *fsLabel;

@property (strong, nonatomic) IBOutlet UISwitch *gfSwitch;
@property (strong, nonatomic) IBOutlet UISegmentedControl *gfzlsSeg;
@property (strong, nonatomic) IBOutlet UISegmentedControl *gfsfyfczSeg;
@property (strong, nonatomic) IBOutlet UILabel *gfLabel;

@property (nonatomic, strong) UIPopoverController *popController;
@property (nonatomic, strong) PopupDateViewController *dateController;
@property (nonatomic, assign) int currentTag;

- (id)init;

@end
