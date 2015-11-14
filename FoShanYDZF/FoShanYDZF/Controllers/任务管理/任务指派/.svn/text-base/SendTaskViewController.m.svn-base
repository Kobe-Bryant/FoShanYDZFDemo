//
//  SendTaskViewController.m
//  BoandaProject
//
//  Created by 张仁松 on 13-10-24.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "SendTaskViewController.h"
#import "ServiceUrlString.h"
#import "UISearchSitesController.h"
#import "PopupDateViewController.h"
#import "PersonChooseVC.h"
#import "UIAlertView+Blocks.h"
#import "RIButtonItem.h"
#import "TaskManagerViewController.h"
#import "PDJsonkit.h"

@interface SendTaskViewController ()<SelectSitesDelegate,PopupDateDelegate,PersonChooseResult>
@property(nonatomic,strong)NSString *taskType;
@property(nonatomic,strong)NSString *slrID;
@property(nonatomic,strong)NSString *wrybh;
@property(nonatomic,strong)UIPopoverController *popController;
@property(nonatomic,strong)NSArray *arySLR;//受理人
@end

@implementation SendTaskViewController
@synthesize taskType,wrybh,slrID,popController,arySLR;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"任务指派";
        self.taskType = @"43000000003";
        self.wrybh = @"";
    }
    return self;
}

-(void)returnSites:(NSDictionary*)values outsideComp:(BOOL)bOutside{
        wrymcField.text = [values objectForKey:@"WRYMC"];
        if (bOutside) {
             
            self.wrybh = @"";
        }
        else{
            self.wrybh = [values objectForKey:@"WRYBH"];
            dwdzField.text = [values objectForKey:@"DWDZ"];
            frdbdhField.text = [values objectForKey:@"LXDH"];
            frdbField.text = [values objectForKey:@"FDDBR"];
        }

   
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];
}
-(void)assignTask:(id)sender
{
    NSString *tipInfo = nil;
    if([wrymcField.text length] <= 0)
        tipInfo = @"请选择污染源";
    else if([dwdzField.text length] <= 0)
        tipInfo = @"请输入污染源地址";
    else if([slrField.text length] <= 0)
        tipInfo = @"请选择受理人";
    else if([rwqxField.text length] <= 0)
        tipInfo = @"请选择任务期限";
    if (tipInfo) {
        [self showAlertMessage:tipInfo];
        return;
    }
    NSMutableDictionary *infoParams = [NSMutableDictionary dictionaryWithCapacity:5];
    [infoParams setObject:taskType forKey:@"TASK_TYPE"];
    [infoParams setObject:wrymcField.text forKey:@"WRYMC"];
    [infoParams setObject:dwdzField.text forKey:@"DWDZ"];
    [infoParams setObject:slrField.text forKey:@"SLR"];
     [infoParams setObject:rwqxField.text forKey:@"RWQX"];
    if([frdbField.text length]>0)
        [infoParams setObject:frdbField.text forKey:@"FRDB"];
    if([frdbdhField.text length]>0)
        [infoParams setObject:frdbdhField.text forKey:@"FRDBLXDH"];
    
      //受理人用逗号分隔
    [infoParams setObject:slrID forKey:@"SLRID"];
    [infoParams setObject:wrybh forKey:@"WRYBH"];
    

     NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"ASSIGN_TASK_ACTION" forKey:@"service"];
    [params setObject:[infoParams JSONString] forKey:@"PARAM"];

    
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
 //   NSMutableString *str = [NSString stringWithFormat:@"%@&PARAM=%@",strUrl,jsonStr];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在提交笔录..." tagID:0];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [saveButton addTarget:self action:@selector(assignTask:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *commitButton = [[UIBarButtonItem alloc]initWithTitle:@"查看已指派任务" style:UIBarButtonItemStyleDone target:self action:@selector(showHistoryList:)];
    self.navigationItem.rightBarButtonItem = commitButton;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return NO;
}

