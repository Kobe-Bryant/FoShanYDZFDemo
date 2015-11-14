//
//  FieldFirstPartView.m
//  FoShanYDZF
//
//  Created by PowerData on 13-11-4.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "FieldFirstPartView.h"

@implementation FieldFirstPartView
@synthesize bjcdwField, frdbField, frdhField, dzField;
@synthesize dateController, popController;

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
    self = [[[NSBundle mainBundle] loadNibNamed:@"FieldFirstPartView" owner:self options:nil] objectAtIndex:0];
    if (self)
    {
        [sfyhpspSegment addTarget:self action:@selector(onSegmentClick:) forControlEvents:UIControlEventValueChanged];
        [sfstsysSegment addTarget:self action:@selector(onSegmentClick:) forControlEvents:UIControlEventValueChanged];
        [sfzkjSegment addTarget:self action:@selector(onSegmentClick:) forControlEvents:UIControlEventValueChanged];
        [pwxkzqkSegment1 addTarget:self action:@selector(onSegmentClick:) forControlEvents:UIControlEventValueChanged];
        [cjscqkSegment addTarget:self action:@selector(onSegmentClick:) forControlEvents:UIControlEventValueChanged];
        
        [jcsjField addTarget:self action:@selector(touchFromDate:) forControlEvents:UIControlEventTouchDown];//检查时间
        [stsyssjField addTarget:self action:@selector(touchFromDate:) forControlEvents:UIControlEventTouchDown];//三同时验收时间
        [hpspsjField addTarget:self action:@selector(touchFromDate:) forControlEvents:UIControlEventTouchDown];//环评审批时间
        
        if(cjscqkSegment.selectedSegmentIndex != 0)
        {
            cjfzcscLabel.hidden = NO;
            cjfzcscField.hidden = NO;
        }
        else
        {
            cjfzcscLabel.hidden = YES;
            cjfzcscField.hidden = YES;
        }
    }
    return self;
}

