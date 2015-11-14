//
//  ToDoDetailDataModel.m
//  HNYDZF
//
//  Created by zhang on 12-12-8.
//
//

#import "ToDoActionsDataModel.h"
#import "PDJsonkit.h"
#import "NSURLConnHelper.h"
#import "ServiceUrlString.h"
#import "StepUserItem.h"

#import "FinishActionController.h"
#import "TransitionActionControllerNew.h"
#import "CounterSignActionController.h"
#import "FeedbackActionController.h"
#import "EndorseActionController.h"
#import "ReturnBackViewController.h"

#define kServiceType_XF 1
#define kServiceType_GW 2

@interface ToDoActionsDataModel()
@property(nonatomic,retain) NSURLConnHelper *webHelper;
@property(nonatomic,retain) UIView *parentView;
@property(nonatomic,retain) UIViewController* target;
@property(nonatomic,copy)NSString *resultHtml;
@property(nonatomic,copy)NSString *title;
@property (nonatomic,strong) NSString *typeStr;
@property(nonatomic,strong) NSArray *aryAttachFiles;//附件
@property (nonatomic,assign) BOOL isLoading;
@property(nonatomic,copy)NSDictionary *params;
@property (nonatomic,strong) NSDictionary *dicActionInfo;

@end

@implementation ToDoActionsDataModel
@synthesize webHelper,parentView,target,resultHtml,title,typeStr,aryAttachFiles,params,dicActionInfo,isLoading;

-(id)initWithTarget:(UIViewController*)atarget andParentView:(UIView*)inView{
    self = [super init];
    if(self){
        self.parentView = inView;
        self.target = atarget;
    }
    return self;
}



-(void)finishAction:(id)sender{
    FinishActionController *controller = [[FinishActionController alloc] initWithNibName:@"FinishActionController" bundle:nil];
    controller.bzbh = [params objectForKey:@"BZBH"];
    controller.delegate = (id<HandleGWDelegate>)self.target;
    controller.canSignature = [[dicActionInfo objectForKey:@"canSignature"] isEqualToString:@"true"];
    [target.navigationController pushViewController:controller animated:YES];
    
}

-(void)transitionAction:(id)sender{
    TransitionActionControllerNew *controller = [[TransitionActionControllerNew alloc] initWithNibName:@"TransitionActionControllerNew" bundle:nil];
    controller.bzbh = [params objectForKey:@"BZBH"];
    controller.delegate = (id<HandleGWDelegate>)self.target;
    controller.canSignature = [[dicActionInfo objectForKey:@"canSignature"] isEqualToString:@"true"];
    [target.navigationController pushViewController:controller animated:YES];
    
}

-(void)countersignAction:(id)sender{
    /*  CounterSignActionController *controller = [[CounterSignActionController alloc] initWithNibName:@"CounterSignActionController" bundle:nil];
     controller.bzbh = [params objectForKey:@"BZBH"];
     controller.canSignature = [[dicActionInfo objectForKey:@"canSignature"] isEqualToString:@"true"];
     [self.navigationController pushViewController:controller animated:YES];
     [controller release];*/
}


-(void)sendBackAction:(id)sender{
    ReturnBackViewController *controller = [[ReturnBackViewController alloc] initWithNibName:@"ReturnBackViewController" bundle:nil];
    controller.delegate = (id<HandleGWDelegate>)self.target;
    controller.bzbh = [params objectForKey:@"BZBH"];
    controller.canSignature = [[dicActionInfo objectForKey:@"canSignature"] isEqualToString:@"true"];
    [target.navigationController pushViewController:controller animated:YES];
    
}

-(void)feedbackAction:(id)sender{
    FeedbackActionController *controller = [[FeedbackActionController alloc] initWithNibName:@"FeedbackActionController" bundle:nil];
    controller.bzbh = [params objectForKey:@"BZBH"];
    controller.delegate = (id<HandleGWDelegate>)self.target;
    controller.canSignature = [[dicActionInfo objectForKey:@"canSignature"] isEqualToString:@"true"];
    [target.navigationController pushViewController:controller animated:YES];
    
}

-(void)endorseAction:(id)sender{
    EndorseActionController *controller = [[EndorseActionController alloc] initWithNibName:@"EndorseActionController" bundle:nil];
    controller.bzbh = [params objectForKey:@"BZBH"];
    controller.delegate = (id<HandleGWDelegate>)self.target;
    controller.canSignature = [[dicActionInfo objectForKey:@"canSignature"] isEqualToString:@"true"];
    [target.navigationController pushViewController:controller animated:YES];
    
}


