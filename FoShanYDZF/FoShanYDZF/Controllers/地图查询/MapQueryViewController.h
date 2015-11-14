//
//  MapQueryViewController.h
//  污染源地图查询
//
//  Created by 曾静 on 13-11-6.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TMapView.h"
#import "WRYSearchViewController.h"

@interface MapQueryViewController : BaseViewController <TMapViewDelegate,PassSearchConditionDelegate>

@end
