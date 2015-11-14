//
//  BaseInspectView.m
//  FoShanYDZF
//
//  Created by 曾静 on 13-11-18.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "BaseInspectView.h"

@implementation BaseInspectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSString *)getSegmentData:(UISegmentedControl *)segCtrl
{
    NSString *str = [NSString stringWithFormat:@"%d", segCtrl.selectedSegmentIndex];
    if(str == nil || str.length == 0)
        str = @"0";
    return str;
}

-(void)modifySeg:(UISegmentedControl*)segCtrl Value:(NSString*)value
{
    int index = 0;
    if (value != nil)
    {
        index = [value intValue];
    }
    [segCtrl setSelectedSegmentIndex:index];
}

- (NSString *)getTextFieldData:(UITextField *)textField
{
    if(textField.text.length == 0)
        return @"";
    else
        return textField.text;
}

- (NSString *)getTextViewData:(UITextView *)textField
{
    if(textField.text.length == 0)
        return @"";
    else
        return textField.text;
}

- (void)setTextFieldData:(UITextField *)textField andWithData:(NSString *)data
{
    if(data == nil || data.length == 0)
    {
        data = @"";
    }
    if(textField != nil)
    {
        [textField setText:data];
    }
}

- (void)setTextViewData:(UITextView *)textField andWithData:(NSString *)data
{
    if(data == nil || data.length == 0)
    {
        data = @"";
    }
    if(textField != nil)
    {
        [textField setText:data];
    }
}

- (void)loadData:(NSDictionary*)values
{
    
}

- (NSDictionary*)getValueData
{
    return nil;
}

@end