-(IBAction)touchFromDate:(id)sender
{
	UIControl *btn =(UIControl*)sender;
    PopupDateViewController *dateController = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDate];
	dateController.delegate = self;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	[self.popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date
{
    [popController dismissPopoverAnimated:YES];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    rwqxField.text = dateString;
}

-(IBAction)touchFromWrymcField:(id)sender
{
    UISearchSitesController *formViewController = [[UISearchSitesController alloc] initWithNibName:@"UISearchSitesController" bundle:nil];
	[formViewController setDelegate:self];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:formViewController];
	nav.modalPresentationStyle =  UIModalPresentationFormSheet;
	[self presentModalViewController:nav animated:YES];
	nav.view.superview.frame = CGRectMake(30, 100, 700, 700);
}

- (void)showHistoryList:(id)sender
{
    TaskManagerViewController *tm = [[TaskManagerViewController alloc] initWithNibName:@"TaskManagerViewController" bundle:nil];
    [self.navigationController pushViewController:tm animated:YES];
}

-(void)personChoosed:(NSArray*)aryChoosed
{
    self.arySLR = aryChoosed;
    [popController dismissPopoverAnimated:YES];
    NSMutableString *strSLRName = [NSMutableString stringWithCapacity:20];
    NSMutableString *strSLRID = [NSMutableString stringWithCapacity:20];
    for(NSDictionary *dicPerson in arySLR)
    {
        if([strSLRName length] == 0)
        {
            [strSLRName appendString:[dicPerson objectForKey:@"YHMC"]];
            [strSLRID appendString:[dicPerson objectForKey:@"YHID"]];
        }
        else
        {
            [strSLRName appendFormat:@",%@",[dicPerson objectForKey:@"YHMC"]];
            [strSLRID appendFormat:@",%@",[dicPerson objectForKey:@"YHID"]];
        }
    }
    self.slrID = strSLRID;
    slrField.text = strSLRName;
}

-(IBAction)choosePersonField:(id)sender
{
    UIControl *btn =(UIControl*)sender;
    PersonChooseVC *controller = [[PersonChooseVC alloc] initWithStyle:UITableViewStyleGrouped];
    controller.delegate = self;
    controller.multiUsers = YES;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	[self.popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}



-(void)processError:(NSError *)error
{
    
}
 
-(void)processWebData:(NSData*)webData andTag:(NSInteger)tag
{
    if([webData length] <=0 )
    {
        NSString *msg = @"查询数据失败";
        [self showAlertMessage:msg];
        return;
    }
    
    NSString *resultJSON = [[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
    NSRange result = [resultJSON rangeOfString:@"success"];
    if(result.location!= NSNotFound)
    {
        [[[UIAlertView alloc] initWithTitle:@"提示"
                                    message:@"指派任务成功！还需要指派其它任务吗？"
                           cancelButtonItem:[RIButtonItem itemWithLabel:@"指派其它任务" action:^{
            wrymcField.text = @"";
            dwdzField.text = @"";
            frdbField.text = @"";
            frdbdhField.text = @"";
            slrField.text = @"";
            rwqxField.text = @"";
            bzField.text = @"";
            
            self.wrybh = @"";
            self.arySLR = nil;
            self.slrID = @"";
            
        }]
                           otherButtonItems:[RIButtonItem itemWithLabel:@"不指派" action:^{
            
            [self.navigationController popViewControllerAnimated:YES];
        }], nil] show];
        return;
    }
    else
    {
        NSString *msg = @"发送任务失败！";
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"错误"
                              message:msg  delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [[[alert subviews] objectAtIndex:2] setBackgroundColor:[UIColor colorWithRed:0.5 green:0.0f blue:0.0f alpha:1.0f]];
        [alert show];
        return;
    }
}

- (void)viewDidUnload {
    saveButton = nil;
    [super viewDidUnload];
}
@end
