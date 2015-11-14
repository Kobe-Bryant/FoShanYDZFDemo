//
//  JCXJView.m
//  GMEPS_HZ
//
//  Created by zhang on 13-4-7.
//
//

#import "JCXJView.h"

@interface JCXJView()

@end

@implementation JCXJView


-(id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"JCXJView" owner:self options:nil] objectAtIndex:0];
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
    [dicValues setValue:xjView.text forKey:@"JCXJ"];
    [dicValues setValue:bzView.text forKey:@"BZ"];
    [dicValues setValue:zsqkTxtView.text forKey:@"ZSQK"];
    
    if(cySwitch.on){
        [dicValues setValue:[cyyyjhssSegCtrl titleForSegmentAtIndex:cyyyjhssSegCtrl.selectedSegmentIndex] forKey:@"CYYYJHSS"];
        [dicValues setValue:[cyyyjhssyxSegCtrl titleForSegmentAtIndex:cyyyjhssyxSegCtrl.selectedSegmentIndex] forKey:@"CYYYJHSSYX"];
        [dicValues setValue:[cypwxkzSegCtrl titleForSegmentAtIndex:cypwxkzSegCtrl.selectedSegmentIndex] forKey:@"CYPWXKZ"];
        [dicValues setValue:cypwfjnField.text forKey:@"CYPWFJN"];
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
    xjView.text = [values objectForKey:@"JCXJ"];
    bzView.text = [values objectForKey:@"BZ"];
    zsqkTxtView.text = [values objectForKey:@"ZSQK"];
    cypwfjnField.text = [NSString stringWithFormat:@"%@",[values objectForKey:@"CYPWFJN"]];
    
    [self modifySeg:cyyyjhssSegCtrl Value:[values objectForKey:@"CYYYJHSS"]];
    
    [self modifySeg:cyyyjhssyxSegCtrl Value:[values objectForKey:@"CYYYJHSSYX"]];
    [self modifySeg:cypwxkzSegCtrl Value:[values objectForKey:@"CYPWXKZ"]];
    if([values objectForKey:@"CYYYJHSS"] == nil || [[values objectForKey:@"CYYYJHSS"] length] == 0){
        cySwitch.on = NO;
        cyLabel.hidden = NO;
    }
}


-(IBAction)switchValChanged:(id)sender{
    if([sender isEqual:cySwitch]){
        cyLabel.hidden = cySwitch.on;
    }
    
}
@end
