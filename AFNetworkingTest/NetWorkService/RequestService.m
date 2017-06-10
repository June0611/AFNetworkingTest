//
//  RequestService.m
//  AFNetworkingTest
//
//  Created by Nile on 2017/5/18.
//  Copyright © 2017年 pshao. All rights reserved.
//

#import "RequestService.h"
#import "RequsetManager.h"
#import "MJExtension.h"

static id dataObj;
@implementation RequestService

+ (void)reloadAFNHeaderAuth{
    [RequsetManager AFN_ReloadHeaderAuth];
}
+ (void)AFN_JSONResponseGetWithUrl:(NSString *)url param:(id)param modelClass:(Class)modelClass responseBlock:(responseResultBlock) responseBlock{
    [RequsetManager AFN_GetRequest:url params:param success:^(id responseObj) {
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseBlock(dataObj,nil);
    } failure:^(NSError *error) {
        responseBlock(nil,error);
    }];
}
+ (void)AFN_JSONResponsePostWithUrl:(NSString *)url param:(id)param modelClass:(Class)modelClass responseBlock:(responseResultBlock)responseBlock{
    [RequsetManager AFN_PostRequest:url params:param success:^(id responseObj) {
        dataObj = [self modelTransformationWithResponseObj:responseObj modelClass:modelClass];
        responseBlock(dataObj,nil);
    } failure:^(NSError *error) {
        responseBlock(nil,error);
    }];
}


+ (id)convertJson:(NSString *)jsonStr
{
    if (!jsonStr) {
        return nil;
    }
    NSError * error;
    return [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
}


/**
 解密

 @param response 网络数据
 @return 解密结果
 */
+ (NSString *)decreptResponse:(NSString *)response{
    return response;
}

+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass{
    NSString *response = [[NSString alloc] initWithData:(NSData *)responseObj encoding:NSUTF8StringEncoding];
    response = [self decreptResponse:response];
    
    id tmp = [self convertJson:response];
    if ([tmp isKindOfClass:[NSArray class]]) {
        return [modelClass mj_objectArrayWithKeyValuesArray:responseObj];
    }else if([tmp isKindOfClass:[NSDictionary class]]){
        return [modelClass mj_objectWithKeyValues:responseObj];
    }
    return nil;
}

@end
