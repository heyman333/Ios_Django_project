//
//  NetworkManager.m
//  Prism
//
//  Created by HanYoungsoo on 2017. 3. 19..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking.h>

@implementation NetworkManager

-(void)getWebContents:(NSString *)token completion:(CompletionBlock)completion{
    NSString *urlString = [NSString stringWithFormat:@"%@",WEB_BOARD_API];
    NSString *authURL = [NSString stringWithFormat:@"%@ %@",@"jwt", token];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:authURL forHTTPHeaderField:@"Authorization"];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success!");
        completion(YES,responseObject);
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error %@", error);
             completion(NO,error);
         }];
    
    

}

-(void)getMobileContents:(NSString *)token completion:(CompletionBlock)completion{
    NSString *urlString = [NSString stringWithFormat:@"%@",MOBILE_BOARD_API];
    NSString *authURL = [NSString stringWithFormat:@"%@ %@",@"jwt", token];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:authURL forHTTPHeaderField:@"Authorization"];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success!");
        completion(YES,responseObject);
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error %@", error);
             completion(NO,error);
         }];
}

-(void)getBigDataContents:(NSString *)token completion:(CompletionBlock)completion{
    NSString *urlString = [NSString stringWithFormat:@"%@",BIGDATA_BOARD_API];
    NSString *authURL = [NSString stringWithFormat:@"%@ %@",@"jwt", token];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:authURL forHTTPHeaderField:@"Authorization"];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success!");
        completion(YES,responseObject);
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error %@", error);
             completion(NO,error);
         }];
}

-(void)getDesignContents:(NSString *)token completion:(CompletionBlock)completion{
    NSString *urlString = [NSString stringWithFormat:@"%@",DESIGN_BOARD_API];
    NSString *authURL = [NSString stringWithFormat:@"%@ %@",@"jwt", token];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:authURL forHTTPHeaderField:@"Authorization"];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success!");
        completion(YES,responseObject);
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error %@", error);
             completion(NO,error);
         }];

}

-(void)getEtcContents:(NSString *)token completion:(CompletionBlock)completion{
    NSString *urlString = [NSString stringWithFormat:@"%@",ETC_BOARD_API];
    NSString *authURL = [NSString stringWithFormat:@"%@ %@",@"jwt", token];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:authURL forHTTPHeaderField:@"Authorization"];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success!");
        completion(YES,responseObject);
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error %@", error);
             completion(NO,error);
         }];
    
}


@end