-(void)processWebData:(NSData*)webData{
    isLoading = NO;
    if([webData length] <=0 )
        return;
    
    NSString *resultJSON = [[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
    
    self.dicActionInfo = [resultJSON objectFromJSONString];
    BOOL resultFailed = NO;
    if (dicActionInfo == nil) {
        
        resultFailed = YES;
    }
    else{
        NSString *tmp = [dicActionInfo objectForKey:@"result"];
        if(![tmp isEqualToString:@"success"])
            resultFailed = YES;
    }
    if(resultFailed){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"获取数据出错。"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 350, 44)];
    NSMutableArray *aryBarItems = [NSMutableArray arrayWithCapacity:5];
    UIBarButtonItem *flexItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [aryBarItems addObject:flexItem];
    
    NSString *isFirstStep = [dicActionInfo objectForKey:@"isFirstStep"];
    NSString *canFinish = [dicActionInfo objectForKey:@"canFinish"];
    if([canFinish isEqualToString:@"true"]){
        if(![isFirstStep isEqualToString:@"true"]){
            UIBarButtonItem *aBarItem = [[UIBarButtonItem  alloc] initWithTitle:@"   结  束   " style:UIBarButtonItemStyleBordered target:self action:@selector(finishAction:)];
            [aryBarItems addObject:aBarItem];
        }
        
        
    }
    
    NSString *canTransition = [dicActionInfo objectForKey:@"canTransition"];
    if([canTransition isEqualToString:@"true"]){
        
        UIBarButtonItem *aBarItem = [[UIBarButtonItem  alloc] initWithTitle:@"手工流转" style:UIBarButtonItemStyleBordered target:self action:@selector(transitionAction:)];
        [aryBarItems addObject:aBarItem];
        
    }
    
    NSString *canSendback = [dicActionInfo objectForKey:@"canSendback"];
    if([canSendback isEqualToString:@"true"]){
        
        UIBarButtonItem *aBarItem = [[UIBarButtonItem  alloc] initWithTitle:@"   退  回   " style:UIBarButtonItemStyleBordered target:self action:@selector(sendBackAction:)];
        [aryBarItems addObject:aBarItem];
        
    }
    
    NSString *canCountersign = [dicActionInfo objectForKey:@"canCountersign"];
    if([canCountersign isEqualToString:@"true"]){
        /*
         UIBarButtonItem *aBarItem = [[UIBarButtonItem  alloc] initWithTitle:@"   会  签   " style:UIBarButtonItemStyleBordered target:self action:@selector(countersignAction:)];
         [aryBarItems addObject:aBarItem];*/
        
    }
    
    NSString *isCanFeedback = [dicActionInfo objectForKey:@"isCanFeedback"];
    if([isCanFeedback isEqualToString:@"true"]){
        UIBarButtonItem *aBarItem = [[UIBarButtonItem  alloc] initWithTitle:@"   反  馈   " style:UIBarButtonItemStyleBordered target:self action:@selector(feedbackAction:)];
        [aryBarItems addObject:aBarItem];
        
    }
    
    NSString *isCanEndorse = [dicActionInfo objectForKey:@"isCanEndorse"];
    if([isCanEndorse isEqualToString:@"true"]){
        UIBarButtonItem *aBarItem = [[UIBarButtonItem  alloc] initWithTitle:@"   加  签   " style:UIBarButtonItemStyleBordered target:self action:@selector(endorseAction:)];
        [aryBarItems addObject:aBarItem];
        
    }
    // [aryBarItems addObject:flexItem];
    toolBar.items = aryBarItems;
    
    //[self.view addSubview:toolBar];
    target.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:toolBar];
    
    
}

-(void)processError:(NSError *)error{
    isLoading = NO;
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:@"请求数据失败."
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil];
    [alert show];
    
    return;
}


-(void)requestActionDatasByParams:(NSDictionary *)info{
    self.params = info;
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithCapacity:3];
    [dicParams setObject:@"QUERY_TASK_STATE" forKey:@"service"];
    [dicParams setObject:[params objectForKey:@"BZBH"] forKey:@"BZBH"];
    
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:dicParams];
    
    isLoading = YES;
    
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:parentView delegate:self];
}

-(void)cancelRequest{
    [webHelper cancel];
}
@end
