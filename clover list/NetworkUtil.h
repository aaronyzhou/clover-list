//
//  NetworkUtil.h
//  clover list
//
//  Created by Aaron Zhou on 2/19/15.
//  Copyright (c) 2015 Aaron Zhou. All rights reserved.
//

#ifndef clover_list_NetworkUtil_h
#define clover_list_NetworkUtil_h

@interface NetworkUtil:NSObject
+(void) httpGetWithUrl:(NSString*)urlStr
                params:(NSString*)params
            completion:(void (^)(int responseCode, NSDictionary *response))completionHandler;
+(void)getUpcomingGuidesWithHandler:(void(^)(int responseCode, NSDictionary *response))handler;
@end
#endif

