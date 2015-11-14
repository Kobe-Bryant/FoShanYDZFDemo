//
//  MainMenuViewController.m
//  BoandaProject
//
//  Created by 张仁松 on 13-7-2.
//  Copyright (c) 2013年 szboanda. All rights reserved.
//

#import "MainMenuViewController.h"
#import "SystemConfigContext.h"
#import "MenuPageView.h"
#import "MenuControl.h"
#import "PDJsonkit.h"
#import "NSAppUpdateManager.h"
#import "NSExceptionSender.h"
#import "DataSyncManager.h"
#import "ServiceUrlString.h"
#import "LocationManager.h"
#import "MenuHelper.h"
#import "MenuSyncManager.h"
#import "UIAlertView+Blocks.h"
#import "RIButtonItem.h"
#import "InnerSafeHelper.h"
#import "InnerSafeActionManager.h"

@interface MainMenuViewController ()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)NSAppUpdateManager *updater;
@property(nonatomic,strong)NSExceptionSender *exceptionSender;
@property(nonatomic,strong)DataSyncManager *syncManager;
@property(nonatomic,strong)NSMutableArray *pageViewAry;
@property(nonatomic,strong)NSURLConnHelper *webHelperYuan;
@property(nonatomic,strong)MenuSyncManager *menuSyncManager;
@property(nonatomic,strong)MBProgressHUD *HUD;
@end

