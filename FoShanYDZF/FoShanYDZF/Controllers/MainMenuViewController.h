//
//  MainMenuViewController.h
//  BoandaProject
//
//  Created by 张仁松 on 13-7-2.
//  Copyright (c) 2013年 szboanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"
#import "UIArcMenu.h"

@interface MainMenuViewController : UIViewController<UIScrollViewDelegate,UIAlertViewDelegate,NSURLConnHelperDelegate>
{
    BOOL pageControlIsChangingPage;
}

@property (nonatomic, strong) NSDictionary *dicBadgeInfo;
@property (nonatomic, strong) UIArcMenu *arcMenu;
@end
