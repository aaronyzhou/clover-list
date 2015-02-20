//
//  NetworkUtil.m
//  clover list
//
//  Created by Aaron Zhou on 2/19/15.
//  Copyright (c) 2015 Aaron Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkUtil.h"

@implementation NetworkUtil
static NSURLSession *defaultSession;
static NSString *baseUrl1 = @"https://www.guide";
static NSString *baseUrl2 = @"book.com/service/v2/";
+(void) httpGetWithUrl:(NSString*)urlStr
                params:(NSString*)params
            completion:(void (^)(int responseCode, NSDictionary *response))completionHandler
{
    if (!defaultSession)
    {
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    }
    urlStr = [NSString stringWithFormat:@"%@%@%@", baseUrl1, baseUrl2, urlStr];
    
    if ([params length]) {
        urlStr = [NSString stringWithFormat:@"%@?%@", urlStr, params];
    }
    
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"GET"];

    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)                                  {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        int statusCode = (int)[httpResponse statusCode];
                                           
        if(statusCode == 200)
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dict);
            if (completionHandler) {
                completionHandler(statusCode, dict);
            }
        }
        else {
            NSLog(@"Error code %d", statusCode);
        }
    }];
    [dataTask resume];
}

+(void)getUpcomingGuidesWithHandler:(void(^)(int responseCode, NSDictionary *response))handler
{
    [self httpGetWithUrl:@"upcomingGuides" params:nil completion:handler];
}
@end








