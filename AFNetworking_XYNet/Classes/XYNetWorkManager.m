//
//  XYNetWork.m
//  XYNetworking
//
//  Created by xiaoYu on 30/01/2018.
//  Copyright © 2018 XiaoYu. All rights reserved.
//

#import "XYNetWorkManager.h"
#import "AFNetworking.h"

#import "XYRequestGenerator.h"
#import "XYURLResponse.h"

@interface XYNetWorkManager ()

@property (nonatomic, strong) NSMutableDictionary *taskTable;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation XYNetWorkManager


- (NSMutableDictionary *)taskTable {
    if (_taskTable == nil) {
        _taskTable = [[NSMutableDictionary alloc] init];
    }
    return _taskTable;
}

- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy.validatesDomainName = NO;    }
    return _sessionManager;
}

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static XYNetWorkManager *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XYNetWorkManager alloc] init];
    });
    return sharedInstance;
}

- (NSNumber *)getRequestWithURL:(NSString *)url params:(NSDictionary *)params success:(XYCallback)success fail:(XYCallback)fail {
    NSURLRequest *request = [[XYRequestGenerator sharedInstance] generateGETRequestWithUrl:url requestParams:params];
    NSNumber *requestId = [self callRequest:request success:success fail:fail];
    return requestId;
}

- (NSNumber *)postRequestWithURL:(NSString *)url params:(NSDictionary *)params success:(XYCallback)success fail:(XYCallback)fail {
    NSURLRequest *request = [[XYRequestGenerator sharedInstance] generatePOSTRequestWithUrl:url requestParams:params];
    NSNumber *requestId = [self callRequest:request success:success fail:fail];
    return requestId;
}

- (void)cancelAllRequest {
    NSArray *requestIDs = self.taskTable.allKeys;
    [self cancelRequestWithRequestIdList:requestIDs];
}

- (void)cancelRequestWithRequestId:(NSNumber *)requestID {
    NSURLSessionDataTask *requestOperation = self.taskTable[requestID];
    [requestOperation cancel];
    [self.taskTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIdList:(NSArray *)requestIdList {
    for (NSNumber *requestId in requestIdList) {
        [self cancelRequestWithRequestId:requestId];
    }
}

#pragma mark - private
- (NSNumber *)callRequest:(NSURLRequest *)request success:(XYCallback)success fail:(XYCallback)fail {
    
    NSLog(@"\n**************************\n\nRequest Start: \n\n    %@\n\n**************************\n",  request.URL);
    __block NSURLSessionDataTask *dataTask = nil;
    
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.taskTable removeObjectForKey:requestID];
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSData *responseData = responseObject;
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        if (error) {
            XYURLResponse *CTResponse = [[XYURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData error:error];
            fail?fail(CTResponse):nil;
        } else {
            XYURLResponse *CTResponse = [[XYURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData status:XYURLResponseStatusSuccess];
            success?success(CTResponse):nil;
        }
    }];
    NSNumber *requestId = @([dataTask taskIdentifier]);
    self.taskTable[requestId] = dataTask;
    [dataTask resume];
    return requestId;
}

@end
