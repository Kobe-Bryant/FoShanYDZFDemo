//
//  JCNRView.h
//  GMEPS_HZ
//
//  Created by zhang on 13-4-7.
//
//

#import <UIKit/UIKit.h>
#import "PopupDateViewController.h"

@interface JCNRView : UIView<PopupDateDelegate>{
    //生产情况
    IBOutlet UISegmentedControl *scqkSegCtrl;
    //生产设备跑冒滴漏
    IBOutlet UISegmentedControl *scsbSegCtrl;
    
    //企业环保管理制度
    IBOutlet UISegmentedControl *qyhbglzdSegCtrl;
    
    //污染设施操作规程
    IBOutlet UISegmentedControl *wryssczgcSegCtrl;
    
    //污水处理设施运行
    IBOutlet UISegmentedControl *wsclssyxSegCtrl;
    
    //污水排放口规范化
    IBOutlet UISegmentedControl *wspfkgfhSegCtrl;
    
    //污水设施运行纪录
    IBOutlet UISegmentedControl  *wsssyxjlSegCtrl;
    
    //污水药剂添加
    IBOutlet UISegmentedControl *wsyjtjSegCtrl;
    
    //现场是否采样
    IBOutlet UISegmentedControl *xcsfcySegCtrl;
    
    //废气处理设施运行
    IBOutlet UISegmentedControl *fqclssyxSegCtrl;
    
    //废气排放口规范化
    IBOutlet UISegmentedControl *fqpfkgfhSegCtrl;
    
    //废气设施运行纪录
    IBOutlet UISegmentedControl *fqssyxjlSegCtrl;
    
    //废气药剂添加
    IBOutlet UISegmentedControl *fqyjtjSegCtrl;
    
    //烟气黑度
    IBOutlet UISegmentedControl *yqhdSegCtrl;
    
    //工艺废气无组织排放
    IBOutlet UISegmentedControl *gyfqwzzpfSegCtrl;
    
    //三防措施
    IBOutlet UISegmentedControl *sfssSegCtrl;
    
    //转移联单
    IBOutlet UISegmentedControl *zyldSegCtrl;
    
    //标志标识
    IBOutlet UISegmentedControl *bzbsSegCtrl;
    
    
    
    
    
    IBOutlet UITextField *zycpField;//主要产品
    IBOutlet UITextField *pfszggmsField;//排污水质感官描述
    IBOutlet UITextField *wfmcField;//危险废物名称
    
    IBOutlet UITextField *fddbrField;//法定代表人
    IBOutlet UITextField *dbrlxdhField;//代表人电话
    IBOutlet UITextField *jcdwField;//检查单位
    IBOutlet UITextField *wrymcField;//被检查单位名称
     IBOutlet UITextField *wrydzField;//污染源地址
    //管理类别
     IBOutlet UISegmentedControl *gllbSegCtrl;
    IBOutlet UITextField *jcsjField;

    
    IBOutlet UISwitch *wsSwitch; //污水
    IBOutlet UISwitch *fqSwitch; //废气
    IBOutlet UISwitch *wxfwSwitch; //危险废物
    
    IBOutlet UILabel  *wsLabel;
    IBOutlet UILabel  *fqLabel;
    IBOutlet UILabel  *wxfwLabel;
    
    
}
@property (nonatomic, strong) UIPopoverController *popController;
@property (nonatomic, strong) PopupDateViewController *dateController;
@property(nonatomic,retain) UITextField *fddbrField;//法定代表人
@property(nonatomic,retain) UITextField *dbrlxdhField;//代表人电话
@property(nonatomic,retain) UITextField *wrymcField;//被检查单位名称
@property(nonatomic,retain) UITextField *wrydzField;//污染源地址
-(id)init;
-(NSDictionary*)getValueData;
-(void)loadData:(NSDictionary*)values;
-(IBAction)switchValChanged:(id)sender;
-(IBAction)touchForDate:(id)sender;
@end
