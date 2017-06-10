//
//  RequestService.h
//  AFNetworkingTest
//
//  Created by Nile on 2017/5/18.
//  Copyright © 2017年 pshao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^responseResultBlock)(id dataObj, NSError *error);
@interface RequestService : NSObject

/**
 重新载入请求头
 */
+ (void)reloadAFNHeaderAuth;

/**
 利用AFN请求获取JSON返回 --- GET请求

 @param url 请求地址
 @param param 请求参数
 @param modelClass 请求返回所需要转换的模型类
 @param responseBlock 请求成功|失败回调
 */
+ (void)AFN_JSONResponseGetWithUrl:(NSString *)url param:(id)param modelClass:(Class)modelClass responseBlock:(responseResultBlock) responseBlock;

/**
 利用AFN请求获取JSON返回 --- POST请求
 
 @param url 请求地址
 @param param 请求参数
 @param modelClass 请求返回所需要转换的模型类
 @param responseBlock 请求成功|失败回调
 */
+ (void)AFN_JSONResponsePostWithUrl:(NSString *)url param:(id)param modelClass:(Class)modelClass responseBlock:(responseResultBlock)responseBlock;


/**
 请求返回结果转换为模型方法  -- 此方法不需要关注,如果有Service继承此类,可以重写该方法进行数据处理

 @param responseObj 返回结果
 @param modelClass 模型类
 @return 转换成功的模型
 */
+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass;

@end
