//
//  JCNRView.m
//  GMEPS_HZ
//
//  Created by zhang on 13-4-7.
//
//

#import "JCNRView.h"


@implementation JCNRView
@synthesize popController;
@synthesize fddbrField,dbrlxdhField,wrymcField,wrydzField;


-(id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"JCNRView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(NSDictionary*)getValueData{
    NSMutableDictionary *dicValues = [NSMutableDictionary dictionaryWithCapacity:5];
    [dicValues setValue:zycpField.text forKey:@"ZYCP"];
    
    [dicValues setValue:fddbrField.text forKey:@"FDDBR"];
    [dicValues setValue:dbrlxdhField.text forKey:@"FDDBRDH"];
    [dicValues setValue:jcdwField.text forKey:@"JCDW"];
    [dicValues setValue:wrymcField.text forKey:@"DWMC"];
    [dicValues setValue:wrydzField.text forKey:@"DWDZ"];
    [dicValues setValue:jcsjField.text forKey:@"JCSJ"];
    [dicValues setValue:[gllbSegCtrl titleForSegmentAtIndex:gllbSegCtrl.selectedSegmentIndex] forKey:@"GLLB"];
    
    [dicValues setValue:[scqkSegCtrl titleForSegmentAtIndex:scqkSegCtrl.selectedSegmentIndex] forKey:@"SCQK"];
    [dicValues setValue:[scsbSegCtrl titleForSegmentAtIndex:scsbSegCtrl.selectedSegmentIndex] forKey:@"SCSB"];
    [dicValues setValue:[qyhbglzdSegCtrl titleForSegmentAtIndex:qyhbglzdSegCtrl.selectedSegmentIndex] forKey:@"QYHBGLZD"];
    [dicValues setValue:[wryssczgcSegCtrl titleForSegmentAtIndex:wryssczgcSegCtrl.selectedSegmentIndex] forKey:@"WRYSSCZGC"];
    
    if(wsSwitch.on){ //污水
        [dicValues setValue:[wsssyxjlSegCtrl titleForSegmentAtIndex:wsssyxjlSegCtrl.selectedSegmentIndex] forKey:@"WSSSYXJL"];
        [dicValues setValue:[wsclssyxSegCtrl titleForSegmentAtIndex:wsclssyxSegCtrl.selectedSegmentIndex] forKey:@"WSCLSSYX"];
        [dicValues setValue:[wspfkgfhSegCtrl titleForSegmentAtIndex:wspfkgfhSegCtrl.selectedSegmentIndex] forKey:@"WSPFKGFH"];
        [dicValues setValue:[wsyjtjSegCtrl titleForSegmentAtIndex:wsyjtjSegCtrl.selectedSegmentIndex] forKey:@"WSYJTJ"];
        [dicValues setValue:pfszggmsField.text forKey:@"PFSZGGMS"];
        [dicValues setValue:[xcsfcySegCtrl titleForSegmentAtIndex:xcsfcySegCtrl.selectedSegmentIndex] forKey:@"XCSFCY"];
        
    }
    
    if(fqSwitch.on){//废气
        [dicValues setValue:[fqpfkgfhSegCtrl titleForSegmentAtIndex:fqpfkgfhSegCtrl.selectedSegmentIndex] forKey:@"FQPFKGFH"];
        
        [dicValues setValue:[fqssyxjlSegCtrl titleForSegmentAtIndex:fqssyxjlSegCtrl.selectedSegmentIndex] forKey:@"FQSSYXJL"];
        [dicValues setValue:[fqyjtjSegCtrl titleForSegmentAtIndex:fqyjtjSegCtrl.selectedSegmentIndex] forKey:@"FQYJTJ"];
         [dicValues setValue:[yqhdSegCtrl titleForSegmentAtIndex:yqhdSegCtrl.selectedSegmentIndex] forKey:@"YQHD"];
        [dicValues setValue:[fqclssyxSegCtrl titleForSegmentAtIndex:fqclssyxSegCtrl.selectedSegmentIndex] forKey:@"FQCLSSYX"];
        [dicValues setValue:[gyfqwzzpfSegCtrl titleForSegmentAtIndex:gyfqwzzpfSegCtrl.selectedSegmentIndex] forKey:@"GYFQWZZPF"];
        
    }
    
    if(wxfwSwitch.on){
        [dicValues setValue:wfmcField.text forKey:@"WFMC"];
        [dicValues setValue:[sfssSegCtrl titleForSegmentAtIndex:sfssSegCtrl.selectedSegmentIndex] forKey:@"SFSS"];
        [dicValues setValue:[bzbsSegCtrl titleForSegmentAtIndex:bzbsSegCtrl.selectedSegmentIndex] forKey:@"BZBS"];
         [dicValues setValue:[zyldSegCtrl titleForSegmentAtIndex:zyldSegCtrl.selectedSegmentIndex] forKey:@"ZYLD"];
    }
    
   
    return dicValues;

}

