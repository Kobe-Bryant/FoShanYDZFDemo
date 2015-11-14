//
//  SiteInforcementConroller.m
//  EPad
//
//  Created by chen on 11-4-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SiteInforcementConroller.h"
#import "LoginViewController.h"
#import "UISearchSitesController.h"
#import "GUIDGenerator.h"
#import "SharedInformations.h"
#import <QuartzCore/QuartzCore.h>
#import "PDJsonkit.h"
#import "SystemConfigContext.h"
#import "ServiceUrlString.h"
#import "UISelectPersonVC.h"
#import "RecordPrintViewController.h"

@implementation SiteInforcementConroller
@synthesize XCFZR,NL,SFZHM,GZDW,ZW,JTZZ,ZFZH,QRSF,SQHB,XCQK,ZFRY,KYKSSJ,KYJSSJ,KYDD,KCDWFDMC,FDDBR,DH;
@synthesize popController;
@synthesize JCR,JLR,HBBM;

#define T_YDZF_XCKCBL @"T_YDZF_XCKCBL"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
        return nil;
    self.tableName = T_YDZF_XCKCBL;
    return self;
}

- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row
{
	
	
	if (popController != nil) {
		[popController dismissPopoverAnimated:YES];
	}
}

- (NSString *)getTextFieldData:(UITextField *)textField
{
    NSString *str = @"";
    if(textField.text != nil && textField.text.length > 0)
    {
        str = textField.text;
    }
    return str;
}

- (NSString *)getTextViewData:(UITextView *)textField
{
    NSString *str = @"";
    if(textField.text != nil && textField.text.length > 0)
    {
        str = textField.text;
    }
    return str;
}

-(NSDictionary*)getValueData
{
    //缺少天气TQ、KCDWFDMC 、DWDZ、YB、FDDBRLXDH
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithCapacity:25];
    if(self.dicWryInfo)
        [dicParams setDictionary:self.dicWryInfo];
    [dicParams setObject:self.wrymc forKey:@"WRYMC"];
    [dicParams setObject:[self getTextFieldData:KCDWFDMC] forKey:@"KCDWFDMC"];
    [dicParams setObject:[self getTextFieldData:KYKSSJ] forKey:@"KCKSSJ"];
    [dicParams setObject:[self getTextFieldData:KYJSSJ] forKey:@"KCJSSJ"];
    [dicParams setObject:[self getTextFieldData:KYDD] forKey:@"KCDD"];
    
    [dicParams setObject:[self getTextFieldData:NL] forKey:@"NL"];
    [dicParams setObject:[self getTextFieldData:JTZZ] forKey:@"DWDZ"];
    [dicParams setObject:[self getTextFieldData:XCFZR] forKey:@"XCFZR"];
    [dicParams setObject:[self getTextFieldData:SFZHM] forKey:@"GMSHHM"];
    [dicParams setObject:[self getTextFieldData:GZDW] forKey:@"GZDW"];
    [dicParams setObject:[self getTextFieldData:ZW] forKey:@"ZW"];
    //工作单位及职务
    [dicParams setObject:[self getTextFieldData:DH] forKey:@"XCFZRLXDH"];
    [dicParams setObject:[self getTextFieldData:JCR] forKey:@"JCR"];
    [dicParams setObject:[self getTextFieldData:JLR] forKey:@"JLR"];
    [dicParams setObject:[self getTextFieldData:HBBM] forKey:@"HBBM"];
    [dicParams setObject:[self getTextFieldData:ZFRY] forKey:@"ZFRXM"];
    [dicParams setObject:[self getTextFieldData:ZFZH] forKey:@"ZFZH"];
    //疑义理由、申请回避
    [dicParams setObject:[self getTextFieldData:QRSF] forKey:@"YYLY"];
    [dicParams setObject:[self getTextFieldData:SQHB] forKey:@"HBLY"];
    [dicParams setObject:[self getTextViewData:XCQK] forKey:@"XCQK"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDictionary *userInfo = [[SystemConfigContext sharedInstance] getUserInfo];
    
    [dicParams setObject:[userInfo objectForKey:@"userId"] forKey:@"CJR"];
    [dicParams setObject:dateString forKey:@"CJSJ"];
    [dicParams setObject:[userInfo objectForKey:@"userId"]  forKey:@"XGR"];
    [dicParams setObject:dateString forKey:@"XGSJ"];
    [dicParams setObject:[userInfo objectForKey:@"orgid"] forKey:@"ORGID"];
    [dicParams setObject:@"手机" forKey:@"ZDLX"];
    [dicParams setObject:[userInfo objectForKey:@"sjqx"] forKey:@"SJQX"];
    [dicParams setObject:dateString forKey:@"JSSJ"];
    
    [dicParams setObject:self.xczfbh forKey:@"XCZFBH"];
    [dicParams setObject:self.basebh forKey:@"BH"];
    [dicParams setObject:self.dwbh forKey:@"WRYBH"];
    
    return dicParams;
}

