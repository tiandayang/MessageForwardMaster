//
//  ViewController.m
//  MessageForwardMaster
//
//  Created by 田向阳 on 2017/11/21.
//  Copyright © 2017年 田向阳. All rights reserved.
//

#import "ViewController.h"
#import "DYSubModel.h"
#import "NSObject+runtime.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DYSubModel *subModel = [[DYSubModel alloc] init];
    [subModel work];
    
    NSLog(@"%@",subModel.allMethod);
}
//模拟方法找不到的情况
- (IBAction)testOne:(id)sender {
    // 用一个字符串的指针去指向一个数组的对象 然后去调用字符串的发法  触发消息转发流程
    NSString *str = @[@"1"];
    NSLog(@"%@",[str uppercaseString]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
