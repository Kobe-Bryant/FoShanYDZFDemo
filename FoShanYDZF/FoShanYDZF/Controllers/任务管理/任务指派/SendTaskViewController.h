//
//  SendTaskViewController.h
//  BoandaProject
//
//  Created by 张仁松 on 13-10-24.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SendTaskViewController : BaseViewController{
    IBOutlet UITextField *wrymcField;
    IBOutlet UITextField *dwdzField;
    IBOutlet UITextField *frdbField;
    IBOutlet UITextField *frdbdhField;
    IBOutlet UITextField *slrField;
    IBOutlet UITextField *rwqxField;
    IBOutlet UITextField *bzField;
    IBOutlet UIButton *saveButton;
}

-(IBAction)touchFromDate:(id)sender;
-(IBAction) touchFromWrymcField:(id)sender;
-(IBAction) choosePersonField:(id)sender;

@end