-(void)saveBilu:(id)sender
{
    [super saveBilu:sender];
    NSDictionary *dicData = [self getValueData];
    NSMutableDictionary *dicValue = [NSMutableDictionary dictionaryWithDictionary:dicData];
    [dicValue setValue:self.xczfbh forKey:@"XCZFBH"];
    [self saveLocalRecord:dicValue];
    
}

-(void)commitBilu:(id)sender
{
    
    NSString *message = nil;
    if([KYKSSJ.text isEqualToString:@""])
        message = @"开始时间不能为空";
    else if([KYJSSJ.text isEqualToString:@""])
        message = @"结束时间不能为空";
    
    
    if (message != nil) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:message
                              delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        return ;
    }
    
    NSDictionary *dicValue = [self getValueData];
    
	[self commitRecordDatas:dicValue];
    
}

-(NSMutableDictionary*)createBaseTableFromWryData:(NSDictionary*)value
{
    NSMutableDictionary *dicParams = [super createBaseTableFromWryData:value];
    [dicParams setObject:[value objectForKey:@"KCKSSJ"] forKey:@"KSSJ"];
    
    [dicParams setObject:[value objectForKey:@"JCR"]    forKey:@"JCR"];
    
    return dicParams;
}

//提交数据到对应的笔录表中
-(void)commitRecordDatas:(NSDictionary*)value
{
    NSArray *jsonKeyAry = [[NSArray alloc] initWithObjects:@"BH",@"WRYBH",@"WRYMC",@"XCZFBH",@"KCKSSJ",@"KCJSSJ",@"KCDD",@"TQ",@"KCDWFDMC",@"DWDZ",@"YB",@"FDDBR",@"FDDBRLXDH",@"XCFZR",@"GMSHHM",@"GZDWJZW",@"XCFZRLXDH",@"JCR",@"JLR",@"QTCJRXX",@"HBBM",@"ZFRXM",@"ZFZH",@"ZJYY",@"YYLY",@"SQHB",@"HBLY",@"XCQK",@"SYYJ",@"BLLX",@"BZ",@"SJQX",@"CJR",@"CJSJ",@"XGR",@"XGSJ",@"ORGID",@"YBAGX",@"GZDW",@"ZW",@"NL", nil];
    NSMutableDictionary *jsonValueDict = [[NSMutableDictionary alloc] init];
    for(NSString *key in  jsonKeyAry)
    {
        NSString *jv = @"";
        if([value objectForKey:key] != nil)
        {
            jv = [value objectForKey:key];
        }
        [jsonValueDict setObject:jv forKey:key];
    }
    NSString *jsonStr = [jsonValueDict JSONString];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"COMIT_BL_XCKCBL" forKey:@"service"];
    [params setObject:jsonStr forKey:@"jsonString"];
    
    
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在提交笔录..." tagID:COMIT_BL_XCKCBL];
}

