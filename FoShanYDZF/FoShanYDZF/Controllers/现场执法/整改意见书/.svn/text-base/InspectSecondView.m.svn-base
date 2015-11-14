//
//  InspectSecondView.m
//  FoShanYDZF
//
//  Created by ihumor on 13-11-18.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "InspectSecondView.h"

@implementation InspectSecondView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"InspectSecondView" owner:self options:nil] objectAtIndex:0];
    if(self)
    {
        czwtStr = [[NSMutableString alloc] init];
        clyjStr = [[NSMutableString alloc] init];

        [self initView];
    }
    return self;
}

- (void)initView
{
    self.qtLabel.hidden = self.qtSwitch.on;
    [self.qtSwitch addTarget:self action:@selector(onSwitchClick:) forControlEvents:UIControlEventValueChanged];
    
    [self.czwtSwitch1 addTarget:self action:@selector(onQuestionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self.czwtSwitch2 addTarget:self action:@selector(onQuestionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self.czwtSwitch3 addTarget:self action:@selector(onQuestionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self.czwtSwitch4 addTarget:self action:@selector(onQuestionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self.czwtSwitch5 addTarget:self action:@selector(onQuestionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self.czwtSwitch6 addTarget:self action:@selector(onQuestionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self.czwtSwitch7 addTarget:self action:@selector(onQuestionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self.czwtSwitch8 addTarget:self action:@selector(onQuestionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    
    [self.xcclyjSwitch1 addTarget:self action:@selector(onOpinionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self.xcclyjSwitch2 addTarget:self action:@selector(onOpinionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self.xcclyjSwitch3 addTarget:self action:@selector(onOpinionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self.xcclyjSwitch4 addTarget:self action:@selector(onOpinionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self.xcclyjSwitch5 addTarget:self action:@selector(onOpinionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self.xcclyjSwitch6 addTarget:self action:@selector(onOpinionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self.xcclyjSwitch7 addTarget:self action:@selector(onOpinionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    [self.xcclyjSwitch8 addTarget:self action:@selector(onOpinionSwitchClick:) forControlEvents:UIControlEventValueChanged];
    
    self.czwtSwitch1.on = NO;
    self.czwtSwitch2.on = NO;
    self.czwtSwitch3.on = NO;
    self.czwtSwitch4.on = NO;
    self.czwtSwitch5.on = NO;
    self.czwtSwitch6.on = NO;
    self.czwtSwitch7.on = NO;
    self.czwtSwitch8.on = NO;
    
    self.xcclyjSwitch1.on = NO;
    self.xcclyjSwitch2.on = NO;
    self.xcclyjSwitch3.on = NO;
    self.xcclyjSwitch4.on = NO;
    self.xcclyjSwitch5.on = NO;
    self.xcclyjSwitch6.on = NO;
    self.xcclyjSwitch7.on = NO;
    self.xcclyjSwitch8.on = NO;
    
    if(!self.czwtSwitch1.on)
    {
        self.xcclyjSwitch1.enabled = NO;
    }
    if(!self.czwtSwitch2.on)
    {
        self.xcclyjSwitch2.enabled = NO;
    }
    if(!self.czwtSwitch3.on)
    {
        self.xcclyjSwitch3.enabled = NO;
    }
    if(!self.czwtSwitch4.on)
    {
        self.xcclyjSwitch4.enabled = NO;
    }
    if(!self.czwtSwitch5.on)
    {
        self.xcclyjSwitch5.enabled = NO;
    }
    if(!self.czwtSwitch6.on)
    {
        self.xcclyjSwitch6.enabled = NO;
    }
    if(!self.czwtSwitch7.on)
    {
        self.xcclyjSwitch7.enabled = NO;
    }
    if(!self.czwtSwitch8.on)
    {
        self.xcclyjSwitch8.enabled = NO;
    }
}

- (void)onSegmentClcik:(UISegmentedControl *)sender
{
    
}

- (void)onQuestionSwitchClick:(UISwitch *)sender
{
    if(sender.tag >= 104)
    {
        if(sender.on)
        {
            [czwtStr appendFormat:@"%d,", (sender.tag - 104)/2];
            UISwitch *s = (UISwitch *)[self viewWithTag:sender.tag+1];
            s.enabled = YES;
        }
        else
        {
            UISwitch *s = (UISwitch *)[self viewWithTag:sender.tag+1];
            s.on = NO;
            s.enabled = NO;
        }
    }
}

- (void)onOpinionSwitchClick:(UISwitch *)sender
{
    if(sender.tag >= 105)
    {
        if(sender.on)
        {
            [clyjStr appendFormat:@"%d,", (sender.tag - 105)/2];
        }
    }
}

- (void)onSwitchClick:(UISwitch *)sender
{
    if(sender.tag == 101)
    {
        self.qtLabel.hidden = sender.on;
    }
}

-(void)loadData:(NSDictionary*)values
{
    [self modifySeg:self.qtzlssSeg Value:[values objectForKey:@"QTZLSS"]];
    [self modifySeg:self.qtsfyxzcSeg Value:[values objectForKey:@"QTSFZCYX"]];
    [self setCZWTValue:[values objectForKey:@"CZWT"]];
    [self setCLYJValue:[values objectForKey:@"XCCLYJ"]];
    [self setTextViewData:self.qtwtTextView andWithData:[values objectForKey:@"QT"]];
}

- (NSDictionary*)getValueData
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if(self.qtSwitch.on)
    {
        //其他
        [params setObject:[self getSegmentData:self.qtzlssSeg] forKey:@"QTZLSS"];
        [params setObject:[self getSegmentData:self.qtsfyxzcSeg] forKey:@"QTSFZCYX"];
    }
    else
    {
        [params setObject:@"1" forKey:@"QTZLSS"];
        [params setObject:@"1" forKey:@"QTSFZCYX"];
    }
    [params setObject:[self getCZWTValue] forKey:@"CZWT"];//存在问题
    [params setObject:[self getCLYJTValue] forKey:@"XCCLYJ"];//现场处理意见
    [params setObject:[self getTextViewData:self.qtwtTextView] forKey:@"QT"];
    return params;
}

- (void)setCZWTValue:(NSString *)value
{
    //104 106 108 110 112 114 116 118
    if(value.length <= 0)
    {
        return;
    }
    NSArray *ary = [value componentsSeparatedByString:@","];
    for(int i = 0; i < ary.count; i++)
    {
        int idx = [[ary objectAtIndex:i] intValue];
        [self setSwitchData:idx andWithType:0];
    }
}

- (void)setCLYJValue:(NSString *)value
{
    //105 107 109 111 113 115 117 119
    if(value.length <= 0)
    {
        return;
    }
    NSArray *ary = [value componentsSeparatedByString:@","];
    for(int i = 0; i < ary.count; i++)
    {
        int idx = [[ary objectAtIndex:i] intValue];
        [self setSwitchData:idx andWithType:1];
    }
}

- (void)setSwitchData:(int)str andWithType:(int)type
{
    if(type == 0)
    {
        int tag = 104 + str*2;
        UISwitch *sw = (UISwitch *)[self viewWithTag:tag];
        if(sw != nil)
            sw.on = YES;
    }
    else
    {
        int tag = 105 + str*2;
        UISwitch *sw = (UISwitch *)[self viewWithTag:tag];
        if(sw != nil)
            sw.on = YES;
    }
}

- (NSString *)getCZWTValue
{
    NSMutableString *str = [[NSMutableString alloc] init];
    if(self.czwtSwitch1.on)
    {
        [str appendFormat:@"%d,", 0];
    }
    if(self.czwtSwitch2.on)
    {
        [str appendFormat:@"%d,", 1];
    }
    if(self.czwtSwitch3.on)
    {
        [str appendFormat:@"%d,", 2];
    }
    if(self.czwtSwitch4.on)
    {
        [str appendFormat:@"%d,", 3];
    }
    if(self.czwtSwitch5.on)
    {
        [str appendFormat:@"%d,", 4];
    }
    if(self.czwtSwitch6.on)
    {
        [str appendFormat:@"%d,", 5];
    }
    if(self.czwtSwitch7.on)
    {
        [str appendFormat:@"%d,", 6];
    }
    if(self.czwtSwitch8.on)
    {
        [str appendFormat:@"%d,", 7];
    }
    return str;
}

- (NSString *)getCLYJTValue
{
    NSMutableString *str = [[NSMutableString alloc] init];
    if(self.xcclyjSwitch1.on)
    {
        [str appendFormat:@"%d,", 0];
    }
    if(self.xcclyjSwitch2.on)
    {
        [str appendFormat:@"%d,", 1];
    }
    if(self.xcclyjSwitch3.on)
    {
        [str appendFormat:@"%d,", 2];
    }
    if(self.xcclyjSwitch4.on)
    {
        [str appendFormat:@"%d,", 3];
    }
    if(self.xcclyjSwitch5.on)
    {
        [str appendFormat:@"%d,", 4];
    }
    if(self.xcclyjSwitch6.on)
    {
        [str appendFormat:@"%d,", 5];
    }
    if(self.xcclyjSwitch7.on)
    {
        [str appendFormat:@"%d,", 6];
    }
    if(self.xcclyjSwitch8.on)
    {
        [str appendFormat:@"%d,", 7];
    }
    return str;
}

@end
