//
//  MapQueryViewController.m
//  污染源地图查询
//
//  Created by 曾静 on 13-11-6.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "MapQueryViewController.h"
#import "ServiceUrlString.h"
#import "PDJsonkit.h"
#import "WRYAnnotation.h"
#import "WRYSearchViewController.h"
#import "WRYAnnotationItem.h"
#import "WryDetailCategoryViewController.h"

@interface MapQueryViewController ()
@property (nonatomic, strong) TMapView *tMapView;
@property (nonatomic, strong) NSMutableArray *listDataArray;
@property (nonatomic, strong) NSMutableArray *annotationDataArray;//污染源Anno
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, assign) int totalCount;//总记录条数
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) UIPopoverController *popSearchController;
@property (nonatomic, copy)   NSString *latStr;//用户定位的纬度
@property (nonatomic, copy)   NSString *lonStr;//用户定位的经度
@end

@implementation MapQueryViewController
@synthesize tMapView = _tMapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"地图查询";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    //停止定位
    [_tMapView StopGetPosition];
    //消除弹出框
    if(self.popSearchController)
    {
        [self.popSearchController dismissPopoverAnimated:YES];
    }
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"查询" style:UIBarButtonItemStyleBordered target:self action:@selector(onRightBarClick:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.listDataArray = [[NSMutableArray alloc] init];
    self.annotationDataArray = [[NSMutableArray alloc] init];
    [self requestImportData];
    
    self.tMapView = [[TMapView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)];
	_tMapView.delegate = self;
    _tMapView.mapScale = 12;
    //将地图的中心范围设置为佛山的中心位置
    CLLocationCoordinate2D coor;
    coor.latitude = 23.027379;
    coor.longitude = 113.128852;
    _tMapView.centerCoordinate = coor;
    [self.view addSubview:_tMapView];
    
    //开启定位
    [_tMapView StartGetPosition];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TMapView Delegate Methods

//用户位置改变
- (void)mapView:(TMapView *)mapView didUpdateUserLocation:(TUserLocation *)userLocation
{
    if(userLocation.heading && userLocation.updating == NO)
    {
        [_tMapView StopGetPosition];
        self.latStr = [NSString stringWithFormat:@"%.5f", userLocation.location.coordinate.latitude];
        self.lonStr = [NSString stringWithFormat:@"%.5f", userLocation.location.coordinate.longitude];
    }
}

//定位
- (void)mapView:(TMapView *)mapView didChangeUserTrackingMode:(TUserTrackingMode)mode animated:(BOOL)animated
{
    switch (mode)
    {
        case TUserTrackingModeNone:
            //self.navigationItem.rightBarButtonItem.title = @"未定位";
            break;
        case TUserTrackingModeFollow:
            //self.navigationItem.rightBarButtonItem.title = @"定位";
            break;
        default:
            break;
    }
}

//点击大头针气泡的处理
- (void)mapView:(TMapView *)mapView annotationView:(TAnnotationView *)view calloutControlTapped:(UIControl *)control
{
    WRYAnnotation *anno = (WRYAnnotation *)view.annotation;
    WryDetailCategoryViewController *detail = [[WryDetailCategoryViewController alloc] initWithNibName:@"WryDetailCategoryViewController" bundle:nil];
    detail.primaryKey = anno.wrybh;
    detail.link = @"wry/wryDetailCategory.jsp";
    detail.wrymc = anno.title;
    [self.navigationController pushViewController:detail animated:YES];
}

//自定义大头针的图片
- (TAnnotationView *)mapView:(TMapView *)mapView viewForAnnotation:(id <TAnnotation>)annotation
{
    if([annotation isKindOfClass:[WRYAnnotation class]])
    {
        static NSString *CellIdentifier = @"centerPoi";
        TAnnotationView *annotationView = [[TAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:CellIdentifier];
        annotationView.image = [UIImage imageNamed:@"site_mark.png"];
        annotationView.selectImage = [UIImage imageNamed:@"site_mark.png"];
        annotationView.canShowCallout = TRUE;
        annotationView.draggable = NO;
        CGPoint ptoffset = CGPointMake(annotationView.image.size.width / 2, 0);
        annotationView.calloutOffset = ptoffset;
        ptoffset = CGPointMake(0, (annotationView.image.size.height/2));
        annotationView.centerOffset = ptoffset;
        return annotationView;
    }
    return nil;
}

#pragma mark - Event Handler Method

//导航栏右边的按钮点击处理
- (void)onRightBarClick:(id)sender
{
    if([self.popSearchController isPopoverVisible])
    {
        [self.popSearchController dismissPopoverAnimated:YES];
        return;
    }
    UIBarButtonItem *item = (UIBarButtonItem*)sender;
    WRYSearchViewController *controller = [[WRYSearchViewController alloc] initWithNibName:@"WRYSearchViewController" bundle:nil];
    controller.delegate = self;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:controller];
    
    UIPopoverController *popController = [[UIPopoverController alloc] initWithContentViewController:navi];
    popController.popoverContentSize = CGSizeMake(320, 480);
    self.popSearchController = popController;
    
    [self.popSearchController presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - Network Handler Methods

/**
    @brief 获取重点污染源企业的数据
    这里的重点指的是监管级别属于国控的企业
 */
- (void)requestImportData
{
    self.isLoading = YES;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"WRY_MAP_QUERY" forKey:@"service"];
    [params setObject:@"1" forKey:@"JGJB"];
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    self.urlString = urlStr;
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:self.urlString andParentView:self.view delegate:self];
}

/**
	@brief 获取污染源企业数据
	@param wrymc 污染源名称
	@param szds 所在地市
	@param szqx 所在区县
	@param jgjb 监管级别(1国控 2省控 3市控 4区控 5非控)
 */
- (void)requestDataWith:(NSString *)wrymc andWithSZDS:(NSString *)szds andWithSZQX:(NSString *)szqx andWithJGJB:(NSString *)jgjb
{
    self.isLoading = YES;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"WRY_MAP_QUERY" forKey:@"service"];
    if(wrymc != nil && wrymc.length > 0)
    {
        [params setObject:jgjb forKey:@"JGJB"];
    }
    if(szds != nil && szds.length > 0)
    {
        [params setObject:jgjb forKey:@"JGJB"];
    }
    if(szqx != nil && szqx.length > 0)
    {
        [params setObject:jgjb forKey:@"JGJB"];
    }
    if(jgjb != nil && jgjb.length > 0)
    {
        [params setObject:jgjb forKey:@"JGJB"];
    }
    else
    {
        if(wrymc == nil && szqx == nil && szds == nil)
        {
            [params setObject:@"1" forKey:@"JGJB"];//默认查询
        }
    }
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    self.urlString = urlStr;
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:self.urlString andParentView:self.view delegate:self];
}

