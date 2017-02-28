//
//  AppMainViewController.m
//  Prism
//
//  Created by HanYoungsoo on 2017. 2. 25..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "AppMainViewController.h"
#import <KakaoOpenSDK/KakaoOpenSDK.h>
#import <AFNetworking.h>
#import "DataCenter.h"
#import "WebContents.h"


@interface AppMainViewController ()
@property NSString *userID;

@end

@implementation AppMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 버튼 addTarget
    self.webBtn.tag=0;
    self.mobileBtn.tag=1;
    self.designBtn.tag=2;
    self.bigDBtn.tag=3;
    self.etcBtn.tag=4;
    
    [self.webBtn addTarget:self action:@selector(onContentsBtnClicked:)forControlEvents:UIControlEventTouchUpInside];
    [self.mobileBtn addTarget:self action:@selector(onContentsBtnClicked:)forControlEvents:UIControlEventTouchUpInside];
    [self.designBtn addTarget:self action:@selector(onContentsBtnClicked:)forControlEvents:UIControlEventTouchUpInside];
    [self.bigDBtn addTarget:self action:@selector(onContentsBtnClicked:)forControlEvents:UIControlEventTouchUpInside];
    [self.etcBtn addTarget:self action:@selector(onContentsBtnClicked:)forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //카카오톡 로그인 구현
    [KOSessionTask meTaskWithCompletionHandler:^(KOUser* result, NSError *error) {
        if (result) {
            // success
            self.nameLB.text = [NSString stringWithFormat:@"%@님 반갑습니다.",[result propertyForKey:@"nickname"]];
            self.userID = [NSString stringWithFormat:@"%@", result.ID];
            
            [self getToken];
            
        } else {
            NSLog(@"사용자 정보를 얻어오지 못했습니다!");
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"LoginFail"
                                                  message:@"사용자 정보를 얻오는데 실패 하였습니다."
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:nil];;
            
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];

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
//            NSLog(@"%@",responseObject);
            DataCenter *dataCenter = [DataCenter sharedInstance];
            dataCenter.serverToken= [responseObject objectForKey:@"token"];
        }
    }];
    
    [uploadTask resume];
}

- (IBAction)invokeLogoutBtn:(UIButton *)sender {
    
    [[KOSession sharedSession] logoutAndCloseWithCompletionHandler:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"로그아웃 했습니다.");
            [self.navigationController popToRootViewControllerAnimated:YES];
        
        } else {
            // failed
            NSLog(@"failed to logout.");
        }
    }];
}

-(void)onContentsBtnClicked:(UIButton *)sender{
    
    DataCenter *dataCenter = [DataCenter sharedInstance];
    WebContents *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"WebContents"];

    switch (sender.tag) {
        //webBtn
        case 0:
             dataCenter.contentsInfo = @{@"title":@"웹프로그래밍",@"apiURL":@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/board/web/"};
            break;
            
        //mobileBtn
        case 1:
            
            dataCenter.contentsInfo = @{@"title":@"모바일프로그래밍",@"apiURL":@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/board/mobile/"};
            break;
        //designBtn
        case 2:
            
            dataCenter.contentsInfo = @{@"title":@"디자인",@"apiURL":@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/board/design/"};
            break;
        //bigDBtn
        case 3:
            
            dataCenter.contentsInfo = @{@"title":@"빅 데이터",@"apiURL":@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/board/bigdata/"};
            break;
        //ectBtn
        case 4:
            
            dataCenter.contentsInfo = @{@"title":@"ETC",@"apiURL":@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/board/etc/"};
            break;
        default:
            break;
    }

    [self.navigationController pushViewController:VC animated:YES];
    
}

@end
