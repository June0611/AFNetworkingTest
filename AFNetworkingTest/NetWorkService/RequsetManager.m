//
//  RequsetManager.m
//  AFNetworkingTest
//
//  Created by Nile on 2017/5/18.
//  Copyright © 2017年 pshao. All rights reserved.
//

#import "RequsetManager.h"


@interface RequsetManager()
@end

@implementation RequsetManager
+ (instancetype)sharedRequestManager{
    
    static dispatch_once_t onceToken;
    static RequsetManager * manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
        manager.requestSerializer.timeoutInterval = 60.0f;
        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"jwttoken"];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return manager;
}

+ (void)AFN_ReloadHeaderAuth{
    [[[self sharedRequestManager] requestSerializer] setValue:@"" forHTTPHeaderField:@"jwttoken"];
}

+ (void)AFN_GetRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler{
    [[self sharedRequestManager] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
}

+ (void)AFN_PostRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler{
    [[self sharedRequestManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];

}

@end
