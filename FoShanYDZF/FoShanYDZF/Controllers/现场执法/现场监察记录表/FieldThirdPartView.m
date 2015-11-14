//
//  FieldThirdPartView.m
//  FoShanYDZF
//
//  Created by PowerData on 13-11-4.
//  Copyright (c) 2013年 深圳市博安达软件开发有限公司. All rights reserved.
//

#import "FieldThirdPartView.h"
#import "PersonChooseVC.h"

@implementation FieldThirdPartView

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
    self = [[[NSBundle mainBundle] loadNibNamed:@"FieldThirdPartView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        [hbdajsqkSegment1 addTarget:self action:@selector(onSegmentClick:) forControlEvents:UIControlEventValueChanged];
        [xcjcryField addTarget:self action:@selector(choosePerson:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

-(void)loadData:(NSDictionary*)values
{
    //环保档案建设情况
    [self modifySeg:hbdajsqkSegment1 Value:[values objectForKey:@"HBDAJSQK"]];
    //其他情况
    [self setTextViewData:qtqkTextView andWithData:[values objectForKey:@"QTQK"]];
    //存在问题汇总
    [self setTextViewData:czwthzTextView andWithData:[values objectForKey:@"CZWTHZ"]];
    //现场监察结论
    [self setTextViewData:xcjcjlTextView andWithData:[values objectForKey:@"XCJCJL"]];
    //检查人员
    [self setTextFieldData:xcjcryField andWithData:[values objectForKey:@"JCR"]];
    [self setTextFieldData:zfzhField andWithData:[values objectForKey:@"ZFZH"]];
    //现场负责人
    [self setTextFieldData:xcfzrField andWithData:[values objectForKey:@"XCFZR"]];
    [self setTextFieldData:xcfzrzwField andWithData:[values objectForKey:@"ZW"]];
    [self setTextFieldData:xcfzrdhField andWithData:[values objectForKey:@"LXDH"]];
    [self setTextFieldData:xcfzrsfzhmField andWithData:[values objectForKey:@"SFZH"]];
}

-(NSDictionary *)getValueData
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[self getSegmentData:hbdajsqkSegment1] forKey:@"HBDAJSQK"];
    [dict setObject:[self getTextViewData:qtqkTextView] forKey:@"QTQK"];
    [dict setObject:[self getTextViewData:czwthzTextView] forKey:@"CZWTHZ"];
    [dict setObject:[self getTextViewData:xcjcjlTextView] forKey:@"XCJCJL"];
    [dict setObject:[self getTextFieldData:xcjcryField] forKey:@"JCR"];
    [dict setObject:[self getTextFieldData:zfzhField] forKey:@"ZFZH"];
    [dict setObject:[self getTextFieldData:xcfzrField] forKey:@"XCFZR"];
    [dict setObject:[self getTextFieldData:xcfzrzwField] forKey:@"ZW"];
    [dict setObject:[self getTextFieldData:xcfzrdhField] forKey:@"LXDH"];
    [dict setObject:[self getTextFieldData:xcfzrsfzhmField] forKey:@"SFZH"];
    return dict;
}

-(void)onSegmentClick:(UISegmentedControl *)sender
{
    
}

- (void)choosePerson:(id)sender
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
    xcjcryField.text = strSLRName;
    zfzhField.text = @"";//执法证号
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 105)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