-(void)loadData:(NSDictionary*)values
{
    [self setTextFieldData:bjcdwField andWithData:[values objectForKey:@"WRYMC"]];
    [self setTextFieldData:dzField andWithData:[values objectForKey:@"WRYDZ"]];
    //检查时间
    NSString *zfsjStr = [values objectForKey:@"ZFSJ"];
    if(zfsjStr.length == 0 || zfsjStr == nil)
    {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *now = [NSDate date];
        NSString *nowStr = [df stringFromDate:now];
        [self setTextFieldData:jcsjField andWithData:nowStr];
    }
    else
    {
        [self setTextFieldData:jcsjField andWithData:[values objectForKey:@"ZFSJ"]];
    }
    //法定代表人
    [self setTextFieldData:frdbField andWithData:[values objectForKey:@"FDDBR"]];
    [self setTextFieldData:frdhField andWithData:[values objectForKey:@"FDDBRDH"]];
    //执法证件
    [self modifySeg:zfzjSegment Value:[values objectForKey:@"SFCSZJ"]];
    //告知当事人
    [self modifySeg:gzhbSegment Value:[values objectForKey:@"SFGZ"]];
    //监管性质
    [self modifySeg:jgxzSegment Value:[values objectForKey:@"JGXZ"]];
    //环评审批时间
    [self modifySeg:sfyhpspSegment Value:[values objectForKey:@"SFHPSP"]];
    if(sfyhpspSegment.selectedSegmentIndex == 1)
    {
        hpspsjLabel.hidden = YES;
        hpspsjField.hidden = YES;
    }
    else
    {
        hpspsjLabel.hidden = NO;
        hpspsjField.hidden = NO;
    }
    [self setTextFieldData:hpspsjField andWithData:[values objectForKey:@"HPSPSJ"]];
    //三同时验收
    [self modifySeg:sfstsysSegment Value:[values objectForKey:@"SFHPYS"]];
    if(sfstsysSegment.selectedSegmentIndex == 1)
    {
        stsyssjLabel.hidden = YES;
        stsyssjField.hidden = YES;
    }
    else
    {
        stsyssjLabel.hidden = NO;
        stsyssjField.hidden = NO;
    }
    [self setTextFieldData:stsyssjField andWithData:[values objectForKey:@"HPYSSJ"]];
    //主要审批生产设备
    [self setTextFieldData:zyspscsbField andWithData:[values objectForKey:@"ZYSPSCSP"]];
    //扩建设备
    [self modifySeg:sfzkjSegment Value:[values objectForKey:@"SFCZKJ"]];
    if(sfzkjSegment.selectedSegmentIndex == 1)
    {
        kjsbLabel.hidden = YES;
        kssbField.hidden = YES;
    }
    else
    {
        kjsbLabel.hidden = NO;
        kssbField.hidden = NO;
    }
    [self setTextFieldData:kssbField andWithData:[values objectForKey:@"KJSB"]];
    //生产工艺
    [self setTextFieldData:scgyField andWithData:[values objectForKey:@"SCGY"]];
    //排污许可证情况
    [self modifySeg:pwxkzqkSegment1 Value:[values objectForKey:@"PWXKZQK"]];
    if(pwxkzqkSegment1.selectedSegmentIndex == 1)
    {
        pwxkzLabel.hidden = YES;
        pwxkzqkSegment2.hidden = YES;
    }
    else
    {
        pwxkzLabel.hidden = NO;
        pwxkzqkSegment2.hidden = NO;
    }
    [self modifySeg:pwxkzqkSegment2 Value:[values objectForKey:@"PWXKZQK1"]];
    //应急预案情况
    [self modifySeg:yjyaqkSegment Value:[values objectForKey:@"YJYAQK"]];
    //车间生产情况
    [self modifySeg:cjscqkSegment Value:[values objectForKey:@"CJSCQK"]];
    if(cjscqkSegment.selectedSegmentIndex != 0)
    {
        cjfzcscLabel.hidden = NO;
        cjfzcscField.hidden = NO;
    }
    else
    {
        cjfzcscLabel.hidden = YES;
        cjfzcscField.hidden = YES;
    }
    [self setTextFieldData:cjfzcscField andWithData:[values objectForKey:@"FZCSCSM"]];
    //废水类
    [self modifySeg:fsyzqkSegment Value:[values objectForKey:@"FSYZQK"]];
    [self modifySeg:fstzjlqkSegment Value:[values objectForKey:@"FSYXJLQK"]];
    [self modifySeg:fspwgdbsqkSegment Value:[values objectForKey:@"FSPWGDBSQK"]];
    [self modifySeg:fsxgczgcSegment Value:[values objectForKey:@"FSXGGYLCT"]];
    [self modifySeg:fsxgpwkbzpSegment Value:[values objectForKey:@"FSXGPWKBZP"]];
}

