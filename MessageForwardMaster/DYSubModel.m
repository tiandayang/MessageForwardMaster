//
//  DYSubModel.m
//  MessageForwardMaster
//
//  Created by 田向阳 on 2017/11/24.
//  Copyright © 2017年 田向阳. All rights reserved.
//

#import "DYSubModel.h"

@implementation DYSubModel

- (void)newWork
{
    NSLog(@"%s",__func__);
}


+ (void)load
{
    Method method = class_getInstanceMethod(self, @selector(sleep1));
    const char *type = method_getTypeEncoding(method);
    BOOL isSuccsecc = class_addMethod(self, @selector(sleep), [self instanceMethodForSelector:@selector(sleep1)],type);
    NSLog(@"%@",isSuccsecc?@"添加成功": @"添加失败");
//    class_replaceMethod(self, @selector(sleep), [self instanceMethodForSelector:@selector(sleep1)], type);
    
}

- (void)sleep1
{
    NSLog(@"%s",__func__);
}
@end
