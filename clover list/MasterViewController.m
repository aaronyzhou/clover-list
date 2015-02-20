//
//  MasterViewController.m
//  clover list
//
//  Created by Aaron Zhou on 2/19/15.
//  Copyright (c) 2015 Aaron Zhou. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "NetworkUtil.h"
#import "Guide.h"
#import "GuideCell.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadUpcomingGuides:)];
    self.navigationItem.rightBarButtonItem = reloadButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self reloadUpcomingGuides:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadUpcomingGuides:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [NetworkUtil getUpcomingGuidesWithHandler:^(int responseCode, NSDictionary *dict) {
        NSArray *guides = [dict objectForKey:@"data"];
        for (NSDictionary* dict in guides) {
            [self.objects addObject:[[Guide alloc] initWithDictionary:dict]];
        }
        [self.objects sortedArrayUsingSelector:@selector(compare:)];
        [self.tableView reloadData];
    }];
    
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Guide *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Guide *guide = self.objects[indexPath.row];
    
    UITextView* titleTextView = (UITextView*)[cell viewWithTag:101];
    UITextView* venueTextView = (UITextView*)[cell viewWithTag:102];
    UITextView* dateTextView = (UITextView*)[cell viewWithTag:103];
    UIImageView* iconImageView = (UIImageView*) [cell viewWithTag:104];

    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:guide.iconUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        iconImageView.image = [UIImage imageWithData:data];
    }];
    
    [titleTextView setText:guide.name];
    [venueTextView setText:[NSString stringWithFormat:@"%@, %@", guide.venueCity, guide.venueState]];
    [dateTextView setText:[NSString stringWithFormat:@"%@ - %@", guide.startDateString, guide.endDateString]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
