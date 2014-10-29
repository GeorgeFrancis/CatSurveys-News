//
//  MasterViewController.m
//  catsurveys news
//
//  Created by George Francis on 23/07/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController () {
    
    NSMutableArray *_objects;
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *description;
    NSString *element;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    feeds = [[NSMutableArray alloc]init];
    
    NSURL *url = [NSURL URLWithString:@"http://www.repeatserver.com/Users/catsurveys/newsFeed.xml"];
    parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    [self customiseTableView];

}

-(void)getFeed{
    
}

-(void)customiseTableView{
    
    //Set Background image
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenBackground.png"]];
    [tempImageView setFrame:self.tableView.frame];

    self.tableView.backgroundView = tempImageView;
    
    //Status bar Colour
     [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)layoutSubviews{
  //  [super layoutSubviews];
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
   
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.textColor = [UIColor grayColor];
   // [cell setBackgroundColor:[UIColor clearColor]];
}

-(void)makeShadowToView:(UIView*) view withHeight:(CGFloat)shadowHeight
{
    CGRect bounds = view.frame;
    bounds.size.height = shadowHeight;
    view.clipsToBounds = NO;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.9f;
    view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    view.layer.shadowRadius = 5.0f;
    view.layer.shadowPath = [UIBezierPath bezierPathWithRect:bounds].CGPath;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
    NSString *imageUrlString = [[feeds objectAtIndex:indexPath.row] objectForKey:@"link"];
    NSURL *url = [NSURL URLWithString:imageUrlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    cell.imageView.image = [UIImage imageWithData: data];
    cell.imageView.layer.borderWidth = 5.0f;
    cell.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    return cell;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        
        item =[[NSMutableDictionary alloc]init];
        title = [[NSMutableString alloc]init];
        description = [[NSMutableString alloc]init];
        link = [[NSMutableString alloc]init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
        
    }
    else if ([element isEqualToString:@"link"]){
        [link appendString:string];
        
    }
    else if ([element isEqualToString:@"description"]){
        [description appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"item"]) {
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:description forKey:@"description"];
        
        [feeds addObject:[item copy]];
    }
}

-(void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *string = [feeds [indexPath.row]objectForKey:@"link"];
        [[segue destinationViewController] setUrl:string];
        
        NSString *descriptionString = [feeds [indexPath.row]objectForKey:@"description"];
        [[segue destinationViewController] setDescription:descriptionString];
        
        NSString *titleFuck = [feeds [indexPath.row]objectForKey:@"title"];
        [[segue destinationViewController] setTitle:titleFuck];
    }
}



@end
