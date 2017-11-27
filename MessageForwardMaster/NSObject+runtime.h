//
//  NSObject+runtime.h
//  ObjCRuntimeMaster
//
//  Created by 田向阳 on 2017/11/10.
//  Copyright © 2017年 田向阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (runtime)

- (NSDictionary *)allPropertyName;
- (NSDictionary *)allMethod;

@end
