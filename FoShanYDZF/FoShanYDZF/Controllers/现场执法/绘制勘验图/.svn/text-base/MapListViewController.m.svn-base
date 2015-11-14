//
//  MapListControllerView.m
//  GMEPS_HZ
//
//  Created by Apple on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MapListViewController.h"



@implementation MapListViewController
@synthesize webservice;
@synthesize QYBH,QYMC;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)cancelPressed {
    //[delegate returnSelectedMap:@"取消"];
    [delegate returnSelectedMap:@"取消" flag:@""];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    					 
	HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	
    // Regisete for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;	
    HUD.labelText = @"正在获取该企业历史勘验图列表，请稍候...";
	[HUD show:YES];

    UIBarButtonItem *aItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(cancelPressed)];
    self.navigationItem.rightBarButtonItem = aItem;

    
    mcAry = [[NSMutableArray alloc] initWithCapacity:100];
    dcjssjAry = [[NSMutableArray alloc] initWithCapacity:100];
    jcrAry = [[NSMutableArray alloc] initWithCapacity:100];
    xczfbhAry = [[NSMutableArray alloc] initWithCapacity:100];
    isajAry = [[NSMutableArray alloc] initWithCapacity:100];
    flagAry = [[NSMutableArray alloc] initWithCapacity:100];
    

 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}



#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"          企业名称                           执法人员          执法时间                是否案卷"; 
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [xczfbhAry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 45;
}

- (UITableViewCell*) getCell:(NSString*) CellIdentifier forTablieView:(UITableView*) tableView
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	return cell;
}

-(UITableViewCell*)makeSubCell:(UITableView *)tableView
					 withTitle:(NSString *)aTitle
						 value:(NSString *)aValue
                        endDate:(NSString*)date
                        isaj:(NSString*)aj
{
	UILabel* lblTitle = nil;
	UILabel* lblValue = nil;
    UILabel* lblIsan = nil;
	UILabel* lblEndDate = nil;
	UITableViewCell* aCell = [self getCell:@"Cell_resultTable" forTablieView:tableView];
	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lblValue = (UILabel *)[aCell.contentView viewWithTag:2];
        lblEndDate = (UILabel *)[aCell.contentView viewWithTag:3];
        lblIsan = (UILabel *)[aCell.contentView viewWithTag:4];
		
	}
	
	if (lblTitle == nil) {
		CGRect tRect = CGRectMake(10, 0, 260, 38);
		lblTitle = [[UILabel alloc] initWithFrame:tRect]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor blackColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblTitle.textAlignment = UITextAlignmentLeft;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];

		CGRect tRect1 = CGRectMake(268, 0, 100, 38);
		lblValue = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[lblValue setBackgroundColor:[UIColor clearColor]];
		[lblValue setTextColor:[UIColor blackColor]];
		lblValue.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblValue.textAlignment = UITextAlignmentLeft;;
		lblValue.tag = 2;	
		[aCell.contentView addSubview:lblValue];

        
        CGRect tRect2 = CGRectMake(353, 0, 150, 38);
		lblEndDate = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lblEndDate setBackgroundColor:[UIColor clearColor]];
		[lblEndDate setTextColor:[UIColor blackColor]];
		lblEndDate.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblEndDate.textAlignment = UITextAlignmentLeft;;
		lblEndDate.tag = 3;	
		[aCell.contentView addSubview:lblEndDate];

        
        CGRect tRect3 = CGRectMake(540, 0, 100, 38);
		lblIsan = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lblIsan setBackgroundColor:[UIColor clearColor]];
		[lblIsan setTextColor:[UIColor blackColor]];
		lblIsan.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblIsan.textAlignment = UITextAlignmentLeft;
		lblIsan.tag = 4;	
		[aCell.contentView addSubview:lblIsan];

	}
	
	if (lblTitle != nil)	[lblTitle setText:aTitle];
	if (lblValue != nil)	[lblValue setText:aValue];
    if (lblEndDate != nil)	[lblEndDate setText:date];
	if (lblIsan != nil)	[lblIsan setText:aj];

	
    if ([aValue isEqualToString:@"0"]||[aValue isEqualToString:@""]) {
        aCell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	return aCell;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSString *aTitle = [mcAry objectAtIndex:row];
    NSString *value = [jcrAry objectAtIndex:row];
    NSString *endDate = [dcjssjAry objectAtIndex:row];
    NSString *aj = [isajAry objectAtIndex:row];
    
    endDate = [endDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
	UITableViewCell *cell = [self makeSubCell:tableView withTitle:aTitle value:value endDate:endDate isaj:aj];
    
	cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	cell.backgroundView.frame = cell.bounds;
	cell.textLabel.backgroundColor = [UIColor clearColor];
    
	return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [delegate returnSelectedMap:[xczfbhAry objectAtIndex:[indexPath row]] flag:[flagAry objectAtIndex:[indexPath row]]];
}

@end
