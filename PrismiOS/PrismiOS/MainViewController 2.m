//
//  MainViewController.m
//  PrismiOS
//
//  Created by HanYoungsoo on 2017. 2. 19..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "MainViewController.h"
#import <KakaoOpenSDK/KakaoOpenSDK.h>
#import <AFNetworking.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)writecontent:(UIButton *)sender {
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
    [bodyParameters setObject:@"타이틀입니다." forKey:@"title"];
    [bodyParameters setObject:@"한영수" forKey:@"name"];
    [bodyParameters setObject:@"나는 iOS개발자다 !!!" forKey:@"content"];
    NSString *urlString = @"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/board/board/";
    NSString *authURL = [NSString stringWithFormat:@"%@ %@",@"jwt",self.serverToken];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:authURL forHTTPHeaderField:@"Authorization"];
    
//    NSURLSessionUploadTask *uploadTask;

    [manager POST:urlString parameters:bodyParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success!");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error다 이색기야!: %@", error);
    }];
}


- (IBAction)invokeLogout:(UIButton *)sender {
    
    __weak MainViewController *wself = self;
    [[KOSession sharedSession] logoutAndCloseWithCompletionHandler:^(BOOL success, NSError *error) {
        [wself.navigationController popToRootViewControllerAnimated:YES];
    }];
    
}




@end