@implementation MainMenuViewController
@synthesize scrollView,pageControl,updater,exceptionSender,dicBadgeInfo,syncManager,pageViewAry,webHelperYuan,menuSyncManager,HUD;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void)toggleMenuControl:(id)sender
{
    MenuControl *ctrl  = (MenuControl*)sender;
    NSDictionary *menuItemInfo = ctrl.menuInfo;
    
    NSString *classStr = [menuItemInfo objectForKey:@"ViewController"];
    if([classStr length] > 0)
    {
        NSString *nibName = [menuItemInfo objectForKey:@"NibName"];
        UIViewController *controller = nil;
        if([nibName length] > 0)
        {
            controller = (UIViewController*)[[NSClassFromString(classStr) alloc] initWithNibName:nibName bundle:nil];
        }
        else
        {
            controller = (UIViewController*)[[NSClassFromString(classStr) alloc] init];
        }
        if(controller)
        {
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
   /*
    NSString *classStr = [menuItemInfo objectForKey:@"LJDZ"];
    if([classStr length] > 0){
      //  NSString *nibName = [menuItemInfo objectForKey:@"NibName"];
        UIViewController *controller = nil;
        if([nibName length] > 0){
            controller = (UIViewController*)[[NSClassFromString(classStr) alloc] initWithNibName:nibName bundle:nil];


        }else{
            controller = (UIViewController*)[[NSClassFromString(classStr) alloc] init];
            
        }
        if(controller)
            [self.navigationController pushViewController:controller animated:YES];
    }
    
    //临时测试使用
     NSArray *menuConfigs = [[SystemConfigContext sharedInstance] getMenuConfigs];
    NSString *name = [menuItemInfo objectForKey:@"CDMC"];
    UIViewController *controller = nil;
    for(NSDictionary *dicItem in menuConfigs){
        if([[dicItem objectForKey:@"MenuTitle"] isEqualToString:name]){
            NSString *nibName = [dicItem objectForKey:@"NibName"];
            NSString *classStr = [dicItem objectForKey:@"ViewController"];
            if([nibName length] > 0){
                controller = (UIViewController*)[[NSClassFromString(classStr) alloc] initWithNibName:nibName bundle:nil];
                
                
            }else{
                controller = (UIViewController*)[[NSClassFromString(classStr) alloc] init];
                
            }
            break;
        }
    }

    if(controller)
        [self.navigationController pushViewController:controller animated:YES];*/
}

- (void)handleLongPress:(NSDictionary*)menuInfo andPageIndex:(NSNumber*)pageIndex
{
    /*
    NSString *menuName = [menuInfo objectForKey:@"CDMC"];
    if([pageIndex integerValue] == 0){//长按我的桌面上的菜单
        
        
        [[[UIAlertView alloc] initWithTitle:@"添加菜单至我的桌面" 
                                    message:[NSString stringWithFormat:@"您确定要将菜单‘%@’从我的桌面页面移除吗？",menuName]
                           cancelButtonItem:[RIButtonItem itemWithLabel:@"确定" action:^{
            MenuHelper *helper = [[MenuHelper alloc] init];
            [helper removeOneDeskMenu:menuInfo];
            [self refreshMenuViews];
        }]
                           otherButtonItems:[RIButtonItem itemWithLabel:@"取消" action:^{
           
            
        }], nil] show];
        
   
        
    }else{
        
        [[[UIAlertView alloc] initWithTitle:@"添加菜单至我的桌面"
                                    message:[NSString stringWithFormat:@"您确定要将菜单‘%@’添加到我的桌面页面吗？",menuName]
                           cancelButtonItem:[RIButtonItem itemWithLabel:@"确定" action:^{
            MenuHelper *helper = [[MenuHelper alloc] init];
            [helper addMenuItemToDesk:menuInfo];
            [self refreshMenuViews];
        }]
                           otherButtonItems:[RIButtonItem itemWithLabel:@"取消" action:^{
            
        }], nil] show];
        
    }
    */
}

-(void)refreshMenuViews
{
    for(UIView *pageView in pageViewAry)
    {
        [pageView removeFromSuperview];
    }
    [pageControl removeFromSuperview];
    [self addMenuViews];
}

-(void)addMenuViews
{
   /* self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(284, 935, 200, 36)];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    
    //  NSArray *menuConfigs = [[SystemConfigContext sharedInstance] getMenuConfigs];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:KUserName];
    
    MenuHelper *menuhelper =[[MenuHelper alloc] init];
    NSArray *menuConfigs =  [menuhelper getMenuConfig:userID];
    //添加我的桌面
    NSDictionary* dicMyDesktop = [menuhelper getDesktopMenus:userID];
    int menuIndex = 0;
    self.pageViewAry = [NSMutableArray arrayWithCapacity:5];
    
    MenuPageView *pageViewDesk = [[MenuPageView alloc] initWithFrame:CGRectMake(menuIndex*768, 0, 768, 850) andMenuPageInfo:dicMyDesktop andTarget:self andAction:@selector(toggleMenuControl:)];
    pageViewDesk.tag = menuIndex;
    [scrollView addSubview:pageViewDesk];
    [pageViewAry addObject:pageViewDesk];
    
    
    menuIndex++;
    
    for(NSDictionary *menuPage in menuConfigs){
        MenuPageView *pageView = [[MenuPageView alloc] initWithFrame:CGRectMake(menuIndex*768, 0, 768, 850) andMenuPageInfo:menuPage andTarget:self andAction:@selector(toggleMenuControl:)];
        pageView.tag = menuIndex;
        [scrollView addSubview:pageView];
        
        [pageViewAry addObject:pageView];
        menuIndex++;
    }
    if(menuIndex <=1)pageControl.hidden = YES;
    self.pageControl.numberOfPages = menuIndex;
	[scrollView setContentSize:CGSizeMake(menuIndex*768, 850)];*/
    
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(284, 935, 200, 36)];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    
    NSArray *menuConfigs = [[SystemConfigContext sharedInstance] getMenuConfigs];
    int menuIndex = 0;
    self.pageViewAry = [NSMutableArray arrayWithCapacity:5];
    for(NSDictionary *menuPage in menuConfigs)
    {
        MenuPageView *pageView = [[MenuPageView alloc] initWithFrame:CGRectMake(menuIndex*768, 0, 768, 850) andMenuPageInfo:menuPage andTarget:self andAction:@selector(toggleMenuControl:)];
        [scrollView addSubview:pageView];
        [pageViewAry addObject:pageView];
        menuIndex++;
    }
    if(menuIndex <=1)pageControl.hidden = YES;
    self.pageControl.numberOfPages = menuIndex;
	[scrollView setContentSize:CGSizeMake(menuIndex*768, 850)];
}

-(void)addUIViews
{
    UIImageView *bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuBg.png"]];
    bgImgView.frame = CGRectMake(0, 0, 768, 1004);
    [self.view addSubview:bgImgView];
    
    UIImageView *toplogoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_bar"]];
    toplogoImgView.frame = CGRectMake(0, 0, 768, 98);
    [self.view addSubview:toplogoImgView];
    
    UIImageView *logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_logo"]];
    logoImgView.frame = CGRectMake(220, 0, 374, 75);
    [self.view addSubview:logoImgView];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, 768, 850)];
    scrollView.delegate = self;
	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;
	scrollView.scrollEnabled = YES;
	scrollView.pagingEnabled = YES;
	scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 971, 156, 21)];
    versionLabel.backgroundColor = [UIColor clearColor];
    versionLabel.textColor = [UIColor whiteColor];
    versionLabel.text = [NSString stringWithFormat:@"当前版本：%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]] ;
    [self.view addSubview:versionLabel];
    
    UIButton *arcMenuBtn = [[UIButton alloc] initWithFrame:CGRectMake(716, 959, 52, 45)];
    [arcMenuBtn setImage:[UIImage imageNamed:@"arcmenu.png"] forState:UIControlStateNormal];
    [arcMenuBtn addTarget:self action:@selector(arcMenuPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:arcMenuBtn];
}

-(void)showBageIcons
{
    NSArray *aryKeys = [dicBadgeInfo allKeys];
    if([aryKeys count] <= 0)return;
    for(MenuPageView *aPageView in pageViewAry){
        NSArray *allChildViews = [aPageView subviews];
        for(UIView *aView in allChildViews){
            
            if([aView isKindOfClass:[MenuControl class]]){
                MenuControl* ctrl =  (MenuControl*)aView;
                NSDictionary *menuInfo = [ctrl menuInfo];
                NSString *title = [menuInfo objectForKey:@"MenuTitle"];
                if([aryKeys containsObject:title]){
                    
                    [ctrl showIconBadge:[dicBadgeInfo objectForKey:title]];
                }
            }
        }
    }
    
}

-(void)requestSysDatas
{
    //程序版本检查
    self.updater = [[NSAppUpdateManager alloc] init];
    [updater checkAndUpdate:Update_Check_URL];
    
    //发送错误报告
    //self.exceptionSender = [[NSExceptionSender alloc] init];
    //[exceptionSender sendExceptions];
    
    //显示待办个数
    [self showBageIcons];
    
    self.syncManager = [[DataSyncManager alloc] init];
    NSString *settingVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *saveVersion =[[NSUserDefaults standardUserDefaults] stringForKey:kLastVersion];
    //如果发布了新版本 那么就要同步所有数据
    if([saveVersion isEqualToString:settingVer]){
        [syncManager syncAllTables:NO];
    }else{
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        
        HUD.labelText = @"正在同步数据，请稍候...";
        [HUD show:YES];
        [syncManager syncAllTables:YES];
        [[NSUserDefaults standardUserDefaults] setObject:settingVer forKey:kLastVersion];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataSyncFinished:) name:kNotifyDataSyncFininshed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataSyncFailed:) name:kNotifyDataSyncFailed object:nil];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addUIViews];
    
    /*MenuHelper *menuhelper =[[MenuHelper alloc] init];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:KUserName];
    NSArray *menuConfigs =  [menuhelper getMenuConfig:userID];
    //还没有该用户的菜单相关信息
    if([menuConfigs count] <= 0){
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        
        HUD.labelText = @"正在同步菜单信息，请稍候...";
        [HUD show:YES];
        
        self.menuSyncManager = [[MenuSyncManager alloc] init];
        [menuSyncManager syncMenus];    1
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuSyncFinished:) name:kMenuSyncFinished object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuSyncFailed:) name:kMenuSyncFailed object:nil];
        
    }else{
        
         [self addMenuViews];
        [self requestSysDatas];
    }*/
    [self addMenuViews];
    [self requestSysDatas];
    
    //LocationManager *lm = [[LocationManager alloc] init];
    //[lm scheduledLocationWithTimeInterval:1];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [webHelperYuan cancel];

}