-(void)displayRecordDatas:(NSDictionary*)valueDatas
{
    ZFRY.text = [valueDatas objectForKey:@"ZFRXM"];
    ZFZH.text = [valueDatas objectForKey:@"ZFZH"];
    QRSF.text = [valueDatas objectForKey:@"YYLY"];
    SQHB.text = [valueDatas objectForKey:@"HBLY"];
    XCQK.text = [valueDatas objectForKey:@"XCQK"];
    
    KYKSSJ.text = [valueDatas objectForKey:@"KCKSSJ"];
    KYJSSJ.text = [valueDatas objectForKey:@"KCJSSJ"];
    KYDD.text = [valueDatas objectForKey:@"KCDD"];
    
    XCFZR.text = [valueDatas objectForKey:@"XCFZR"];
    NL.text = [valueDatas objectForKey:@"NL"];
    ZW.text = [valueDatas objectForKey:@"ZW"];
    
    SFZHM.text = [valueDatas objectForKey:@"GMSHHM"];
    
    GZDW.text = [valueDatas objectForKey:@"GZDW"];
    JTZZ.text = [valueDatas objectForKey:@"DWDZ"];
    //DH.text = [valueDatas objectForKey:@"XCFZRLXDH"];
    
    KCDWFDMC.text = [valueDatas objectForKey:@"KCDWFDMC"];
    FDDBR.text = [valueDatas objectForKey:@"FDDBR"];
    JCR.text = [valueDatas objectForKey:@"JCR"];
    JLR.text = [valueDatas objectForKey:@"JLR"];
    HBBM.text = [valueDatas objectForKey:@"HBBM"];
    
    self.CSZFZH.text = [NSString stringWithFormat:@"%@,%@", [valueDatas objectForKey:@"ZFZH"], @""];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"现场勘验记录";
    
    //bCommited = NO;
    
    XCQK.layer.borderColor = UIColor.grayColor.CGColor;  //textview边框颜色
    XCQK.layer.borderWidth = 2;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *current = [NSDate date];
    NSString *currentStr = [dateFormatter stringFromDate:current];
    
    KYKSSJ.text = currentStr;
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
    else
    {
        [XCFZR resignFirstResponder];
        if(wordsPopoverController != nil)
        {
            [wordsPopoverController dismissPopoverAnimated:YES];
        }
    }
}

- (void)viewDidUnload
{
    [self setCSZFZH:nil];
    [super viewDidUnload];
}

-(void)viewWillDisappear:(BOOL)animated
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - PopupDateController Delegate Method

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date
{
    [popController dismissPopoverAnimated:YES];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    switch (currentTag)
    {
        case 101:
            KYKSSJ.text = dateString;
            break;
        case 102:
            KYJSSJ.text = dateString;
            break;
        default:
            break;
    }
    
    
    NSLog(@"start:%@ end:%@",KYKSSJ.text,KYJSSJ.text);
    if ([KYKSSJ.text compare:KYJSSJ.text] == NSOrderedDescending)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"结束时间不能早于开始时间"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        KYJSSJ.text= @"";
        
    }
}

#pragma mark - 选择污染源后返回数据处理

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
            self.wrymc = self.title =  self.GZDW.text = [values objectForKey:@"WRYMC"];
            self.dwbh = @"";
        }
        else
        {
            self.dwbh = [values objectForKey:@"WRYBH"];
            self.wrymc = self.title =  GZDW.text = [values objectForKey:@"WRYMC"];
            KCDWFDMC.text = self.wrymc;
            KYDD.text = [values objectForKey:@"DWDZ"] ;
            FDDBR.text =  [values objectForKey:@"FDDBR"];
            XCFZR.text = [values objectForKey:@"XCFZR"];
            //DH.text = [values objectForKey:@"XCFZRLXDH"];
            
            [btnTitleView setTitle: [values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.dicWryInfo = values;
            
            NSDictionary *userInfo = [[SystemConfigContext sharedInstance] getUserInfo];
            
            JLR.text = [userInfo objectForKey:@"uname"];
        }
        bOutSide = bOut;
        [self  queryXCZFBH];
        [super returnSites:values outsideComp:bOut];
	}
}