-(NSDictionary *)getValueData
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[self getTextFieldData:bjcdwField] forKey:@"WRYMC"];
    [dict setObject:[self getTextFieldData:dzField] forKey:@"WRYDZ"];
    //法定代表人
    [dict setObject:[self getTextFieldData:frdbField] forKey:@"FDDBR"];
    [dict setObject:[self getTextFieldData:frdhField] forKey:@"FDDBRDH"];
    //检查时间
    NSString *zfsjStr = [self getTextFieldData:jcsjField];
    if(zfsjStr.length == 0 || zfsjStr == nil)
    {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *now = [NSDate date];
        zfsjStr = [df stringFromDate:now];
    }
    [dict setObject:zfsjStr forKey:@"ZFSJ"];
    //执法证件
    [dict setObject:[self getSegmentData:zfzjSegment] forKey:@"SFCSZJ"];
    //告知当事人
    [dict setObject:[self getSegmentData:gzhbSegment] forKey:@"SFGZ"];
    //监管性质
    [dict setObject:[self getSegmentData:jgxzSegment] forKey:@"JGXZ"];
    //环评审批时间
    [dict setObject:[self getSegmentData:sfyhpspSegment] forKey:@"SFHPSP"];
    [dict setObject:[self getTextFieldData:hpspsjField] forKey:@"HPSPSJ"];
    //三同时
    [dict setObject:[self getSegmentData:sfstsysSegment] forKey:@"SFHPYS"];
    [dict setObject:[self getTextFieldData:stsyssjField] forKey:@"HPYSSJ"];
    //主要审批生产设备
    [dict setObject:[self getTextFieldData:zyspscsbField] forKey:@"ZYSPSCSP"];
    //扩建设备
    [dict setObject:[self getSegmentData:sfzkjSegment] forKey:@"SFCZKJ"];
    [dict setObject:[self getTextFieldData:kssbField] forKey:@"KJSB"];
    //生产工艺
    [dict setObject:[self getTextFieldData:scgyField] forKey:@"SCGY"];
    //排污许可证情况
    [dict setObject:[self getSegmentData:pwxkzqkSegment1] forKey:@"PWXKZQK"];
    //应急预案情况
    [dict setObject:[self getSegmentData:yjyaqkSegment] forKey:@"YJYAQK"];
    //车间生产情况
    [dict setObject:[self getSegmentData:cjscqkSegment] forKey:@"CJSCQK"];
    [dict setObject:[self getTextFieldData:cjfzcscField] forKey:@"FZCSCSM"];
    //废水类
    [dict setObject:[self getSegmentData:fsyzqkSegment] forKey:@"FSYZQK"];
    [dict setObject:[self getSegmentData:fstzjlqkSegment] forKey:@"FSYXJLQK"];
    [dict setObject:[self getSegmentData:fspwgdbsqkSegment] forKey:@"FSPWGDBSQK"];
    [dict setObject:[self getSegmentData:fsxgczgcSegment] forKey:@"FSXGGYLCT"];
    [dict setObject:[self getSegmentData:fsxgpwkbzpSegment] forKey:@"FSXGPWKBZP"];
    return dict;
}

-(void)onSegmentClick:(UISegmentedControl *)sender
{
    if(sender.tag == 108)
    {
        if(sender.selectedSegmentIndex == 1)
        {
            hpspsjLabel.hidden = YES;
            hpspsjField.hidden = YES;
        }
        else
        {
            hpspsjLabel.hidden = NO;
            hpspsjField.hidden = NO;
        }
    }
    else if(sender.tag == 111)
    {
        if(sender.selectedSegmentIndex == 1)
        {
            stsyssjLabel.hidden = YES;
            stsyssjField.hidden = YES;
        }
        else
        {
            stsyssjLabel.hidden = NO;
            stsyssjField.hidden = NO;
        }
    }
    else if(sender.tag == 113)
    {
        if(sender.selectedSegmentIndex == 1)
        {
            kjsbLabel.hidden = YES;
            kssbField.hidden = YES;
        }
        else
        {
            kjsbLabel.hidden = NO;
            kssbField.hidden = NO;
        }
    }
    else if(sender.tag == 116)
    {
        if(sender.selectedSegmentIndex == 1)
        {
            pwxkzLabel.hidden = YES;
            pwxkzqkSegment2.hidden = YES;
        }
        else
        {
            pwxkzLabel.hidden = NO;
            pwxkzqkSegment2.hidden = NO;
        }
    }
    else if(sender.tag == 119)
    {
        if(sender.selectedSegmentIndex != 0)
        {
            cjfzcscLabel.hidden = NO;
            cjfzcscField.hidden = NO;
        }
        else
        {
            cjfzcscLabel.hidden = YES;
            cjfzcscField.hidden = YES;
        }
    }
}

-(void)touchFromDate:(id)sender
{
	UIControl *btn =(UIControl*)sender;
    PopupDateViewController *tmpdate = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDateAndTime];
	self.dateController = tmpdate;
	dateController.delegate = self;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	[popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	currentTag = btn.tag;
}

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date
{
	[popController dismissPopoverAnimated:YES];
	if (bSaved)
    {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
		NSString *dateString = [dateFormatter stringFromDate:date];
		switch (currentTag)
        {
			case 109:
				hpspsjField.text = dateString;
				break;
            case 105:
				jcsjField.text = dateString;
				break;
            case 112:
                stsyssjField.text = dateString;
                break;
			default:
				break;
		}
	}
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 105 || textField.tag == 109 || textField.tag == 112)
    {
        return NO;
    }
    return YES;
}

@end