//更新button上的数字
-(void)updateBadges
{
    self.dicBadgeInfo = nil;
    /*
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_INDEX" forKey:@"service"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelperYuan = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:nil delegate:self tagID:1];*/

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateBadges];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate stuff

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if (pageControlIsChangingPage) {
        return;
    }
	
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    pageControlIsChangingPage = NO;
}

#pragma mark - PageControl stuff

-(void)showArcMenu
{
    [self.view addSubview:self.arcMenu];
    [UIView beginAnimations:@"showArcMenu" context:nil];
    self.arcMenu.frame = CGRectMake(527, 763, 241, 241);
    [UIView commitAnimations];
}

-(void)hideArcMenu
{
    [self.view addSubview:self.arcMenu];
    [UIView beginAnimations:@"hideArcMenu" context:nil];
    self.arcMenu.frame = CGRectMake(768, 960, 241, 241);
    [UIView commitAnimations];
}

- (void)arcMenuPressed:(id)sender
{
    if(self.arcMenu == nil)
    {
        self.arcMenu = [[UIArcMenu alloc] initWithFrame:CGRectMake(768, 960, 241, 241) andTarget:self andSelector:@selector(arcMenuBtnPressed:)];
        UISwipeGestureRecognizer *swipegesture =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(arcMenuPressed:)];
        [self.arcMenu addGestureRecognizer:swipegesture];
    }
    if(self.arcMenu.frame.origin.x == 527)
    {
        [self hideArcMenu];
    }
    else
    {
        [self showArcMenu];
    }
}

