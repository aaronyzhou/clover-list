//
//  GuideCell.m
//  clover list
//
//  Created by Aaron Zhou on 2/19/15.
//  Copyright (c) 2015 Aaron Zhou. All rights reserved.
//

#import "GuideCell.h"


@implementation GuideCell 

static CGRect cellSize = {{0,0},{400,60}};

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setBounds:cellSize];
        [self.contentView setBackgroundColor:[UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.5f]];
        self.textView = [[UITextView alloc] initWithFrame:cellSize];
        
    }
    return self;
}

@end