-(void)modifySeg:(UISegmentedControl*)segCtrl Value:(NSString*)value{
    if (value == nil) {
        return;
    }
    for (int i = 0; i < segCtrl.numberOfSegments; i++) {
        if([[segCtrl titleForSegmentAtIndex:i] isEqualToString:value]){
            segCtrl.selectedSegmentIndex = i;
            break;
        }
    }
}

-(void)loadData:(NSDictionary*)values{
    zycpField.text = [NSString stringWithFormat:@"%@", [values objectForKey:@"ZYCP"]];
    pfszggmsField.text = [values objectForKey:@"PFSZGGMS"];
    wfmcField.text = [NSString stringWithFormat:@"%@",[values objectForKey:@"WFMC"]];
    

    
    fddbrField.text = [NSString stringWithFormat:@"%@",[values objectForKey:@"FDDBR"]];
    dbrlxdhField.text = [NSString stringWithFormat:@"%@",[values objectForKey:@"FDDBRDH"]];
    jcdwField.text = [NSString stringWithFormat:@"%@",[values objectForKey:@"JCDW"]];
    wrymcField.text = [NSString stringWithFormat:@"%@",[values objectForKey:@"DWMC"]];
    wrydzField.text = [NSString stringWithFormat:@"%@",[values objectForKey:@"DWDZ"]];
    jcsjField.text = [NSString stringWithFormat:@"%@",[values objectForKey:@"JCSJ"]];
    [self modifySeg:gllbSegCtrl Value:[values objectForKey:@"GLLB"]];
    
    [self modifySeg:scqkSegCtrl Value:[values objectForKey:@"SCQK"]];
    [self modifySeg:scsbSegCtrl Value:[values objectForKey:@"SCSB"]];
    [self modifySeg:qyhbglzdSegCtrl Value:[values objectForKey:@"QYHBGLZD"]];
    [self modifySeg:wryssczgcSegCtrl Value:[values objectForKey:@"WRYSSCZGC"]];

    [self modifySeg:wsclssyxSegCtrl Value:[values objectForKey:@"WSCLSSYX"]];    
    [self modifySeg:wspfkgfhSegCtrl Value:[values objectForKey:@"WSPFKGFH"]];
    
    
    [self modifySeg:wsssyxjlSegCtrl Value:[values objectForKey:@"WSSSYXJL"]];
    [self modifySeg:fqyjtjSegCtrl Value:[values objectForKey:@"FQYJTJ"]];
    [self modifySeg:xcsfcySegCtrl Value:[values objectForKey:@"XCSFCY"]];
    [self modifySeg:yqhdSegCtrl Value:[values objectForKey:@"YQHD"]];
    [self modifySeg:gyfqwzzpfSegCtrl Value:[values objectForKey:@"GYFQWZZPF"]];
    [self modifySeg:sfssSegCtrl Value:[values objectForKey:@"SFSS"]];    
    [self modifySeg:zyldSegCtrl Value:[values objectForKey:@"ZYLD"]];
    [self modifySeg:bzbsSegCtrl Value:[values objectForKey:@"BZBS"]];
   
    [self modifySeg:fqclssyxSegCtrl Value:[values objectForKey:@"FQCLSSYX"]];    
    [self modifySeg:fqpfkgfhSegCtrl Value:[values objectForKey:@"FQPFKGFH"]];
    [self modifySeg:wsyjtjSegCtrl   Value:[values objectForKey:@"WSYJTJ"]];
    [self modifySeg:fqssyxjlSegCtrl Value:[values objectForKey:@"FQSSYXJL"]];
    
    if([values objectForKey:@"WSSSYXJL"] == nil || [[values objectForKey:@"WSSSYXJL"] length] == 0){
        wsSwitch.on = NO;
        wsLabel.hidden = NO;
    }
    if([values objectForKey:@"FQPFKGFH"] == nil || [[values objectForKey:@"FQPFKGFH"] length] == 0){
        fqSwitch.on = NO;
        fqLabel.hidden = NO;
    }
   
    if([values objectForKey:@"SFSS"] == nil || [[values objectForKey:@"SFSS"] length] == 0){
        wxfwSwitch.on = NO;
        wxfwLabel.hidden = NO;
    }
    
}

- (IBAction)touchForDate:(id)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    UIControl *btn =(UIControl*)sender;
    self.dateController = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDateAndTime];
    self.dateController.delegate = self;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.dateController];
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	[self.popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date
{
    [popController dismissPopoverAnimated:YES];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    jcsjField.text = dateString;
}

-(IBAction)switchValChanged:(id)sender{
    if([sender isEqual:wsSwitch]){
         wsLabel.hidden = wsSwitch.on;
    }
    else if([sender isEqual:fqSwitch]){
        fqLabel.hidden = fqSwitch.on;
    }
    else if([sender isEqual:wxfwSwitch]){
        wxfwLabel.hidden = wxfwSwitch.on;
    }
}

@end
