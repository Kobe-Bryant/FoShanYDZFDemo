//
//  BaseFieldView.h
//  FoShanYDZF
//
//  Created by PowerData on 13-11-7.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseFieldView : UIView <UITextFieldDelegate>

- (NSString *)getSegmentData:(UISegmentedControl *)segCtrl;

- (void)modifySeg:(UISegmentedControl*)segCtrl Value:(NSString*)value;

- (NSString *)getTextFieldData:(UITextField *)textField;

- (NSString *)getTextViewData:(UITextView *)textField;

- (void)setTextFieldData:(UITextField *)textField andWithData:(NSString *)data;

- (void)setTextViewData:(UITextView *)textField andWithData:(NSString *)data;

-(void)loadData:(NSDictionary*)values;

- (NSDictionary*)getValueData;

@end
