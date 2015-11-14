//
//  UISearchSitesController.h
//  GMEPS_HZ
//
//  Created by chen on 11-10-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@protocol SelectSitesDelegate
-(void)returnSites:(NSDictionary*)values outsideComp:(BOOL)bOutside;
@end

@class WebServiceHelper;
@interface UISearchSitesController : BaseViewController
<UISearchBarDelegate,UISearchDisplayDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>{
   

    
    NSInteger totalCount;
    
}
@property(nonatomic,retain) NSMutableArray *dataResultArray;
@property (nonatomic, retain) IBOutlet UISearchBar *searchDataBar;
@property (nonatomic, strong) IBOutlet UITableView *wryTableView;

-(IBAction)outsideDBCompany:(id)sender;

@property (nonatomic, assign) id <SelectSitesDelegate> delegate;





@end
