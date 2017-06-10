//
//  ViewController.m
//  AFNetworkingTest
//
//  Created by Asau on 16/3/25.
//  Copyright © 2016年 pshao. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "RequestService.h"
#import "TestModel.h"
@interface ViewController ()
{
    // 下载操作
    NSURLSessionDownloadTask *_downloadTask;
}
@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)test1{
    [RequestService AFN_JSONResponseGetWithUrl:@"http://192.168.1.107:8080/SkeeterTask/test/login" param:nil modelClass:[TestModel class] responseBlock:^(id dataObj, NSError *error) {
        if (error) {
            return ;
        }
        NSLog(@"结果为对象---%@",((TestModel *)dataObj).message);
    }];
}

- (void)test2{
    [RequestService AFN_JSONResponseGetWithUrl:@"http://192.168.1.107:8080/SkeeterTask/test/login2" param:nil modelClass:[TestModel class] responseBlock:^(id dataObj, NSError *error) {
        if (error) {
            return ;
        }
        
        for (TestModel * mode in dataObj) {
            NSLog(@"结果为对象数组--%@",mode.message);
        }
    }];
}

- (IBAction)stopDownloadBtnClick:(id)sender {
    //暂停下载
    [self test2];
}
- (IBAction)startDownloadBtnClick:(id)sender {
    //开始下载
    [self test1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
