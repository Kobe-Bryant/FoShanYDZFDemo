//
//  FieldSecondPartView.m
//  FoShanYDZF
//
//  Created by PowerData on 13-11-4.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "FieldSecondPartView.h"

@implementation FieldSecondPartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initControlVisualable
{
    //现场采样情况
    if(xccyqkSegment.selectedSegmentIndex == 1)
    {
        cyqtwzbzLabel.hidden = NO;
        cyqtwzbzField.hidden = NO;
    }
    else
    {
        cyqtwzbzLabel.hidden = YES;
        cyqtwzbzField.hidden = YES;
    }
    //回用设施运行情况
    if(hyssyxqkSegment.selectedSegmentIndex == 0)
    {
        hyssbzcsmLabel.hidden = YES;
        hyssbzcsmField.hidden = YES;
    }
    else
    {
        hyssbzcsmLabel.hidden = NO;
        hyssbzcsmField.hidden = NO;
    }
    //危险废物贮存情况
    if(wxfwzcqkSegment.selectedSegmentIndex == 0)
    {
        wxfwzcbgfsmLabel.hidden = YES;
        wxfwzcbgfsmField.hidden = YES;
    }
    else
    {
        wxfwzcbgfsmLabel.hidden = NO;
        wxfwzcbgfsmField.hidden = NO;
    }
}

-(id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"FieldSecondPartView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        [hyssyxqkSegment addTarget:self action:@selector(onSegmentClick:) forControlEvents:UIControlEventValueChanged];
        [wxfwzcqkSegment addTarget:self action:@selector(onSegmentClick:) forControlEvents:UIControlEventValueChanged];
        [xccyqkSegment addTarget:self action:@selector(onSegmentClick:) forControlEvents:UIControlEventValueChanged];
        [self initControlVisualable];
        
    }
    return self;
}

-(void)loadData:(NSDictionary*)values
{
    //废气类
    [self modifySeg:fqyzqkSegment Value:[values objectForKey:@"FQYZQK"]];
    [self modifySeg:fqtzjlqkSegment Value:[values objectForKey:@"FQYXJLQK"]];
    [self modifySeg:fqpwgdbsqkSegment Value:[values objectForKey:@"FQPWGDBSQK"]];
    [self modifySeg:fqxgczgcSegment Value:[values objectForKey:@"FQXGGYLCT"]];
    [self modifySeg:fqxgpwkbzpSegment Value:[values objectForKey:@"FQXGPWKBZP"]];
    //在线监测设备
    [self modifySeg:zxjcsbsfazSegment Value:[values objectForKey:@"ZXJCSBAZ"]];
    [self modifySeg:zxjcsbsfyxSegment Value:[values objectForKey:@"ZXJCSBYX"]];
    [self modifySeg:zxjcsbyxxshSegment Value:[values objectForKey:@"ZXJCSBYXXSH"]];
    //在线数据读数
    [self setTextFieldData:phField andWithData:[values objectForKey:@"PH"]];
    [self setTextFieldData:codField andWithData:[values objectForKey:@"COD"]];
    [self setTextFieldData:nh3Field andWithData:[values objectForKey:@"NHN"]];
    [self setTextFieldData:tcuField andWithData:[values objectForKey:@"TCU"]];
    [self setTextFieldData:tniField andWithData:[values objectForKey:@"TNI"]];
    [self setTextFieldData:so2Field andWithData:[values objectForKey:@"SO"]];
    [self setTextFieldData:noxField andWithData:[values objectForKey:@"NO"]];
    [self setTextFieldData:yanchenField andWithData:[values objectForKey:@"YC"]];
    [self setTextFieldData:lljsbdsField andWithData:[values objectForKey:@"SBDS"]];
    [self setTextFieldData:qitaField andWithData:[values objectForKey:@"QT"]];
    //回用设施运行情况
    [self modifySeg:hyqkSegment Value:[values objectForKey:@"HYQK"]];
    [self modifySeg:hyssyxqkSegment Value:[values objectForKey:@"HYYXQK"]];
    if(hyssyxqkSegment.selectedSegmentIndex == 1)
    {
        hyssbzcsmLabel.hidden = NO;
        hyssbzcsmField.hidden = NO;
    }
    else
    {
        hyssbzcsmLabel.hidden = YES;
        hyssbzcsmField.hidden = YES;
    }
    [self setTextFieldData:hyssbzcsmField andWithData:[values objectForKey:@"HYBZCYXBZ"]];
    //危险废物贮存情况
    [self modifySeg:wxfwzcqkSegment Value:[values objectForKey:@"WXFWZCKQ"]];
    [self setTextFieldData:wxfwzcbgfsmField andWithData:[values objectForKey:@"ZCBGFBZ"]];
    [self modifySeg:wxfwzyqkSegment1 Value:[values objectForKey:@"WXFWZYQK"]];
    [self modifySeg:wxfwzyqkSegment2 Value:[values objectForKey:@"WXFWZYQK2"]];
    //现场测试及采样情况
    [self modifySeg:xccycswzSegment1 Value:[values objectForKey:@"CSWZY"]];
    [self modifySeg:xccycswzSegment2 Value:[values objectForKey:@"CSWZR"]];
    [self modifySeg:xccyqkSegment Value:[values objectForKey:@"XCCYQK"]];
    if(xccyqkSegment.selectedSegmentIndex == 1)
    {
        cyqtwzbzLabel.hidden = NO;
        cyqtwzbzField.hidden = NO;
    }
    else
    {
        cyqtwzbzLabel.hidden = YES;
        cyqtwzbzField.hidden = YES;
    }
    [self setTextFieldData:cyqtwzbzField andWithData:[values objectForKey:@"QTWZCY"]];
}