-(void)arcMenuBtnPressed:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    if(btn.tag == 1)
    {
        //退出
        UIAlertView *logoutAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要退出吗？" cancelButtonItem:[RIButtonItem itemWithLabel:@"确定" action:^{
            __block MBProgressHUD *hud = [[InnerSafeActionManager shared] showHUDWithTips:@"正在注销，请稍候..." inView:self.view];
            InnerSafeHelper *innerSafeHelper = [InnerSafeHelper sharedInstance];
            [innerSafeHelper logoutWithCompletion:^(unsigned long uRet) {
                [[InnerSafeActionManager shared] removeHUD:hud];
                [self.navigationController popViewControllerAnimated:YES];
                exit(0);
            } andWithFail:^(unsigned long uRet) {
                
            }];
        }] otherButtonItems:[RIButtonItem itemWithLabel:@"取消"], nil];
        [logoutAlert show];
    }
    else if(btn.tag == 2)
    {
        //数据同步
        if(syncManager == nil)
        {
            self.syncManager = [[DataSyncManager alloc] init];
        }
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        
        HUD.labelText = @"正在同步数据，请稍候...";
        [HUD show:YES];
        
        [syncManager reSyncAllTables];
    }
    else if(btn.tag == 3){
        /*SetViewController * setVC = [[SetViewController alloc]init];
        setVC.delegate = self;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:setVC];
        nav.modalPresentationStyle =  UIModalPresentationFormSheet;
        [self presentModalViewController:nav animated:YES];
        nav.view.superview.frame = CGRectMake(30, 100, 320, 480);
        nav.view.superview.center = self.view.center;*/
    }
    else if(btn.tag == 4){
        /*AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        nav.modalPresentationStyle =  UIModalPresentationFormSheet;
        [self presentModalViewController:nav animated:YES];
        nav.view.superview.frame = CGRectMake(30, 100, 320, 480);
        nav.view.superview.center = self.view.center;*/
        
    }
    
    
    [self hideArcMenu];
}

- (IBAction)changePage:(id)sender
{
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
	
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControlIsChangingPage = YES;
}

-(void)processWebData:(NSData*)webData
{
    
}

-(void)processWebData:(NSData*)webData andTag:(NSInteger)tag
{
    NSString *resultJSON = [[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];

    NSArray *jsonAry = [resultJSON objectFromJSONString];
    if(tag == 1){
        if (jsonAry && [jsonAry count] > 0) {
            NSDictionary *dicInfo = [jsonAry objectAtIndex:0];
            int status = [[dicInfo objectForKey:@"status"] intValue];
            if (status == 1) {
                NSArray *aryDatas = [dicInfo objectForKey:@"datas"];
                
                NSMutableDictionary *dicTmpBadgeInfo = [NSMutableDictionary dictionaryWithCapacity:5];
                if([aryDatas count] > 0){
                    for(NSDictionary *dicItem in aryDatas){
                        NSString *lx = [dicItem objectForKey:@"LX"];
                        NSString *num = [NSString stringWithFormat:@"%@",[dicItem objectForKey:@"NUM"]];
                        
                        
                        if([lx isEqualToString:@"ALL"])
                        {
                            [dicTmpBadgeInfo setObject:num forKey:@"待办任务(院)"];
                        }
                        else if([lx isEqualToString:@"TZGG"])
                        {
                            [dicTmpBadgeInfo setObject:num forKey:@"通知公告"];
                        }
                    }
                }
                if ([dicBadgeInfo count] > 0) {
                    [dicTmpBadgeInfo setValuesForKeysWithDictionary:dicBadgeInfo];
                }
               
                self.dicBadgeInfo = dicTmpBadgeInfo;
                [self showBageIcons];
            }
        }
    }
    
    
    
   
}

-(void)processError:(NSError *)error
{
}

#pragma mark - 数据同步完成后通知处理

- (void)dataSyncFinished:(NSNotificationCenter *)notification
{
    if(HUD)  [HUD hide:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kMenuSyncFinished object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kMenuSyncFailed object:nil];
}

- (void)dataSyncFailed:(NSNotificationCenter *)notification
{
    if(HUD)  [HUD hide:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataSyncFinished:) name:kMenuSyncFinished object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataSyncFailed:) name:kMenuSyncFailed object:nil];
}

- (void)menuSyncFinished:(NSNotificationCenter *)notification
{
    if(HUD)  [HUD hide:YES];
    [self refreshMenuViews];
    [self requestSysDatas];
}

- (void)menuSyncFailed:(NSNotificationCenter *)notification
{
    
    if(HUD)  [HUD hide:YES];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:@"获取菜单数据信息失败！"
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil];
    [alert show];
    return;
}


@end
