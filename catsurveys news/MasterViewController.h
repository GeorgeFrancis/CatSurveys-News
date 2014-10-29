//
//  MasterViewController.h
//  catsurveys news
//
//  Created by George Francis on 23/07/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AppDelegate.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSXMLParserDelegate, UITableViewDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