#pragma mark - UITextField Delegate Methods

//对应的UITextview控件设置delegate就会响应此函数
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
	NSTimeInterval animationDuration=0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	float width=self.view.frame.size.width;
	float height=self.view.frame.size.height;
	CGRect rect=CGRectMake(0.0f,-240,width,height);//上移，按实际情况设置
	self.view.frame=rect;
	[UIView commitAnimations];
	return ;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	NSTimeInterval animationDuration=0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	float width=self.view.frame.size.width;
	float height=self.view.frame.size.height;
	CGRect rect=CGRectMake(0.0f,0.0f,width,height);
	self.view.frame=rect;
	[UIView commitAnimations];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return NO;
}

-(void)xczfbhHasGenerated
{
    
}

#pragma mark - PersonChooseResult Delegate Method

//选择现场检查人后处理
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
    JCR.text = strSLRName;
    ZFRY.text = [NSString stringWithFormat:@"%@,%@",strSLRName,JLR.text];
    ZFZH.text = @"";//执法证号
}

#pragma mark - Event Handler Methods

//选择检查人
-(IBAction)choosePerson:(id)sender
{
    //隐藏键盘
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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

-(IBAction)beginEditing:(id)sender
{
	UIControl *ctrl = (UIControl*)sender;
	CGRect rect;
	rect.origin.x = ctrl.frame.origin.x;
	rect.origin.y = ctrl.frame.origin.y;
	rect.size.width = ctrl.frame.size.width;
	rect.size.height = ctrl.frame.size.height;
	
    
    CommenWordsViewController *tmpController2 = [[CommenWordsViewController alloc] initWithNibName:@"CommenWordsViewController" bundle:nil ];
	tmpController2.contentSizeForViewInPopover = CGSizeMake(320, 132);
	tmpController2.delegate = self;
	tmpController2.wordsAry = [NSArray arrayWithObjects:@"法人代表",@"受委托人",
                               @"旁证",nil];
    
    UIPopoverController *tmppopover2 = [[UIPopoverController alloc] initWithContentViewController:tmpController2];
    
    self.popController = tmppopover2;
	[self.popController presentPopoverFromRect:rect
                                        inView:self.view
                      permittedArrowDirections:UIPopoverArrowDirectionUp
                                      animated:YES];
}

//选择时间
-(IBAction)touchFromDate:(id)sender
{
    //隐藏键盘
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
	UIControl *btn =(UIControl*)sender;
    
    PopupDateViewController *dateController = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDateAndTime];
    
	dateController.delegate = self;
	
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
	
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
    
	[self.popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	currentTag = btn.tag;
}

#pragma mark - NetWork Handler Methods

//请求现场勘查笔录历史数据
-(void)requestHistoryData
{
    [super requestHistoryData];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_XCKCBL_HISTORY" forKey:@"service"];
    [params setObject:self.basebh forKey:@"BH"];
    
    
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在查询数据..." tagID:QUERY_XCKCBL_HISTORY] ;
}

-(void)processError:(NSError *)error
{
    
}

-(void)processWebData:(NSData*)webData andTag:(NSInteger)tag
{
    if(tag != COMIT_BL_XCKCBL && tag != QUERY_XCKCBL_HISTORY)
        return [super processWebData:webData andTag:tag];
    if([webData length] <=0 )
    {
        NSString *msg = @"查询数据失败";
        [self showAlertMessage:msg];
        return;
    }
    NSString *resultJSON = [[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
    if (tag == COMIT_BL_XCKCBL) {
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
    else if (tag == QUERY_XCKCBL_HISTORY)
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
}

- (void)onPrintClick:(id)sender
{
    if(sender && self.xczfbh)
    {
        RecordPrintViewController *recordPrint = [[RecordPrintViewController alloc] initWithNibName:@"RecordPrintViewController" bundle:nil];
        recordPrint.type = @"XCKCBL";
        recordPrint.glbh = self.xczfbh;
        [self.navigationController pushViewController:recordPrint animated:YES];
    }
}

@end
