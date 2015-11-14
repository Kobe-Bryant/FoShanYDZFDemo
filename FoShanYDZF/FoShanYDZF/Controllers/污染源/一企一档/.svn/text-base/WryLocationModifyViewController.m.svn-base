//
//  WryLocationModifyViewController.m
//  FoShanYDZF
//
//  Created by ihumor on 13-12-10.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "WryLocationModifyViewController.h"
#import "ServiceUrlString.h"
#import "PDJsonkit.h"
#import "WRYAnnotation.h"
#import "WRYAnnotationItem.h"

@interface WryLocationModifyViewController ()

@property (nonatomic, strong) TMapView *tMapView;
@property (nonatomic, copy) NSString *latStr;//用户定位的纬度
@property (nonatomic, copy) NSString *lonStr;//用户定位的经度

@property (nonatomic, strong) WRYAnnotation *myAnnotation;
@end

@implementation WryLocationModifyViewController
@synthesize tMapView = _tMapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@-%@", self.wrymc, @"污染源经纬度校准"];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"开始校准" style:UIBarButtonItemStyleBordered target:self action:@selector(onSaveButtonClick:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.tMapView = [[TMapView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)];
	_tMapView.delegate = self;
    _tMapView.mapScale = 12;
    //将地图的中心范围设置为佛山的中心位置
    CLLocationCoordinate2D coor;
    coor.latitude = 23.027379;
    coor.longitude = 113.128852;
    _tMapView.centerCoordinate = coor;
    [self.view addSubview:_tMapView];
    self.tMapView.ShowPosition = YES;
    //开启定位
    [_tMapView StartGetPosition];
    
    
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
        [self.tMapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude) animated:YES];
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

- (void)onSaveButtonClick:(UIBarButtonItem *)sender
{
    if([sender.title isEqualToString:@"开始校准"])
    {
        //在地图上放置大头针
        UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMapTapPress:)];
        [self.tMapView addGestureRecognizer:mTap];
        
        sender.title = @"提交数据";
    }
    else if([sender.title isEqualToString:@"提交数据"])
    {
        //提交数据
        if(self.latStr && self.lonStr && self.wrybh)
        {
            [self requestData];
        }
        sender.title = @"开始校准";
    }
}

- (void)onMapTapPress:(UIGestureRecognizer*)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:self.tMapView];//这里touchPoint是点击的某点在地图控件中的位置
    CLLocationCoordinate2D touchMapCoordinate =
    [self.tMapView convertPoint:touchPoint toCoordinateFromView:self.tMapView];//这里touchMapCoordinate就是该点的经纬度了
    
    [self removeAnnotations];
    
    NSString *wdStr = [NSString stringWithFormat:@"%.3f", touchMapCoordinate.latitude];
    NSString *jdStr = [NSString stringWithFormat:@"%.3f", touchMapCoordinate.longitude];
    self.latStr = wdStr;
    self.lonStr = jdStr;
    WRYAnnotationItem *item = [[WRYAnnotationItem alloc] init];
    item.wrybh = self.wrybh;
    item.wrymc = self.wrymc;
    item.wrydz = self.wrydz;
    item.latitude = wdStr;
    item.longitude = jdStr;
    [self addSingleAnnotation:item];
}

- (void)requestData
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"MODIFY_WRY_LOCATION" forKey:@"service"];
    [params setObject:self.wrybh forKey:@"wrybh"];
    [params setObject:self.lonStr forKey:@"jd"];
    [params setObject:self.latStr forKey:@"wd"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self tipInfo:@"正在校准位置数据……" tagID:1];
}

- (void)processWebData:(NSData *)webData
{
    NSString *log = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSDictionary *tmpParsedDict = [log objectFromJSONString];
    if(tmpParsedDict != nil)
    {
        NSString *msg = [tmpParsedDict objectForKey:@"message"];
        [self showAlertMessage:msg];
    }
    else
    {
        [self showAlertMessage:@"校准失败"];
    }
}

- (void)processError:(NSError *)error
{
    [self showAlertMessage:@"校准失败"];
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
        annotationView.draggable = YES;
        CGPoint ptoffset = CGPointMake(annotationView.image.size.width / 2, 0);
        annotationView.calloutOffset = ptoffset;
        ptoffset = CGPointMake(0, (annotationView.image.size.height/2));
        annotationView.centerOffset = ptoffset;
        return annotationView;
    }
    return nil;
}

#pragma mark - Private Methods

/**
 @brief 添加单个标注
 @param item 污染源名称
 */
- (void)addSingleAnnotation:(WRYAnnotationItem *)item
{
    self.myAnnotation = [[WRYAnnotation alloc] init];
    self.myAnnotation.title = item.wrymc;
    self.myAnnotation.subtitle = item.wrydz;
    self.myAnnotation.wrybh = item.wrybh;
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake([item.latitude floatValue], [item.longitude floatValue]);
    self.myAnnotation.coordinate = coor;
    [_tMapView addAnnotation:self.myAnnotation];
}

/**
 @brief 清除所有的标注
 */
- (void)removeAnnotations
{
    if(self.myAnnotation)
    {
        [self.tMapView removeAnnotation:self.myAnnotation];
    }
}

@end
