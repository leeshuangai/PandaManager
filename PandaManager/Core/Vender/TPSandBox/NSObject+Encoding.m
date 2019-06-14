//
//  NSObject+Encoding.m
//  TJFileManager
//
//  Created by lish on 2017/8/1.
//  Copyright © 2017年 lish. All rights reserved.
//

#import "NSObject+Encoding.h"
#import <objc/runtime.h>
@implementation NSObject (Encoding)

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [self enCoder:aCoder];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    [self dencoder:aDecoder];
    return self;
    
}


// 反归档
- (void)dencoder:(NSCoder *)decoder
{
    unsigned count = 0;
    
    Ivar  *ivars = class_copyIvarList([self class], &count);
    
    for (int i =0; i<count; i++)
    {
        Ivar  var = ivars[i];
        
        const char *name = ivar_getName(var);
        
        NSString *key = [NSString stringWithFormat:@"%s",name];
        
        id value = [decoder decodeObjectForKey:key];
        
        [self setValue:value forKey:key];
    }
    
}
/** 归档 */
- (void)enCoder:(NSCoder *)encoder {
    
    unsigned count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivars[i];
        const char *name = ivar_getName(var);
        NSString *key = [NSString stringWithFormat:@"%s",name];
        id value =  [self valueForKeyPath:key];
        [encoder encodeObject:value forKey:key];
    }
    
}
@end
