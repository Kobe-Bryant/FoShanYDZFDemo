//
//  DudelViewController.h
//  Dudel
//
//  Created by JN on 2/23/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "UISearchSitesController.h"
#import "Tool.h"
#import "DudelView.h"
#import "MBProgressHUD.h"

#import "CustomIconsViewController.h"
#import "UIGraphicToolsController.h"
#import "MapListViewController.h"
#import "BaseRecordViewController.h"
#import "UploadFileManager.h"

#define ALERT_RequestHisMap 1
#define ALERT_CommitMap     2
#define ALERT_REASEMAP      3
#define ALERT_CHOOSENEWWRY  4//重新选择污染源


#define IMG_COMPONET   1
#define LABEL_COMPONET 2
@interface UIMyImageView:UIImageView

@property(nonatomic,strong)NSString *name;
@end

@interface DrawKYTViewController : BaseRecordViewController <ToolDelegate, DudelViewDelegate,FileUploadDelegate,MBProgressHUDDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UITextViewDelegate,MapListDelegate,CustomIconDelegate,SelectGraphToolDelegate> {

   
    IBOutlet DudelView *dudelView;


    UIColor *strokeColor;
    UIColor *fillColor;
    CGFloat strokeWidth;

    UIBarButtonItem *commitBar;

    
    MBProgressHUD *HUD;
    
    NSInteger alertType;

    BOOL bHaveShowIcons;

    NSMutableArray *iconsAry;//存放界面上所画的图标
    
    
    NSMutableArray *deletedDrawInfoAry;
    
    NSMutableArray *textInfoAry;//存放输入的信息 UILabel 可拖动
    UITextView *curLabel;
    
    UIView *toModifyView;
    int toModifyType;

    BOOL             isTouchIn;
    BOOL             isSwitch;
    BOOL             isTwoFinger;
    CGPoint			 movePt;
    CGPoint          centerPoint;

    UploadFileManager *uploadManager;
}

@property (strong, nonatomic) id <Tool> currentTool;
@property (retain, nonatomic) UIColor *strokeColor;
@property (retain, nonatomic) UIColor *fillColor;
@property (assign, nonatomic) CGFloat strokeWidth;


@property (nonatomic, retain) NSMutableArray *iconsAry;
@property (nonatomic, retain) NSMutableArray *textInfoAry;

@property(nonatomic,retain)UIPopoverController *popController;
@property(nonatomic,retain)UIPopoverController *popGraphToolsController;

@property (nonatomic, strong) MapListViewController *mapListController;
@property (nonatomic, retain) UIPopoverController *popMapListController;



@property (nonatomic, retain)IBOutlet UIButton *textButton;
@property (nonatomic, retain)IBOutlet UIButton *eraserButton;
@property (nonatomic, retain)IBOutlet UIButton *redoButton;
@property (nonatomic, retain)IBOutlet UIButton *pensButton;
@property (nonatomic, retain)IBOutlet UIButton *iconsButton;
@property (nonatomic, retain)IBOutlet UIButton *undoButton;

@property (nonatomic, retain) IBOutlet UIButton *clearButton;

@property (nonatomic, retain) NSString *imName;

- (IBAction)touchTextItem:(id)sender;

- (IBAction)touchEraserItem:(id)sender;

- (IBAction)touchClearAllItem:(id)sender;
- (IBAction)touchImageItem:(id)sender;

- (IBAction)touchUndoItem:(id)sender;//撤销
- (IBAction)touchRedoItem:(id)sender;//重做


-(IBAction)touchTools:(id)sender; //选择画笔工具
@end

