//
//  FieldInspectionVC.m
//  GMEPS_HZ
//
//  Created by zhang on 13-4-7.
//
//

#import "FieldInspectionVC.h"
#import "JCNRView.h"
#import "JCXJView.h"
#import "SystemConfigContext.h"
#import "PDJsonkit.h"
#import "ServiceUrlString.h"

@interface FieldInspectionVC ()
@property(nonatomic,retain) JCNRView *jcnrView;
@property(nonatomic,retain) JCXJView *jcxjView;

@end

@implementation FieldInspectionVC
@synthesize scrollView,jcnrView,jcxjView;

- (id)init
{
    self = [super init];
    if (self) {
        
        // Custom initialization
        
    }
    return self;
}


-(void)addAllViews{
    
    
    JCNRView *view2 =[[JCNRView alloc] init];
    self.jcnrView = view2;
    [self.scrollView addSubview:self.jcnrView ];
    
    
    JCXJView *view3 =[[JCXJView alloc] init];
     view3.frame = CGRectMake(0, 960,768 ,960 );
    [self.scrollView addSubview:view3];
    self.jcxjView = view3;

    [scrollView setContentSize:CGSizeMake(768, 2000)];

}

//根据值来显示值
-(void)displayRecordDatas:(id)object{
    NSDictionary* values = (NSDictionary*)object;
    [jcnrView loadData:values];
    [jcxjView loadData:values];
}

-(void)saveBilu:(id)sender
{
    [super saveBilu:sender];
    NSDictionary *dicData1 = [jcnrView getValueData];
    NSDictionary *dicData2 = [jcxjView getValueData];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithDictionary:dicData1];
    [dicData setValuesForKeysWithDictionary:dicData2];
    [dicData setObject:self.dwbh forKey:@"WRYBH"];
    [dicData setObject:self.wrymc forKey:@"WRYMC"];
    [self saveLocalRecord:dicData];
}

-(void)requestHistoryData{
    [super requestHistoryData];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_XCJCJL_HISTORY" forKey:@"service"];
    [params setObject:self.basebh forKey:@"BH"];
    
    
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在查询数据..." tagID:QUERY_XCJCJL_HISTORY] ;
    
}

- (void)viewDidLoad
{
     self.tableName = @"T_YDZF_XCJCJL";
    [super viewDidLoad];
        self.title = @"现场监察记录";
   
    /*
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bilu_bg.png"]];
    bgView.frame =CGRectMake(0, 0, 768, 960);
    [self.view addSubview:bgView];
    [bgView release];*/
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)];
    scrollView.delaysContentTouches = NO;
    [self.view addSubview:scrollView];
    [self addAllViews];

    
    
    
}

-(void)returnSites:(NSDictionary*)values outsideComp:(BOOL)bOut{
	if (values == nil) {
		[self.navigationController popViewControllerAnimated:YES];
	}
	else {
        if (bOut) {
            [btnTitleView setTitle:[values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.wrymc = self.title =  [values objectForKey:@"WRYMC"];
            
            self.dwbh = @"";
            jcnrView.wrymcField.text = self.wrymc;
        }
        else
        {
            self.dwbh     = [values objectForKey:@"WRYBH"];
            self.wrymc = self.title =  [values objectForKey:@"WRYMC"];
            [btnTitleView setTitle: [values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.dicWryInfo = values;
            jcnrView.wrymcField.text = self.wrymc;
            jcnrView.wrydzField.text = [values objectForKey:@"DWDZ"];
            jcnrView.fddbrField.text = [values objectForKey:@"FDDBR"];
            jcnrView.dbrlxdhField.text = [values objectForKey:@"LXDH"];
            
            
        }
        bOutSide = bOut;
        [self  queryXCZFBH];
         [super returnSites:values outsideComp:bOut];
	}
}


-(NSDictionary*)getValueData{
    //缺少天气TQ、KCDWFDMC 、DWDZ、YB、FDDBRLXDH
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithCapacity:25];
    if(self.dicWryInfo)
        [dicParams setDictionary:self.dicWryInfo];
    
    NSDictionary *dicData1 = [jcnrView getValueData];
    NSDictionary *dicData2 = [jcxjView getValueData];
    [dicParams setValuesForKeysWithDictionary:dicData1];
    [dicParams setValuesForKeysWithDictionary:dicData2];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDictionary *userInfo = [[SystemConfigContext sharedInstance] getUserInfo];
    
    [dicParams setObject:[userInfo objectForKey:@"userId"] forKey:@"CJR"];
    [dicParams setObject:[userInfo objectForKey:@"userId"] forKey:@"JCR"];
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


-(void)commitBilu:(id)sender
{
   
    
    NSDictionary *dicData = [self getValueData];

    
 
	[self commitRecordDatas:dicData];
    
}

-(NSMutableDictionary*)createBaseTableFromWryData:(NSDictionary*)value{
    NSMutableDictionary *dicParams = [super createBaseTableFromWryData:value];
    
   
    
    return dicParams;
}

//templateid:201310241102290f395a305a854ab6bcfcaa81644c53a8
//提交数据到对应的笔录表中服务名：COMMIT_BL_XCJCJL
-(void)commitRecordDatas:(NSDictionary*)value{
    
   
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"COMMIT_BL_XCJCJL" forKey:@"service"];

    [params setObject:[value JSONString] forKey:@"jsonString"];

    
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在提交笔录..." tagID:COMMIT_BL_XCJCJL];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    if (self.isHisRecord) {
        NSArray *aryChildViews1= [jcnrView subviews];
        NSArray *aryChildViews2 = [jcxjView subviews];
        NSMutableArray *ary = [NSMutableArray arrayWithArray:aryChildViews1];
        [ary addObjectsFromArray:aryChildViews2];
        for(UIView *childView in ary){
            if ([childView isKindOfClass:[UITextField class]] || [childView isKindOfClass:[UISegmentedControl class]]|| [childView isKindOfClass:[UITextView class]] || [childView isKindOfClass:[UISwitch class]]) {
                UIControl *ctrl = (UIControl*)childView;
                ctrl.userInteractionEnabled = NO;
            }
        }
    }
    [super viewDidAppear:animated];
}

-(void)processError:(NSError *)error{
    
}

-(void)processWebData:(NSData*)webData andTag:(NSInteger)tag
{
    if(tag != COMMIT_BL_XCJCJL && tag != QUERY_XCJCJL_HISTORY)
        return [super processWebData:webData andTag:tag];
    if([webData length] <=0 )
    {
        NSString *msg = @"提交笔录失败";
        [self showAlertMessage:msg];
        return;
    }
    NSString *resultJSON = [[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
    if (tag == COMMIT_BL_XCJCJL) {
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
    else if (tag == QUERY_XCJCJL_HISTORY) {
    
        NSLog(@"%@",resultJSON);
        NSDictionary *dicInfo = [resultJSON objectFromJSONString];
        if(dicInfo){
            NSArray *ary = [dicInfo objectForKey:@"data"];
            if ([ary count] > 0) {
                NSDictionary *dicRecordData = [ary objectAtIndex:0];
                [self displayRecordDatas:dicRecordData];
            }
        }
    }

}



@end
