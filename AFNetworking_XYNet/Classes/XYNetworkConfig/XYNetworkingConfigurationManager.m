//
//  XYNetworkingConfigurationManager.m
//  XYNetworking
//
//  Created by xiaoYu on 2018/2/2.
//  Copyright © 2018年 XiaoYu. All rights reserved.
//

#import "XYNetworkingConfigurationManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation XYNetworkingConfigurationManager

+ (instancetype)sharedInstance {
    
    static XYNetworkingConfigurationManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[XYNetworkingConfigurationManager alloc] init];
        sharedInstance.shouldCache = YES;
        sharedInstance.serviceIsOnline = NO;
        sharedInstance.apiNetworkingTimeoutSeconds = 20.0f;
        sharedInstance.cacheOutdateTimeSeconds = 300;
        sharedInstance.cacheCountLimit = 1000;
        sharedInstance.shouldSetParamsInHTTPBodyButGET = NO;
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return sharedInstance;
}

- (BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}


@end

