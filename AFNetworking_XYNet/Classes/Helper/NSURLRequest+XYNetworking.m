//
//  NSURLRequest+XYNetworking.m
//  XYNetworking
//
//  Created by xiaoYu on 2018/2/2.
//  Copyright © 2018年 XiaoYu. All rights reserved.
//

#import "NSURLRequest+XYNetworking.h"
#import <objc/runtime.h>

static void *XYNetworkingRequestParams;

@implementation NSURLRequest (XYNetworking)

- (void)setRequestParams:(NSDictionary *)requestParams {
    objc_setAssociatedObject(self, &XYNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams {
    return objc_getAssociatedObject(self, &XYNetworkingRequestParams);
}

@end
