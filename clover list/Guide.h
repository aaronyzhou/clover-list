//
//  Guide.h
//  clover list
//
//  Created by Aaron Zhou on 2/19/15.
//  Copyright (c) 2015 Aaron Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Guide : NSObject
@property (nonatomic) NSString *startDateString;
@property (nonatomic) NSString *endDateString;
@property (nonatomic) NSDate *startDate;
@property (nonatomic) NSDate *endDate;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *url;
@property (nonatomic) NSDictionary *venue;
@property (nonatomic) NSString *iconUrl;
@property (nonatomic) NSString *venueState;
@property (nonatomic) NSString *venueCity;


- (id)initWithDictionary:(NSDictionary*)dict;
@end
