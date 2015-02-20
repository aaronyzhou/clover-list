//
//  DetailViewController.h
//  clover list
//
//  Created by Aaron Zhou on 2/19/15.
//  Copyright (c) 2015 Aaron Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Guide.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Guide* detailItem;
@property (weak, nonatomic) UIWebView *eventWebView;

@end

