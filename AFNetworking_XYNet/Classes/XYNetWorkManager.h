//
//  XYNetWork.h
//  XYNetworking
//
//  Created by xiaoYu on 30/01/2018.
//  Copyright © 2018 XiaoYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYURLResponse.h"

typedef void(^XYCallback)(XYURLResponse *response);

@interface XYNetWorkManager : NSObject

+ (instancetype)sharedInstance;

- (NSNumber *)getRequestWithURL:(NSString *)url params:(NSDictionary *)params success:(XYCallback)success fail:(XYCallback)fail;
- (NSNumber *)postRequestWithURL:(NSString *)url params:(NSDictionary *)params success:(XYCallback)success fail:(XYCallback)fail;

- (void)cancelAllRequest;
- (void)cancelRequestWithRequestId:(NSNumber *)requestId;
- (void)cancelRequestWithRequestIdList:(NSArray *)requestIdList;

@end
