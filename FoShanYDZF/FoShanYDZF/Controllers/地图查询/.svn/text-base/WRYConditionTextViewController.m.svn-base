//
//  WRYConditionTextViewController.m
//  FoShanYDZF
//
//  Created by 曾静 on 13-11-13.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "WRYConditionTextViewController.h"

@interface WRYConditionTextViewController ()

@end

@implementation WRYConditionTextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contentSizeForViewInPopover = CGSizeMake(320, 480-44);
    if (self.selectedValue.length > 0)
    {
        self.nameField.text = self.selectedValue;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setNameField:nil];
    [super viewDidUnload];
}

- (IBAction)onComfirmClick:(id)sender
{
    self.selectedValue = self.nameField.text;
    if([self.delegate respondsToSelector:@selector(passCondtionWithValue:andWithKey:)])
    {
        [self.delegate passCondtionWithValue:self.selectedValue andWithKey:self.conditionKey];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
