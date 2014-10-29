//
//  DetailViewController.h
//  catsurveys news
//
//  Created by George Francis on 23/07/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (copy, nonatomic) NSString *url;

@property (copy, nonatomic) NSString *description;

@property (copy, nonatomic) NSString *title;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewForLink;

@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (strong, nonatomic) IBOutlet UILabel *titleStringLabel;

@property (strong, nonatomic) IBOutlet UIWebView *descriptionTextWebView;
@property (strong, nonatomic) IBOutlet UIWebView *imageWebView;

- (IBAction)goToWebsite:(id)sender;
@end
