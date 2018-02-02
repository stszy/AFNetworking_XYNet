//
//  XYRequestGenerator.m
//  XYNetworking
//
//  Created by xiaoYu on 2018/2/2.
//  Copyright © 2018年 XiaoYu. All rights reserved.
//

#import "XYRequestGenerator.h"

#import "AFNetworking.h"
#import "XYNetworkingConfigurationManager.h"
#import "NSURLRequest+XYNetworking.h"

@interface XYRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation XYRequestGenerator
#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static XYRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XYRequestGenerator alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    
    self = [super init];
    [self initialRequestGenerator];
    return self;
}

- (void)initialRequestGenerator {
    _httpRequestSerializer = [AFJSONRequestSerializer serializer];
    _httpRequestSerializer.timeoutInterval = [XYNetworkingConfigurationManager sharedInstance].apiNetworkingTimeoutSeconds;
    _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
}

- (NSURLRequest *)generateGETRequestWithUrl:(NSString *)url requestParams:(NSDictionary *)requestParams {
    return [self generateRequestWithUrl:url requestParams:requestParams requestWithMethod:@"GET"];
}

- (NSURLRequest *)generatePOSTRequestWithUrl:(NSString *)url requestParams:(NSDictionary *)requestParams {
    return [self generateRequestWithUrl:url requestParams:requestParams requestWithMethod:@"POST"];
}

- (NSURLRequest *)generateRequestWithUrl:(NSString *)url requestParams:(NSDictionary *)requestParams requestWithMethod:(NSString *)method {
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:method URLString:url parameters:requestParams error:NULL];
    request.requestParams = requestParams;
    return request;
}

#pragma mark rest

- (void)rest {
    //self.httpRequestSerializer = nil;
}

@end
