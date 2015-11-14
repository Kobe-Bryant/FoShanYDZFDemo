//
//  QueryWriteController.m
//  HangZhouOA
//
//  Created by chen on 11-4-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryWriteController.h"
#import <QuartzCore/QuartzCore.h>
#import "SharedInformations.h"
#import "LoginViewController.h"
#import "GUIDGenerator.h"
#import "SystemConfigContext.h"
#import "WendaDetailsViewController.h"
#import "PDJsonkit.h"
#import "ServiceUrlString.h"
#import "RecordsHelper.h"
#import "PersonChooseVC.h"
#import "RecordPrintViewController.h"

#define  T_YDZF_DCXWBL @"T_YDZF_DCXWBL"

@interface QueryWriteController()<PersonChooseResult>

@end

@implementation QueryWriteController
@synthesize wordsSelectViewController,wordsPopoverController;
@synthesize DCXWDD,GZDW,NL,JTZZ,DH,BXWRMC,SFZHM,XWKSSJ,XWJSSJ,ZW,JLR,ZFZH,SQHB,XWR;
@synthesize popController,dateController;
@synthesize quesValueAry,ansValueAry;
@synthesize CYR_ZJH,LRR_ZJH;
@synthesize surePreson;
@synthesize valuesAry,keysAry;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
        return nil;
    
    self.tableName = T_YDZF_DCXWBL;
	
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.keysAry = [[NSArray alloc] initWithObjects:@"KSSJ", @"JSSJ", @"DD", @"XWR", @"ZFZH", @"JLR", @"BXWR", @"NL", @"SFZH", @"LXDH", @"GZDW", @"ZW", @"BXWRDZ", @"HBBM", @"HBLY", nil];
    self.valuesAry = [NSArray arrayWithObjects:XWKSSJ,XWJSSJ,DCXWDD,XWR,ZFZH,JLR,BXWRMC,NL,SFZHM,DH,GZDW,ZW,JTZZ,DLRSSBM,SQHB,nil];
    //self.keysAry = [NSArray arrayWithObjects:@"DD",@"DW",@"NL",@"BXWRDZ",@"LXDH",@"BXWR",@"SFZH",@"KSSJ",@"JSSJ",@"ZY",@"XWR",@"JLR",@"ZFZH",@"HBLY",nil];
    self.title = @"询问记录";
    //当前用户是记录人
    NSDictionary *userInfo = [[SystemConfigContext sharedInstance] getUserInfo];
    JLR.text  = [userInfo objectForKey:@"uname"];
    DLRSSBM.text = [[SystemConfigContext sharedInstance] getUserBMMC];
    NSString* ZJH = [userInfo objectForKey:@"ZFZJBH"] ;
    if ([ZJH length] > 0)
    {
        ZFZH.text = ZJH;
    }
    /*CommenWordsViewController *tmpController2 = [[CommenWordsViewController alloc] initWithNibName:@"CommenWordsViewController" bundle:nil ];
     tmpController2.contentSizeForViewInPopover = CGSizeMake(180, 132);
     tmpController2.delegate = self;
     tmpController2.wordsAry = [NSArray arrayWithObjects:@"法人代表", @"受委托人", @"旁证",nil];
     
     UIPopoverController *tmppopover2 = [[UIPopoverController alloc] initWithContentViewController:tmpController2];
     self.wordsSelectViewController = tmpController2;
     self.wordsPopoverController = tmppopover2;*/
    
    //设置询问开始时间
    NSDate *time = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
	NSString *dateString = [dateFormatter stringFromDate:time];
	XWKSSJ.text = dateString;
    
    self.CYR_ZJH = @"";
    self.LRR_ZJH = @"";
}

