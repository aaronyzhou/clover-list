//
//  Guide.m
//  clover list
//
//  Created by Aaron Zhou on 2/19/15.
//  Copyright (c) 2015 Aaron Zhou. All rights reserved.
//

#import "Guide.h"


@interface Guide ()


@end

@implementation Guide

static NSString* startDateKey = @"startDate";
static NSString* endDateKey = @"endDate";
static NSString* nameKey = @"name";
static NSString* urlKey = @"url";
static NSString* iconKey = @"icon";
static NSString* venueKey = @"venue";
static NSString* venueStateKey = @"state";
static NSString* venueCityKey = @"city";

- (id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd, yyyy"];
        self.startDateString = [dict objectForKey:startDateKey];
        self.startDate = [dateFormatter dateFromString:self.startDateString];
        self.endDateString = [dict objectForKey:endDateKey];
        self.endDate = [dateFormatter dateFromString:self.endDateString];

        self.name = [dict objectForKey:nameKey];
        self.url = [dict objectForKey:urlKey];
        self.iconUrl = [dict objectForKey:iconKey];
        
        NSDictionary* venueDictionary = [dict objectForKey:venueKey];
        self.venueState = [venueDictionary objectForKey:venueStateKey];
        self.venueCity = [venueDictionary objectForKey:venueCityKey];
        
    }
    return self;
}

- (NSComparisonResult)compare:(Guide *)otherGuide {
    return [self.startDate compare:otherGuide.startDate];
}


@end
