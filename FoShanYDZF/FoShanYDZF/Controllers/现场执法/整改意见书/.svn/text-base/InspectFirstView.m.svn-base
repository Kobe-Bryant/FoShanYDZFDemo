//
//  InspectFirstView.m
//  FoShanYDZF
//
//  Created by 曾静 on 13-11-18.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "InspectFirstView.h"

@implementation InspectFirstView

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
    self = [[[NSBundle mainBundle] loadNibNamed:@"InspectFirstView" owner:self options:nil] objectAtIndex:0];
    if(self)
    {
        [self setLabel:self.hpsbLabel andWithHidden:self.hpspSwitch.on];
        [self setLabel:self.sscpfLabel andWithHidden:self.sscpfSwitch.on];
        [self setLabel:self.hbysLabel andWithHidden:self.hbysSwitch.on];
        [self setLabel:self.fqLabel andWithHidden:self.fqSwitch.on];
        [self setLabel:self.fsLabel andWithHidden:self.fsSwitch.on];
        [self setLabel:self.gfLabel andWithHidden:self.gfSwitch.on];
        
        if(self.scqkSeg.selectedSegmentIndex <= 3)
        {
            self.qtscqkLabel.hidden = YES;
            self.qtscqkField.hidden = YES;
        }
        
        [self.scqkSeg addTarget:self action:@selector(onSegmentClcik:) forControlEvents:UIControlEventValueChanged];
        [self.hpspSwitch addTarget:self action:@selector(onSwitchClick:) forControlEvents:UIControlEventValueChanged];
        [self.sscpfSwitch addTarget:self action:@selector(onSwitchClick:) forControlEvents:UIControlEventValueChanged];
        [self.hbysSwitch addTarget:self action:@selector(onSwitchClick:) forControlEvents:UIControlEventValueChanged];
        [self.fqSwitch addTarget:self action:@selector(onSwitchClick:) forControlEvents:UIControlEventValueChanged];
        [self.fsSwitch addTarget:self action:@selector(onSwitchClick:) forControlEvents:UIControlEventValueChanged];
        [self.gfSwitch addTarget:self action:@selector(onSwitchClick:) forControlEvents:UIControlEventValueChanged];
        
        [self.hpspsjField addTarget:self action:@selector(touchForDate:) forControlEvents:UIControlEventTouchDown];
        [self.hbyssjField addTarget:self action:@selector(touchForDate:) forControlEvents:UIControlEventTouchDown];
        [self.sscpfsjField addTarget:self action:@selector(touchForDate:) forControlEvents:UIControlEventTouchDown];
        [self.jcryField addTarget:self action:@selector(touchForPerson:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

- (void)onSegmentClcik:(UISegmentedControl *)sender
{
    if(sender.tag == 107)
    {
        if(sender.selectedSegmentIndex <= 3)
        {
            self.qtscqkLabel.hidden = YES;
            self.qtscqkField.hidden = YES;
        }
        else
        {
            self.qtscqkLabel.hidden = NO;
            self.qtscqkField.hidden = NO;
        }
    }
}

- (void)onSwitchClick:(UISwitch *)sender
{
    if(sender.tag == 111)
    {
        [self setLabel:self.hpsbLabel andWithHidden:self.hpspSwitch.on];
    }
    else if(sender.tag == 114)
    {
        [self setLabel:self.sscpfLabel andWithHidden:self.sscpfSwitch.on];
    }
    else if(sender.tag == 117)
    {
        [self setLabel:self.hbysLabel andWithHidden:self.hbysSwitch.on];
    }
    else if(sender.tag == 121)
    {
        [self setLabel:self.fqLabel andWithHidden:self.fqSwitch.on];
        if(!self.fqSwitch.on)
        {
            [self modifySeg:self.fqzlsSeg Value:@"1"];
            [self modifySeg:self.fqsfzcyxSeg Value:@"1"];
        }
    }
    else if(sender.tag == 124)
    {
        [self setLabel:self.fsLabel andWithHidden:self.fsSwitch.on];
        if(!self.fsSwitch.on)
        {
            [self modifySeg:self.fszlsSeg Value:@"1"];
            [self modifySeg:self.fssfzcyxSeg Value:@"1"];
        }
    }
    else if(sender.tag == 127)
    {
        [self setLabel:self.gfLabel andWithHidden:self.gfSwitch.on];
        if(!self.gfSwitch.on)
        {
            [self modifySeg:self.gfzlsSeg Value:@"1"];
            [self modifySeg:self.gfsfyfczSeg Value:@"1"];
        }
    }
}

- (void)setLabel:(UILabel *)lbl andWithHidden:(int)st
{
    if(st == 0)
    {
        lbl.hidden = NO;
    }
    else
    {
        lbl.hidden = YES;
    }
}

- (void)loadData:(NSDictionary *)values
{
    [self setTextFieldData:self.wrymcField andWithData:[values objectForKey:@"WRYMC"]];
    [self setTextFieldData:self.fzrField andWithData:[values objectForKey:@"FDDBR"]];
    [self setTextFieldData:self.lxfsField andWithData:[values objectForKey:@"FDDBRLXDH"]];
    [self setTextFieldData:self.dzField andWithData:[values objectForKey:@"WRYDZ"]];
    //检查人
    [self setTextFieldData:self.jcryField andWithData:[values objectForKey:@"JCR"]];
    //执法证号
    [self setTextFieldData:self.zfzhField andWithData:[values objectForKey:@"ZFZH"]];
    //生产情况
    [self modifySeg:self.scqkSeg Value:[values objectForKey:@"SCQK"]];
    if(self.scqkSeg.selectedSegmentIndex <= 3)
    {
        self.qtscqkLabel.hidden = YES;
        self.qtscqkField.hidden = YES;
    }
    else
    {
        self.qtscqkLabel.hidden = NO;
        self.qtscqkField.hidden = NO;
    }
    [self setTextFieldData:self.qtscqkField andWithData:[values objectForKey:@"QTSCQK"]];
    //工商执照
    [self modifySeg:self.gszzSeg Value:[values objectForKey:@"GSZZ"]];
    //新扩改建项目情况
    [self modifySeg:self.xkgjxmqkSeg Value:[values objectForKey:@"XKGJXMQK"]];
    
    //如果是0的话就表示勾选了,就是Switch为NO,Label Hidden NO
     
    int wsp = [[values objectForKey:@"WSP"] intValue];
    if(wsp == 0)
    {
        self.hpspSwitch.on = NO;
    }
    else
    {
        self.hpspSwitch.on = YES;
    }
    [self setLabel:self.hpsbLabel andWithHidden:wsp];
    
    int wys = [[values objectForKey:@"WYS"] intValue];
    if(wys == 0)
    {
        self.hbysSwitch.on = NO;
    }
    else
    {
        self.hbysSwitch.on = YES;
    }
    [self setLabel:self.hbysLabel andWithHidden:wys];
    
    int spf = [[values objectForKey:@"WPF"] intValue];
    if(spf == 0)
    {
        self.sscpfSwitch.on = NO;
    }
    else
    {
        self.sscpfSwitch.on = YES;
    }
    [self setLabel:self.sscpfLabel andWithHidden:spf];
    
    //环评审批文号
    [self setTextFieldData:self.hpspwhField andWithData:[values objectForKey:@"HPSPWH"]];
    //环评审批时间
    [self setTextFieldData:self.hpspsjField andWithData:[values objectForKey:@"HPSPSJ"]];
    //试生产文号
    [self setTextFieldData:self.sscwhField andWithData:[values objectForKey:@"SSCWH"]];
    //试生产时间
    [self setTextFieldData:self.sscpfsjField andWithData:[values objectForKey:@"SSCSJ"]];
    //环保验收文号
    [self setTextFieldData:self.hbyswhField andWithData:[values objectForKey:@"HBYSWH"]];
    //环保验收时间
    [self setTextFieldData:self.hbyssjField andWithData:[values objectForKey:@"HBYSSJ"]];
    //主要生产设备
    [self setTextFieldData:self.zyscsbField andWithData:[values objectForKey:@"ZYSCSB"]];
    
    //废气治理设施(0，1)
    [self modifySeg:self.fqzlsSeg Value:[values objectForKey:@"FQZLSS"]];
    //废气是否正常运行
    [self modifySeg:self.fqsfzcyxSeg Value:[values objectForKey:@"FQSFZCYX"]];
    if(self.fqzlsSeg.selectedSegmentIndex > 0 && self.fqsfzcyxSeg.selectedSegmentIndex > 0)
    {
        self.fqSwitch.on = NO;
        [self setLabel:self.fqLabel andWithHidden:NO];
    }
    
    //废水治理设施(0，1)
    [self modifySeg:self.fszlsSeg Value:[values objectForKey:@"FSZLSS"]];
    //废水是否正常运行(0，1)
    [self modifySeg:self.fssfzcyxSeg Value:[values objectForKey:@"FSSFZCYX"]];
    if(self.fszlsSeg.selectedSegmentIndex > 0 && self.fssfzcyxSeg.selectedSegmentIndex > 0)
    {
        self.fsSwitch.on = NO;
        [self setLabel:self.fsLabel andWithHidden:NO];
    }
    
    //固废治理设施(0，1)
    [self modifySeg:self.gfzlsSeg Value:[values objectForKey:@"GFZLSS"]];
    //固废是否正常运行(0，1)
    [self modifySeg:self.gfsfyfczSeg Value:[values objectForKey:@"GFSFZCYX"]];
    if(self.gfzlsSeg.selectedSegmentIndex > 0 && self.gfsfyfczSeg.selectedSegmentIndex > 0)
    {
        self.gfSwitch.on = NO;
        [self setLabel:self.gfLabel andWithHidden:NO];
    }
}

- (NSDictionary *)getValueData
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //污染源名称
    [params setObject:[self getTextFieldData:self.wrymcField] forKey:@"WRYMC"];
    //负责人
    [params setObject:[self getTextFieldData:self.fzrField] forKey:@"FDDBR"];
    //联系方式
    [params setObject:[self getTextFieldData:self.lxfsField] forKey:@"FDDBRLXDH"];
    //地址
    [params setObject:[self getTextFieldData:self.dzField] forKey:@"WRYDZ"];
    //检查人
    [params setObject:[self getTextFieldData:self.jcryField] forKey:@"JCR"];
    //执法证号
    [params setObject:[self getTextFieldData:self.zfzhField] forKey:@"ZFZH"];
    //生产情况
    [params setObject:[self getSegmentData:self.scqkSeg] forKey:@"SCQK"];
    [params setObject:[self getTextFieldData:self.qtscqkField] forKey:@"QTSCQK"];
    //工商执照
    [params setObject:[self getSegmentData:self.gszzSeg] forKey:@"GSZZ"];
    //新扩改建项目情况
    [params setObject:[self getSegmentData:self.xkgjxmqkSeg] forKey:@"XKGJXMQK"];
    
    if(self.hpspSwitch.on)
    {
        self.hpsbLabel.hidden = YES;
        [params setObject:@"1" forKey:@"WSP"];
        [params setObject:[self getTextFieldData:self.hpspwhField] forKey:@"HPSPWH"];//环评审批文号
        [params setObject:[self getTextFieldData:self.hpspsjField] forKey:@"HPSPSJ"];//环评审批时间
    }
    else
    {
        //没有通过环评审批
        self.hpsbLabel.hidden = NO;
        [params setObject:@"0" forKey:@"WSP"];
        [params setObject:@"" forKey:@"HPSPWH"];//环评审批文号
        [params setObject:@"" forKey:@"HPSPSJ"];//环评审批时间
    }
    
    if(self.hbysSwitch.on)
    {
        [params setObject:@"1" forKey:@"WYS"];
        self.hbysLabel.hidden = YES;
        [params setObject:[self getTextFieldData:self.hbyswhField] forKey:@"HBYSWH"];//环保验收文号
        [params setObject:[self getTextFieldData:self.hbyssjField] forKey:@"HBYSSJ"];//环保验收时间
    }
    else
    {
        //没有通过环保验收
        [params setObject:@"0" forKey:@"WYS"];
        self.hbysLabel.hidden = NO;
        [params setObject:@"" forKey:@"HBYSWH"];//环保验收文号
        [params setObject:@"" forKey:@"HBYSSJ"];//环保验收时间
    }
    
    if(self.sscpfSwitch.on)
    {
        [params setObject:@"1" forKey:@"WPF"];
        self.sscpfLabel.hidden = YES;
        [params setObject:[self getTextFieldData:self.sscwhField] forKey:@"SSCWH"];//环评审批文号
        [params setObject:[self getTextFieldData:self.sscpfsjField] forKey:@"SSCSJ"];//环评审批时间
    }
    else
    {
        //没有试生产批复
        self.sscpfLabel.hidden = NO;
        [params setObject:@"0" forKey:@"WPF"];
        [params setObject:@"" forKey:@"SSCWH"];
        [params setObject:@"" forKey:@"SSCSJ"];
    }
    
    //主要生产设备
    [params setObject:[self getTextFieldData:self.zyscsbField] forKey:@"ZYSCSB"];
    //废气治理设施(0，1)
    [params setObject:[self getSegmentData:self.fqzlsSeg] forKey:@"FQZLSS"];
    //废气是否正常运行
    [params setObject:[self getSegmentData:self.fqsfzcyxSeg] forKey:@"FQSFZCYX"];
    //废水治理设施(0，1)
    [params setObject:[self getSegmentData:self.fszlsSeg] forKey:@"FSZLSS"];
    //废水是否正常运行(0，1)
    [params setObject:[self getSegmentData:self.fssfzcyxSeg] forKey:@"FSSFZCYX"];
    //固废治理设施(0，1)
    [params setObject:[self getSegmentData:self.gfzlsSeg] forKey:@"GFZLSS"];
    //固废是否正常运行(0，1)
    [params setObject:[self getSegmentData:self.gfsfyfczSeg] forKey:@"GFSFZCYX"];
    return params;
}

#pragma mark - Event Handler Methods

- (void)touchForDate:(id)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    UIControl * btn =(UIControl*)sender;
    self.currentTag = btn.tag;
    self.dateController = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDateAndTime];
    self.dateController.delegate = self;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.dateController];
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	[self.popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)touchForPerson:(id)sender
{
    //隐藏键盘
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    UIControl *btn =(UIControl*)sender;
    PersonChooseVC *controller = [[PersonChooseVC alloc] initWithStyle:UITableViewStyleGrouped];
    controller.contentSizeForViewInPopover = CGSizeMake(320, 480);
	controller.delegate = self;
    controller.multiUsers = YES;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	[self.popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - Person Choose Delegate Method

-(void)personChoosed:(NSArray*)aryChoosed
{
    [self.popController dismissPopoverAnimated:YES];
    NSMutableString *strSLRName = [NSMutableString stringWithCapacity:20];
    for(NSDictionary *dicPerson in aryChoosed)
    {
        if([strSLRName length] == 0)
        {
            [strSLRName appendString:[dicPerson objectForKey:@"YHMC"]];
        }
        else
        {
            [strSLRName appendFormat:@",%@",[dicPerson objectForKey:@"YHMC"]];
        }
    }
    self.jcryField.text = strSLRName;
    self.zfzhField.text = @"";//执法证号
}

#pragma mark - PopupDataController Delegate Method

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date
{
    [self.popController dismissPopoverAnimated:YES];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    if(self.currentTag == 113)
    {
        self.hpspsjField.text = dateString;
    }
    else if (self.currentTag == 119)
    {
        self.hbyssjField.text = dateString;
    }
    else if (self.currentTag == 116)
    {
        self.sscpfsjField.text = dateString;
    }
}

#pragma mark - UITextField Delegate Method

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 113 || textField.tag == 116 || textField.tag == 119)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