-(void)viewDidAppear:(BOOL)animated
{
    if (self.isHisRecord)
    {
        NSArray *ary= [self.view subviews];
        for(UIView *childView in ary)
        {
            if ([childView isKindOfClass:[UITextField class]] || [childView isKindOfClass:[UISegmentedControl class]]|| [childView isKindOfClass:[UITextView class]] || [childView isKindOfClass:[UISwitch class]])
            {
                UIControl *ctrl = (UIControl*)childView;
                ctrl.userInteractionEnabled = NO;
            }
        }
        
        UIBarButtonItem *printButton = [[UIBarButtonItem alloc] initWithTitle:@"打印" style:UIBarButtonItemStyleDone target:self action:@selector(onPrintClick:)];
        self.navigationItem.rightBarButtonItem = printButton;
    }
	if (wordsPopoverController != nil)
    {
		[wordsPopoverController dismissPopoverAnimated:YES];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Event Handler Methods

-(IBAction)backgroundTap:(id)sender
{
    [SQHB resignFirstResponder];
    [BXWRMC resignFirstResponder];
    [NL resignFirstResponder];
    [ZW resignFirstResponder];
    [SFZHM resignFirstResponder];
    [JTZZ resignFirstResponder];
    //[DH resignFirstResponder];
}

-(IBAction)beginEditing:(id)sender
{
	UIControl *ctrl = (UIControl*)sender;
	CGRect rect;
	rect.origin.x = ctrl.frame.origin.x;
	rect.origin.y = ctrl.frame.origin.y;
	rect.size.width = ctrl.frame.size.width;
	rect.size.height = ctrl.frame.size.height;
	[wordsSelectViewController.tableView reloadData];
    
	[self.wordsPopoverController presentPopoverFromRect:rect
												 inView:self.view
							   permittedArrowDirections:UIPopoverArrowDirectionUp
											   animated:YES];
}

-(IBAction)NewQuestion:(id)sender
{
    WendaDetailsViewController *controller = [[WendaDetailsViewController alloc] initWithNibName:@"WendaDetailsViewController" bundle:nil];
    controller.QYMC = self.wrymc;
    controller.delegate = self;
    if([quesValueAry count] > 0)
    {
        controller.quesValueAry = quesValueAry;
        controller.ansValueAry = ansValueAry;
    }
    else
    {
        controller.quesValueAry = [NSMutableArray arrayWithCapacity:15];
        controller.ansValueAry = [NSMutableArray arrayWithCapacity:15];
    }
	[self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)touchFromDate:(id)sender
{
	UIControl *btn =(UIControl*)sender;
    PopupDateViewController *tmpdate = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDateAndTime];
	self.dateController = tmpdate;
	dateController.delegate = self;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	[popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	currentTag = btn.tag;
}

-(IBAction)choosePerson:(id)sender
{
    UIControl *btn =(UIControl*)sender;
    PersonChooseVC *controller = [[PersonChooseVC alloc] initWithStyle:UITableViewStyleGrouped];
    controller.contentSizeForViewInPopover = CGSizeMake(320, 480);
	controller.delegate = self;
    controller.multiUsers = YES;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	[self.popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row
{
	if (wordsPopoverController != nil)
    {
		[wordsPopoverController dismissPopoverAnimated:YES];
	}
}

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date
{
	[popController dismissPopoverAnimated:YES];
	if (bSaved)
    {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
		NSString *dateString = [dateFormatter stringFromDate:date];
		switch (currentTag)
        {
			case 102:
				XWKSSJ.text = dateString;
				break;
			case 2:
				XWJSSJ.text = dateString;
				break;
			default:
				break;
		}
	}
    NSLog(@"start:%@ end:%@",XWKSSJ.text,XWJSSJ.text);
    if ([XWKSSJ.text compare:XWJSSJ.text] == NSOrderedDescending)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"结束时间不能早于开始时间"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        XWJSSJ.text = @"";
    }
}

-(void)returnquesAry:(NSMutableArray*)values returnansAry:(NSMutableArray*)values1
{
	self.quesValueAry = values;
    self.ansValueAry = values1;
}

-(void)returnSites:(NSDictionary*)values outsideComp:(BOOL)bOut
{
	if (values == nil)
    {
		[self.navigationController popViewControllerAnimated:YES];
	}
	else
    {
        if (bOut)
        {
            [btnTitleView setTitle:[values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.wrymc = GZDW.text = [values objectForKey:@"WRYMC"];
            self.dwbh = @"";
            self.DCXWDD.text = @"";
        }
        else
        {
            self.wrymc =  GZDW.text = [values objectForKey:@"WRYMC"];
            self.dwbh = [values objectForKey:@"WRYBH"];
            self.DCXWDD.text = [values objectForKey:@"DWDZ"];
            [btnTitleView setTitle: [values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.dicWryInfo = values;
        }
        bOutSide = bOut;
        [self  queryXCZFBH];
        [super returnSites:values outsideComp:bOut];
	}
}

-(void)commitBilu:(id)sender
{
    NSString *message = nil;
    if([XWKSSJ.text isEqualToString:@""])
        message = @"开始时间不能为空";
    else if([XWJSSJ.text isEqualToString:@""])
        message = @"结束时间不能为空";
    else if([quesValueAry count]==0)
        message = @"问答不能为空";
    
    if (message != nil)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:message
                              delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        return ;
    }
    NSDictionary *dicData = [self getValueData];
	[self commitRecordDatas:dicData];
}

-(NSMutableDictionary*)createBaseTableFromWryData:(NSDictionary*)value
{
    NSMutableDictionary *dicParams = [super createBaseTableFromWryData:value];
    [dicParams setObject:[value objectForKey:@"KSSJ"] forKey:@"KSSJ"];
    [dicParams setObject:[value objectForKey:@"XWR"] forKey:@"JCR"];
    
    return dicParams;
}

-(void)commitRecordDatas:(NSDictionary *)value
{
    NSMutableArray *aryWD = [NSMutableArray arrayWithCapacity:3];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    NSDictionary *userInfo = [[SystemConfigContext sharedInstance] getUserInfo];
	int sizeQA = [quesValueAry count];
    for (int i=0; i< sizeQA; i++)
    {
        NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithCapacity:10];
        [dicParams setObject:[userInfo objectForKey:@"userId"] forKey:@"CJR"];
        [dicParams setObject:dateString forKey:@"CJSJ"];
        [dicParams setObject:[userInfo objectForKey:@"userId"]  forKey:@"XGR"];
        [dicParams setObject:dateString forKey:@"XGSJ"];
        [dicParams setObject:[userInfo objectForKey:@"orgid"] forKey:@"ORGID"];
        
        
        [dicParams setObject:[NSString stringWithFormat:@"%d",i] forKey:@"BH"];
        [dicParams setObject:self.basebh forKey:@"DCXWBLBH"];
        [dicParams setObject:@"T_YDZF_DCXWBL" forKey:@"BLLX"];
        [dicParams setObject:[NSString stringWithFormat:@"%d",i+1] forKey:@"PXH"];
        [dicParams setObject:[quesValueAry objectAtIndex:i] forKey:@"WT"];
        [dicParams setObject:[ansValueAry objectAtIndex:i] forKey:@"DA"];
        
        [aryWD addObject:dicParams];
    }
    
    
    NSString *jsonStr = [value JSONString];
    NSString *wdStr = [aryWD JSONString];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"COMIT_BL_DCXWBL" forKey:@"service"];
    [params setObject:jsonStr forKey:@"jsonString"];
    [params setObject:wdStr forKey:@"wdString"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在提交笔录..." tagID:COMIT_BL_DCXWBL];
    
}

-(void)saveBilu:(id)sender
{
    [super saveBilu:sender];
    
    NSDictionary *dicData = [self getValueData];
    NSMutableDictionary *dicValue = [NSMutableDictionary dictionaryWithDictionary:dicData];
    [dicValue setValue:self.xczfbh forKey:@"XCZFBH"];
    
    if(quesValueAry == nil || quesValueAry.count <= 0 || ansValueAry == nil || ansValueAry.count <= 0)
    {
        [self showAlertMessage:@"没有问答数据。"];
        return;
    }
    RecordsHelper *helper = [[RecordsHelper alloc] init];
    BOOL res = [helper saveWDRecordWT:quesValueAry andDA:ansValueAry BLBH:self.basebh];
    if(res == NO)
    {
        NSLog(@"保存询问笔录失败");
    }
    [self saveLocalRecord:dicValue];
}

- (void)loadData:(NSDictionary *)infoDic
{
    
    UITextField *tmpField;
    for (int i = 0; i < [keysAry count]; i++)
    {
        tmpField = [valuesAry objectAtIndex:i];
        if([[keysAry objectAtIndex:i] isEqualToString:@"HBLY"])
        {
            NSString *str = [infoDic objectForKey:@"HBLY"];
            if(str == nil || str.length == 0)
            {
                tmpField.text = @"听清楚了，不申请回避。";
            }
        }
        tmpField.text = [infoDic objectForKey:[keysAry objectAtIndex:i]];
    }
}

//根据值来显示值
-(void)displayRecordDatas:(id)object
{
    NSDictionary* values = (NSDictionary*)object;
    [self loadData:values];
    NSString *zfbh = [values objectForKey:@"XCZFBH"];
    if(self.isHisRecord && [zfbh length] > 0)
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
        [params setObject:@"QUERY_DCXWBL_WD_HISTORY" forKey:@"service"];
        [params setObject:self.basebh forKey:@"BH"];
        NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
        self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在查询数据..." tagID:QUERY_DCXWBL_WD_HISTORY] ;
    }
    
    if (self.displayFromLocal)
    {
        NSString *blbh = [values objectForKey:@"BH"];
        if ([blbh length] > 0)
        {
            RecordsHelper *helper = [[RecordsHelper alloc] init];
            NSArray *ary = [helper queryWDRecordByBH:blbh];
            NSMutableArray *aryWT = [NSMutableArray arrayWithCapacity:10];
            NSMutableArray *aryDA = [NSMutableArray arrayWithCapacity:10];
            for(NSDictionary *item in ary)
            {
                [aryWT addObject:[item objectForKey:@"WT"]];
                [aryDA addObject:[item objectForKey:@"DA"]];
            }
            self.ansValueAry = aryDA;
            self.quesValueAry = aryWT;
        }
    }
}

-(NSDictionary*)getValueData
{
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithCapacity:25];
    if(self.dicWryInfo)
    {
        [dicParams setDictionary:self.dicWryInfo];
    }
    UITextField *tmpField;
    for (int i = 0; i < [keysAry count]; i++)
    {
        tmpField = [valuesAry objectAtIndex:i];
        if(tmpField.text == nil || tmpField.text.length <= 0)
        {
            [dicParams setObject:@"" forKey: [keysAry objectAtIndex:i]];
        }
        else
        {
            [dicParams setObject:tmpField.text forKey: [keysAry objectAtIndex:i]];
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDictionary *userInfo = [[SystemConfigContext sharedInstance] getUserInfo];
    
    [dicParams setObject:[userInfo objectForKey:@"userId"] forKey:@"CJR"];
    [dicParams setObject:dateString forKey:@"CJSJ"];
    [dicParams setObject:[userInfo objectForKey:@"userId"]  forKey:@"XGR"];
    [dicParams setObject:dateString forKey:@"XGSJ"];
    [dicParams setObject:[userInfo objectForKey:@"orgid"] forKey:@"ORGID"];
    [dicParams setObject:@"iPad" forKey:@"ZDLX"];
    [dicParams setObject:[userInfo objectForKey:@"sjqx"] forKey:@"SJQX"];
    [dicParams setObject:dateString forKey:@"JSSJ"];
    
    [dicParams setObject:self.xczfbh forKey:@"XCZFBH"];
    [dicParams setObject:self.basebh forKey:@"BH"];
    [dicParams setObject:self.dwbh forKey:@"WRYBH"];
    [dicParams setObject:self.wrymc forKey:@"DWMC"];
    return dicParams;
}

#pragma mark -
#pragma mark textfieldDelegate delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 119 || textField.tag == 120)
    {
        return YES;
    }
    return NO;
}

// 用户输入时向上滚动视图，避免键盘遮挡输入框
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGFloat arrange = 0.0;
    if (textField.tag == 119) {
        arrange = - 20;
    }
    if (textField.tag == 120) {
        arrange = - 150;
    }
    
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height;
    CGRect rect=CGRectMake(0.0f,arrange,width,height);//上移，按实际情况设置
    self.view.frame=rect;
    [UIView commitAnimations];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 120){
        NSTimeInterval animationDuration=0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width=self.view.frame.size.width;
        float height=self.view.frame.size.height;
        CGRect rect=CGRectMake(0.0f,0.0f,width,height);
        self.view.frame=rect;
        [UIView commitAnimations];
    }
}

#pragma mark - Network Request Methods

-(void)requestHistoryData
{
    [super requestHistoryData];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_DCXWBL_HISTORY" forKey:@"service"];
    [params setObject:self.basebh forKey:@"BH"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在查询数据..." tagID:QUERY_DCXWBL_HISTORY] ;
}

-(void)processWebData:(NSData*)webData andTag:(NSInteger)tag
{
    if(tag != COMIT_BL_DCXWBL && tag != QUERY_DCXWBL_HISTORY && tag != QUERY_DCXWBL_WD_HISTORY)
        return [super processWebData:webData andTag:tag];
    if([webData length] <=0 )
    {
        NSString *msg = @"查询数据失败";
        [self showAlertMessage:msg];
        return;
    }
    NSString *resultJSON = [[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
    if (tag == COMIT_BL_DCXWBL) {
        NSRange result = [resultJSON rangeOfString:@"success"];
        
        if ( result.location!= NSNotFound) {
            
            NSDictionary *dicValue = [self getValueData];
            
            
            NSDictionary *baseTableJson = [self createBaseTableFromWryData:dicValue];
            
            [self commitBaseRecordData:baseTableJson];
            
            
            return;
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"错误"
                                  message:@"提交数据到服务器失败！"  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            [[[alert subviews] objectAtIndex:2] setBackgroundColor:[UIColor colorWithRed:0.5 green:0.0f blue:0.0f alpha:1.0f]];
            [alert show];
            
        }
    }
    else if (tag == QUERY_DCXWBL_HISTORY)
    {
        NSLog(@"%@",resultJSON);
        NSDictionary *dicInfo = [resultJSON objectFromJSONString];
        if(dicInfo)
        {
            NSArray *ary = [dicInfo objectForKey:@"data"];
            if ([ary count] > 0)
            {
                NSDictionary *dicRecordData = [ary objectAtIndex:0];
                self.xczfbh = [dicRecordData objectForKey:@"XCZFBH"];
                [self displayRecordDatas:dicRecordData];
            }
        }
    }
    else if(tag == QUERY_DCXWBL_WD_HISTORY)
    {
        NSLog(@"%@",resultJSON);
        NSDictionary *dicInfo = [resultJSON objectFromJSONString];
        if(dicInfo)
        {
            NSArray *ary = [dicInfo objectForKey:@"data"];
            if ([ary count] > 0)
            {
                self.quesValueAry = [NSMutableArray arrayWithCapacity:10];
                self.ansValueAry = [NSMutableArray arrayWithCapacity:10];
                for(NSDictionary *dicItem in ary)
                {
                    [quesValueAry addObject:[dicItem objectForKey:@"WT"]];
                    [ansValueAry addObject:[dicItem objectForKey:@"DA"]];
                }
            }
        }
    }
}

-(void)processError:(NSError *)error
{
    
}

-(void)personChoosed:(NSArray*)aryChoosed
{
    [popController dismissPopoverAnimated:YES];
    NSMutableString *strSLRName = [NSMutableString stringWithCapacity:20];
    for(NSDictionary *dicPerson in aryChoosed)
    {
        if([strSLRName length] == 0)
        {
            [strSLRName appendString:[dicPerson objectForKey:@"YHMC"]];
        }
        else
        {
            [strSLRName appendFormat:@",%@",[dicPerson objectForKey:@"YHMC"]];
        }
    }
    XWR.text = strSLRName;
}

- (void)onPrintClick:(id)sender
{
    if(sender && self.xczfbh)
    {
        RecordPrintViewController *recordPrint = [[RecordPrintViewController alloc] initWithNibName:@"RecordPrintViewController" bundle:nil];
        recordPrint.type = @"DCXWBL";
        recordPrint.glbh = self.xczfbh;
        [self.navigationController pushViewController:recordPrint animated:YES];
    }
}

@end
