//
//  DetailViewController.m
//  catsurveys news
//
//  Created by George Francis on 23/07/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

//    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *myURL = [NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *data = [[NSData alloc] initWithContentsOfURL:myURL];
    self.imageViewForLink.image = [UIImage imageWithData:data];
    
    [self.descriptionTextWebView loadHTMLString:[NSString stringWithFormat:@"<div align='justify'>%@<div>",self.description] baseURL:nil];
    self.descriptionLabel.textAlignment = NSTextAlignmentJustified;
    [self.descriptionLabel sizeToFit];
    self.titleStringLabel.text = [NSString stringWithFormat:@"%@",self.title];
    UINavigationController *navCon  = (UINavigationController*) [self.navigationController.viewControllers objectAtIndex:1];
    navCon.navigationItem.title = @"";
}

- (IBAction)goToWebsite:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.cat-surveys.com"]];
}
@end
