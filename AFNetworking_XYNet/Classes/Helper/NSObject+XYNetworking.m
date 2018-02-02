//
//  NSObject+XYNetworking.m
//  XYNetworking
//
//  Created by xiaoYu on 2018/2/2.
//  Copyright © 2018年 XiaoYu. All rights reserved.
//

#import "NSObject+XYNetworking.h"

@implementation NSObject (XYNetworking)

- (id)xy_defaultValue:(id)defaultData {
    if (![defaultData isKindOfClass:[self class]]) {
        return defaultData;
    }
    
    if ([self xy_isEmptyObject]) {
        return defaultData;
    }
    return self;
}

- (BOOL)xy_isEmptyObject {
    
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([(NSDictionary *)self count] == 0) {
            return YES;
        }
    }
    
    return NO;
}

@end