/**
    @brief 获取指定经纬度周围污染源企业的数据
    @param aLat 经度
    @param aLog 纬度
    @param radius 据中心点的半径
 */
- (void)requestDataWithLat:(float)aLat andWithLog:(float)aLog andWithRadius:(int)radius
{
    self.isLoading = YES;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"WRY_MAP_QUERY" forKey:@"service"];
    [params setObject:[NSString stringWithFormat:@"%lf", aLog] forKey:@"C_LONGITUDE"];//经度
    [params setObject:[NSString stringWithFormat:@"%lf", aLat] forKey:@"C_LATITUDE"];//纬度
    [params setObject:[NSString stringWithFormat:@"%d", radius] forKey:@"RADIUS"];//据中心点的半径
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    self.urlString = urlStr;
    NSString *tip = [NSString stringWithFormat:@"正在获取当前位置附近的污染源(%dkm)", radius/1000];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:self.urlString andParentView:self.view delegate:self tipInfo:tip tagID:1];
}

- (void)processWebData:(NSData *)webData
{
    self.isLoading = NO;
    if(webData.length <= 0)
    {
        return;
    }
    NSString *jsonStr = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSDictionary *detailDict = [jsonStr objectFromJSONString];
    BOOL bParsedError = NO;
    if(detailDict != nil)
    {
        self.totalCount = [[detailDict objectForKey:@"totalCount"] intValue];
        if(self.totalCount <=0)
        {
            
        }
        NSArray *tmpAry = [detailDict objectForKey:@"data"];
        if(tmpAry.count > 0)
        {
            [self.listDataArray addObjectsFromArray:tmpAry];
        }
    }
    else
    {
        bParsedError = YES;
    }
    for (int i = 0; i < self.listDataArray.count; i++) {
        NSDictionary *dict = [self.listDataArray objectAtIndex:i];
        NSString *jdStr = [dict objectForKey:@"JD"];
        NSString *wdStr = [dict objectForKey:@"WD"];
        if(jdStr != nil && wdStr != nil)
        {
            WRYAnnotationItem *item = [[WRYAnnotationItem alloc] init];
            item.wrybh = [dict objectForKey:@"WRYBH"];
            item.wrymc = [dict objectForKey:@"WRYMC"];
            item.wrydz = [dict objectForKey:@"DWDZ"];
            item.latitude = wdStr;
            item.longitude = jdStr;
            [self AddSingleAnnotation:item];
        }
        
    }
    if(bParsedError)
    {
        [self showAlertMessage:@"解析数据出错!"];
    }
}

