//
//  JCXJView.h
//  GMEPS_HZ
//
//  Created by zhang on 13-4-7.
//
//

#import <UIKit/UIKit.h>

@interface JCXJView : UIView{
    IBOutlet UITextView *zsqkTxtView;//噪声
    IBOutlet UITextView *xjView;
    IBOutlet UITextView *bzView;
    
    //餐饮油烟净化设施
    IBOutlet UISegmentedControl *cyyyjhssSegCtrl;
    
    //餐饮油烟净化设施运行
    IBOutlet UISegmentedControl *cyyyjhssyxSegCtrl;
    IBOutlet UISwitch *cySwitch; //餐饮
    IBOutlet UILabel  *cyLabel;
    IBOutlet UITextField *cypwfjnField;//排污费缴纳
    //餐饮排污许可证
    IBOutlet UISegmentedControl *cypwxkzSegCtrl;
}
-(id)init;
-(NSDictionary*)getValueData;
-(void)loadData:(NSDictionary*)values;
-(IBAction)switchValChanged:(id)sender;
@end
