//
//  FieldFirstPartView.h
//  FoShanYDZF
//
//  Created by PowerData on 13-11-4.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupDateViewController.h"
#import "CommenWordsViewController.h"
#import "BaseFieldView.h"

@interface FieldFirstPartView : BaseFieldView<PopupDateDelegate>
{
    IBOutlet UITextField *bjcdwField;//被检查单位
    IBOutlet UITextField *dzField;//地址
    IBOutlet UITextField *frdbField;//法人代表
    IBOutlet UITextField *frdhField;//法人电话
    IBOutlet UISegmentedControl *zfzjSegment;//出示执法证件
    IBOutlet UISegmentedControl *gzhbSegment;//告知申请回避
    IBOutlet UISegmentedControl *jgxzSegment;//监管性质
    IBOutlet UITextField *jcsjField;
    
    IBOutlet UISegmentedControl *sfyhpspSegment;//是否有环评审批
    IBOutlet UITextField *hpspsjField;//环评审批时间
    IBOutlet UILabel *hpspsjLabel;//环评审批时间
    
    IBOutlet UITextField *zyspscsbField;//主要审批生产设备
    
    IBOutlet UISegmentedControl *sfstsysSegment;//是否三同时验收
    IBOutlet UILabel *stsyssjLabel;//三同时验收时间
    IBOutlet UITextField *stsyssjField;//三同时验收时间
    
    IBOutlet UISegmentedControl *sfzkjSegment;//是否在扩建
    IBOutlet UILabel *kjsbLabel;//扩建设备
    IBOutlet UITextField *kssbField;//扩建设备
    
    IBOutlet UITextField *scgyField;//生产工艺
    
    IBOutlet UISegmentedControl *pwxkzqkSegment1;//是否有排污许可证
    IBOutlet UILabel *pwxkzLabel;//排污许可证是否在有效期内
    IBOutlet UISegmentedControl *pwxkzqkSegment2;//排污许可证是否在有效期内
    
    IBOutlet UISegmentedControl *yjyaqkSegment;//应急预案情况
    
    IBOutlet UISegmentedControl *cjscqkSegment;//车间生产情况
    IBOutlet UILabel *cjfzcscLabel;
    IBOutlet UITextField *cjfzcscField;//车间非正常生产说明
    
    IBOutlet UISwitch *feishuiSegment;//废水类
    IBOutlet UISegmentedControl *fsyzqkSegment;//废水-运转情况
    IBOutlet UISegmentedControl *fstzjlqkSegment;//废水-台账记录情况
    IBOutlet UISegmentedControl *fspwgdbsqkSegment;//废水-排污管道标识情况
    IBOutlet UISegmentedControl *fsxgczgcSegment;//废水-悬挂操作规程
    IBOutlet UISegmentedControl *fsxgpwkbzpSegment;//废水-悬挂排污口标志牌
    
    int currentTag;
}

@property (nonatomic, strong) UITextField *bjcdwField;//被检查单位
@property (nonatomic, strong) UITextField *dzField;//地址
@property (nonatomic, strong) UITextField *frdbField;//法人代表
@property (nonatomic, strong) UITextField *frdhField;//法人电话

@property (nonatomic, strong) UIPopoverController *popController;
@property (nonatomic, strong) PopupDateViewController *dateController;
@property (nonatomic, strong) UIPopoverController *wordsPopoverController;
@property (nonatomic, strong) CommenWordsViewController* wordsSelectViewController;

-(id)init;



@end