-(NSDictionary *)getValueData
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    //废气类
    [dict setObject:[self getSegmentData:fqpwgdbsqkSegment] forKey:@"FQYZQK"];
    [dict setObject:[self getSegmentData:fqtzjlqkSegment] forKey:@"FQYXJLQK"];
    [dict setObject:[self getSegmentData:fqpwgdbsqkSegment] forKey:@"FQPWGDBSQK"];
    [dict setObject:[self getSegmentData:fqxgczgcSegment] forKey:@"FQXGGYLCT"];
    [dict setObject:[self getSegmentData:fqxgpwkbzpSegment] forKey:@"FQXGPWKBZP"];
    //在线监测设备
    [dict setObject:[self getSegmentData:zxjcsbsfazSegment] forKey:@"ZXJCSBAZ"];
    [dict setObject:[self getSegmentData:zxjcsbsfyxSegment] forKey:@"ZXJCSBYX"];
    [dict setObject:[self getSegmentData:zxjcsbyxxshSegment] forKey:@"ZXJCSBYXXSH"];
    //在线数据读数
    [dict setObject:[self getTextFieldData:phField] forKey:@"PH"];
    [dict setObject:[self getTextFieldData:codField] forKey:@"COD"];
    [dict setObject:[self getTextFieldData:nh3Field] forKey:@"NHN"];
    [dict setObject:[self getTextFieldData:tcuField] forKey:@"TCU"];
    [dict setObject:[self getTextFieldData:tniField] forKey:@"TNI"];
    [dict setObject:[self getTextFieldData:so2Field] forKey:@"SO"];
    [dict setObject:[self getTextFieldData:noxField] forKey:@"NO"];
    [dict setObject:[self getTextFieldData:yanchenField] forKey:@"YC"];
    [dict setObject:[self getTextFieldData:lljsbdsField] forKey:@"SBDS"];
    [dict setObject:[self getTextFieldData:qitaField] forKey:@"QT"];
    //回用设施运行情况
    [dict setObject:[self getSegmentData:hyqkSegment] forKey:@"HYQK"];
    [dict setObject:[self getSegmentData:hyssyxqkSegment] forKey:@"HYYXQK"];
    [dict setObject:[self getTextFieldData:hyssbzcsmField] forKey:@"HYBZCYXBZ"];
    //危险废物贮存情况
    [dict setObject:[self getSegmentData:wxfwzcqkSegment] forKey:@"WXFWZCKQ"];
    [dict setObject:[self getSegmentData:wxfwzyqkSegment1] forKey:@"WXFWZYQK"];
    [dict setObject:[self getTextFieldData:wxfwzcbgfsmField] forKey:@"ZCBGFBZ"];
    [dict setObject:[self getSegmentData:wxfwzyqkSegment2] forKey:@"WXFWZYQK2"];
    //现场测试及采样情况
    [dict setObject:[self getSegmentData:xccycswzSegment1] forKey:@"CSWZY"];
    [dict setObject:[self getSegmentData:xccycswzSegment2] forKey:@"CSWZR"];
    [dict setObject:[self getSegmentData:xccyqkSegment] forKey:@"XCCYQK"];
    [dict setObject:[self getTextFieldData:cyqtwzbzField] forKey:@"QTWZCY"];
    return dict;
}

-(void)onSegmentClick:(UISegmentedControl *)sender
{
    if(sender.tag == 118)
    {
        if(sender.selectedSegmentIndex == 0)
        {
            hyssbzcsmLabel.hidden = YES;
            hyssbzcsmField.hidden = YES;
        }
        else
        {
            hyssbzcsmLabel.hidden = NO;
            hyssbzcsmField.hidden = NO;
        }
    }
    else if(sender.tag == 120)
    {
        if(sender.selectedSegmentIndex == 0)
        {
            wxfwzcbgfsmLabel.hidden = YES;
            wxfwzcbgfsmField.hidden = YES;
        }
        else
        {
            wxfwzcbgfsmLabel.hidden = NO;
            wxfwzcbgfsmField.hidden = NO;
        }
    }
    else if(sender.tag == 125)
    {
        if(sender.selectedSegmentIndex == 1)
        {
            cyqtwzbzLabel.hidden = NO;
            cyqtwzbzField.hidden = NO;
        }
        else
        {
            cyqtwzbzLabel.hidden = YES;
            cyqtwzbzField.hidden = YES;
        }
    }
}
@end
