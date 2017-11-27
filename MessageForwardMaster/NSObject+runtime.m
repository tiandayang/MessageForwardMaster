//
//  NSObject+runtime.m
//  ObjCRuntimeMaster
//
//  Created by 田向阳 on 2017/11/10.
//  Copyright © 2017年 田向阳. All rights reserved.
//

#import "NSObject+runtime.h"

@implementation NSObject (runtime)

- (NSDictionary *)allPropertyName
{
    unsigned int varCount;
    Class class = object_getClass(self);
    Ivar *vars = class_copyIvarList(class, &varCount);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < varCount; i ++ ) {
        Ivar var = vars[i];
      NSString *name = [[[NSString alloc] initWithUTF8String:ivar_getName(var)] substringFromIndex:1];
      NSString *type = [[NSString alloc] initWithUTF8String:ivar_getTypeEncoding(var)];
        if (type.length > 3) {
            type = [type substringWithRange:NSMakeRange(2, type.length - 3)];
        }
        type = [self propertyTypeCompare:type];
        [dic setValue:type forKey:name];
    }
    free(vars);
    return dic;
}

- (NSDictionary *)allMethod
{
    unsigned int methodCount;
    Class class = object_getClass(self);
    Method *methods = class_copyMethodList(class, &methodCount);
    NSMutableDictionary *methodDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < methodCount; i ++ ) {
        Method aMethod = methods[i];
        SEL selector = method_getName(aMethod);
        NSString *methodName = NSStringFromSelector(selector);
        unsigned int argumentCount = method_getNumberOfArguments(aMethod);
//        IMP imp = class_getMethodImplementation(class, selector); //获取imp
        [methodDic setValue:@(argumentCount).stringValue forKey:methodName];
    }
    free(methods);
    return  methodDic;
}

- (NSString *)propertyTypeCompare:(NSString *)type
{
    if ([type isEqualToString:@"i"]) {
        type = @"int";
    }else if ([type isEqualToString:@"d"]){
        type = @"double";
    }else if ([type isEqualToString:@"f"]){
        type = @"float";
    }else if ([type isEqualToString:@"B"]){
        type = @"BOOL";
    }
    return type;
}


@end
