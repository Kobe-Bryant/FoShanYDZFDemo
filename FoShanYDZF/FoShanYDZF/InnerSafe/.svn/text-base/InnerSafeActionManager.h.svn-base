//
//  DHActionManager.h
//  
//
//  Created by 曾静 on 13-7-21.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD.h"

@interface InnerSafeActionManager : NSObject <UIAlertViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIDocumentInteractionControllerDelegate>

+ (InnerSafeActionManager *)shared;

- (void)showAndHideHUDWithTitle:(NSString *)title detailText:(NSString *)detail inView:(UIView *)view;

- (void)showHUDWithTitle:(NSString *)title detailText:(NSString *)detail;

- (MBProgressHUD *)showHUDWithTitle:(NSString *)title detailText:(NSString *)detail inView:(UIView *)view;

- (MBProgressHUD *)showHUDWithTips:(NSString *)tips inView:(UIView *)view;

- (void)removeHUD:(MBProgressHUD *)hud;

- (void)composeMailToRecipients:(NSArray *)recipients withSubject:(NSString *)subject body:(NSString *)body;

- (void)composeMessageToRecipients:(NSArray *)recipients withBody:(NSString *)body;

@end
