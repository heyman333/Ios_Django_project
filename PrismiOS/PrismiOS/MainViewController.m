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
@property NSString *userID;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logoutBtn.layer.cornerRadius = 10;
    self.logoutBtn.layer.masksToBounds = YES;
    self.writeContentBtn.layer.cornerRadius = 35;
    self.writeContentBtn.layer.masksToBounds = YES;
    
    [self.writeContentBtn.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.writeContentBtn.layer setBorderWidth: 0.7];


    [KOSessionTask meTaskWithCompletionHandler:^(KOUser* result, NSError *error) {
        if (result) {
            // success
            self.userID = [NSString stringWithFormat:@"%@",result.ID];
            
            self.welcomeLB.text = [NSString stringWithFormat:@"%@님 환영합니다.",[result propertyForKey:@"nickname"]];
            [self getToken];
            
        } else {
            NSLog(@"사용자 정보를 얻어오지 못했습니다!");
        }
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getToken{
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
    [bodyParameters setObject:self.userID forKey:@"username"];
    [bodyParameters setObject:self.userID forKey:@"password"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/users/auth/token/"
                                                                                             parameters:bodyParameters
                                                                              constructingBodyWithBlock:nil error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\n\n getToken task error = %@\n\n", error);
        }
        else {
            NSLog(@"토큰을 받아왔습니다");
            NSLog(@"%@",responseObject);
            self.serverToken = [responseObject objectForKey:@"token"];
            //            [self performSegueWithIdentifier:@"main" sender:self];
        }
    }];
    
    [uploadTask resume];
}


- (IBAction)writecontent:(UIButton *)sender {
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
    [bodyParameters setObject:@"타이틀입니다.2" forKey:@"title"];
    [bodyParameters setObject:@"한영수2" forKey:@"name"];
    [bodyParameters setObject:@"나는 iOS개발자다2     !!!" forKey:@"content"];
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
