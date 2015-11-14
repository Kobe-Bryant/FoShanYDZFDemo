//
//  DHActionManager.m
//  
//
//  Created by 曾静 on 13-7-21.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "InnerSafeActionManager.h"

@implementation InnerSafeActionManager

+ (InnerSafeActionManager *)shared{
    static InnerSafeActionManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[InnerSafeActionManager alloc] init];
    });
    return _sharedInstance;
}

- (void)showAndHideHUDWithTitle:(NSString *)title detailText:(NSString *)detail inView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.detailsLabelText = detail;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

- (void)showHUDWithTitle:(NSString *)title detailText:(NSString *)detail{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.detailsLabelText = detail;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
}

- (MBProgressHUD *)showHUDWithTitle:(NSString *)title detailText:(NSString *)detail inView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.detailsLabelText = detail;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

- (MBProgressHUD *)showHUDWithTips:(NSString *)tips inView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    [view addSubview:hud];
    hud.labelText = tips;
    [hud show:YES];
    return hud;
}

- (void)removeHUD:(MBProgressHUD *)hud {
    if(hud != nil) {
        [hud removeFromSuperViewOnHide];
    }
}

#pragma mark - Compose Mail and SMS

- (void)composeMailToRecipients:(NSArray *)recipients withSubject:(NSString *)subject body:(NSString *)body{
    if (![MFMailComposeViewController canSendMail]) return;
    MFMailComposeViewController *composeVC = [[MFMailComposeViewController alloc] init];
	composeVC.mailComposeDelegate = self;
    if (recipients) [composeVC setToRecipients:recipients];
    if (subject) [composeVC setSubject:subject];
    if (body) [composeVC setMessageBody:body isHTML:NO];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:composeVC animated:YES completion:NULL];
}

- (void)composeMessageToRecipients:(NSArray *)recipients withBody:(NSString *)body{
    if (![MFMessageComposeViewController canSendText]) return;
    MFMessageComposeViewController *composeVC = [[MFMessageComposeViewController alloc] init];
	composeVC.messageComposeDelegate = self;
    if (recipients) [composeVC setRecipients:recipients];
    if (body) [composeVC setBody:body];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:composeVC animated:YES completion:NULL];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultCancelled:
            //
            break;
        case MessageComposeResultSent:
            //
            break;
        case MessageComposeResultFailed:
            //
            break;
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            //
            break;
        case MFMailComposeResultSaved:
            //
            break;
        case MFMailComposeResultSent:
            //
            break;
        case MFMailComposeResultFailed:
            //
            break;
            
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

@end
