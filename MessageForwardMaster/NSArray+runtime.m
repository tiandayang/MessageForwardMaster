//
//  NSArray+runtime.m
//  MessageForwardMaster
//
//  Created by 田向阳 on 2017/11/21.
//  Copyright © 2017年 田向阳. All rights reserved.
//

#import "NSArray+runtime.h"

@implementation NSArray (runtime)

#pragma mark - 消息转发的

//第一步  动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(uppercaseString))
    {
        return NO;
    }
    return  [super resolveInstanceMethod:sel];
}

//Second 方法的重定向
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector == @selector(uppercaseString))
    {
        return nil;
    }
    return [super forwardingTargetForSelector:aSelector];
}

// third 方法签名 以及消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector == @selector(uppercaseString))
    {
        Method method = class_getInstanceMethod([NSString class], aSelector);
         const char *types = method_getTypeEncoding(method);
        NSMethodSignature *sign =[NSMethodSignature signatureWithObjCTypes:types];
        return  sign;
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL aSelector = [anInvocation selector];
    if (aSelector == @selector(uppercaseString)) {
        NSString *string = @"abc";
        [anInvocation invokeWithTarget:string];
    }else{
        return [super forwardInvocation:anInvocation];
    }
}


@end
