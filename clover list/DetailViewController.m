//
//  DetailViewController.m
//  clover list
//
//  Created by Aaron Zhou on 2/19/15.
//  Copyright (c) 2015 Aaron Zhou. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

static NSString* baseUrl1 = @"https://www.guide";
static NSString* baseUrl2 = @"book.com";

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", baseUrl1, baseUrl2, self.detailItem.url]];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
        NSLog(@"%@", url);
        [self.eventWebView loadRequest:request];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.eventWebView = (UIWebView*) [self.view viewWithTag:105];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
