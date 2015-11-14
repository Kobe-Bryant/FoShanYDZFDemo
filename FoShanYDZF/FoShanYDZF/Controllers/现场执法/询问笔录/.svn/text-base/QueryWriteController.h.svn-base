//
//  QueryWriteController.h
//  HangZhouOA
//
//  Created by chen on 11-4-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseRecordViewController.h"
#import "PopupDateViewController.h"
#import "CommenWordsViewController.h"
#import "WebServiceHelper.h"
#import "WendaDetailsViewController.h"

@interface QueryWriteController : BaseRecordViewController<WendaDelegate,PopupDateDelegate,UITextFieldDelegate,UIAlertViewDelegate,WordsDelegate>
{
	int currentFieldTag;
    int currentTag;
    UIBarButtonItem *commitBar;
    IBOutlet UITextField *DLRSSBM; //登录人所属部门
    NSString *CYR_ZJH;//检查人证件号
    NSString *LRR_ZJH; //录入人证件号
    NSTimer *timer;
    NSTimer *timer1;
    UIAlertView *alert1;
    BOOL clear;
}

@property (nonatomic, retain) IBOutlet UITextField *XWKSSJ;//询问开始时间
@property (nonatomic, retain) IBOutlet UITextField *XWJSSJ;//询问结束时间
@property (nonatomic, retain) IBOutlet UITextField *DCXWDD;//调查询问地点
@property (nonatomic, retain) IBOutlet UITextField *XWR;   //询问人
@property (nonatomic, retain) IBOutlet UITextField *ZFZH;  //执法证号
@property (nonatomic, retain) IBOutlet UITextField *JLR;   //记录人

@property (nonatomic, retain) IBOutlet UITextField *BXWRMC;//被调查询问人
@property (nonatomic, retain) IBOutlet UITextField *GZDW;//工作单位
@property (nonatomic, retain) IBOutlet UITextField *NL;//年龄
@property (nonatomic, retain) IBOutlet UITextField *SFZHM; //身份证号码
@property (nonatomic, retain) IBOutlet UITextField *DH;//电话
@property (nonatomic, retain) IBOutlet UITextField *JTZZ;//家庭住址
@property (nonatomic, retain) IBOutlet UITextField *ZW;//职位或职业

@property (nonatomic, retain) IBOutlet UITextField *SQHB;  //申请回避

@property (nonatomic, retain) UIPopoverController *popController;
@property (nonatomic, retain) PopupDateViewController *dateController;

@property(nonatomic,retain)UIPopoverController *wordsPopoverController;
@property(nonatomic,retain)CommenWordsViewController* wordsSelectViewController;

@property(nonatomic,retain)NSMutableArray *quesValueAry;
@property(nonatomic,retain)NSMutableArray *ansValueAry;
@property(nonatomic,retain)NSMutableArray *surePreson;

@property (nonatomic, retain) NSString *CYR_ZJH;//检查人证件号
@property (nonatomic, retain) NSString *LRR_ZJH;

@property (nonatomic, strong) NSArray *valuesAry;
@property (nonatomic, strong) NSArray *keysAry;

-(IBAction)NewQuestion:(id)sender;
-(IBAction)touchFromDate:(id)sender;
-(IBAction)choosePerson:(id)sender;
-(IBAction)backgroundTap:(id)sender;

@end
