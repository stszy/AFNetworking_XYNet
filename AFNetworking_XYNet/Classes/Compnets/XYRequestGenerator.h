//
//  XYRequestGenerator.h
//  XYNetworking
//
//  Created by xiaoYu on 2018/2/2.
//  Copyright © 2018年 XiaoYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYRequestGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSURLRequest *)generateGETRequestWithUrl:(NSString *)url requestParams:(NSDictionary *)requestParams;
- (NSURLRequest *)generatePOSTRequestWithUrl:(NSString *)url requestParams:(NSDictionary *)requestParams;

//Extension
- (void)rest;

@end