- (void)processError:(NSError *)error
{
    self.isLoading = NO;
    [self showAlertMessage:@"获取数据出错!"];
}

#pragma mark - Private Methods

/**
    @brief 添加单个标注
    @param item 污染源名称
 */
- (void)AddSingleAnnotation:(WRYAnnotationItem *)item
{
    WRYAnnotation *temp = [[WRYAnnotation alloc] init];
    temp.title = item.wrymc;
    temp.subtitle = item.wrydz;
    temp.wrybh = item.wrybh;
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake([item.latitude floatValue], [item.longitude floatValue]);
    temp.coordinate = coor;
    if(![self.annotationDataArray containsObject:temp])
    {
        [self.annotationDataArray addObject:temp];
    }
    [_tMapView addAnnotation:temp];
}

/**
    @brief 清除所有的标注
 */
- (void)removeAnnotations
{
    for (int i = 0; i < self.annotationDataArray.count; i++)
    {
        WRYAnnotation *temp = [self.annotationDataArray objectAtIndex:i];
        [self.tMapView removeAnnotation:temp];
    }
    //清除保存的数据
    [self.annotationDataArray removeAllObjects];
}

#pragma mark - MapSearchCondition Delegate Method

/**
    @brief 代理方法，处理传递过来的参数数据
    @param params 传递过来的参数
 */
- (void)passSearchConditon:(NSDictionary *)params
{
    if([self.popSearchController isPopoverVisible])
    {
        [self.popSearchController dismissPopoverAnimated:YES];
    }
    //进行查询之前，先将上次的Annotation移除
    [self removeAnnotations];
    self.isLoading = YES;
    if(self.webHelper)
    {
        [self.webHelper cancel];
    }
    //查询数据
    NSMutableDictionary *newParams = [[NSMutableDictionary alloc] initWithDictionary:params];
    if([newParams objectForKey:@"RADIUS"] != nil)
    {
        [newParams setObject:[NSString stringWithFormat:@"%@", self.lonStr] forKey:@"C_LONGITUDE"];//经度
        [newParams setObject:[NSString stringWithFormat:@"%@", self.latStr] forKey:@"C_LATITUDE"];//纬度
    }
    [newParams setObject:@"WRY_MAP_QUERY" forKey:@"service"];
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:newParams];
    self.urlString = urlStr;
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:self.urlString andParentView:self.view delegate:self];
}

@end
