//
//  NSObject+Addition.m
//  KKDai
//
//  Created by xuliying on 15/7/30.
//  Copyright (c) 2015年 zhaoyuguang. All rights reserved.
//

#import "NSObject+Addition.h"
#import "NSString+Category.h"
@implementation NSObject (Addition)
-(BOOL)isValid{
    return !(self == nil || [self isKindOfClass:[NSNull class]]);
}

- (BOOL)isNoEmpty
{
    if ([self isKindOfClass:[NSNull class]] || self == nil)
    {
        return NO;
    }
    else if ([self isKindOfClass:[NSString class]])
    {
        return  [(NSString *)self length] > 0;
    }
    else if ([self isKindOfClass:[NSData class]])
    {
        
        return [(NSData *)self length] > 0;
    }
    else if ([self isKindOfClass:[NSArray class]])
    {
        
        return [(NSArray *)self count] > 0;
    }
    else if ([self isKindOfClass:[NSDictionary class]])
    {
        
        return [(NSDictionary *)self count] > 0;
    }
    
    return YES;
}
- (NSString *)safeObject {
    
    if (self == nil) {
        
        return @"";
    }
    else {
        NSString *safeString = (NSString *)self;
        
        if (safeString.isNotBlank) {
            if ([safeString isEqualToString:@"null"] || [safeString isEqualToString:@"<null>"]|| [safeString isEqualToString:@"(null)"]  ){
                
                return @"";
            }else {
                return  safeString;
            }
        }
        return @"";
    }
    
    
}

@end
