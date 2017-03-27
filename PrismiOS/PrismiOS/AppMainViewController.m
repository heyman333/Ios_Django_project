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


@interface AppMainViewController ()<UIScrollViewDelegate>
@property NSString *userID;

@end

@implementation AppMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoBar.layer.borderWidth = 1;
    self.picPageScrollView.delegate = self;
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
    
    DataCenter *dataCenter = [DataCenter sharedInstance];
    
    //카카오 사용자 정보 얻어오기!
    [KOSessionTask meTaskWithCompletionHandler:^(KOUser* result, NSError *error) {
        if (result) {
            // success
            self.nameLB.text = [NSString stringWithFormat:@"%@님 반갑습니다.",[result propertyForKey:@"nickname"]];
            self.userID = [NSString stringWithFormat:@"%@", result.ID];
            dataCenter.primary_ID = [NSString stringWithFormat:@"%@", self.userID];
            NSString *nickname = [result propertyForKey:@"nickname"];
            NSString *profile_image = [result propertyForKey:@"profile_image"];
            dataCenter.userInfos = @{@"nickname":nickname, @"profile_image":profile_image,@"userID":self.userID};
            
            [self userRegisterCheck];
            
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
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/users/auth/token/"
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


//테마별 게시판 버튼
-(void)onContentsBtnClicked:(UIButton *)sender{
    
    DataCenter *dataCenter = [DataCenter sharedInstance];
    WebContents *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"WebContents"];
    
    switch (sender.tag) {
            //webBtn
        case 0:
            dataCenter.contentsInfo = @{@"title":@"웹프로그래밍",@"apiURL":@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/board/web/"};
            break;
            
            //mobileBtn
        case 1:
            
            dataCenter.contentsInfo = @{@"title":@"모바일프로그래밍",@"apiURL":@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/board/mobile/"};
            break;
            //designBtn
        case 2:
            
            dataCenter.contentsInfo = @{@"title":@"디자인",@"apiURL":@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/board/design/"};
            break;
            //bigDBtn
        case 3:
            
            dataCenter.contentsInfo = @{@"title":@"빅 데이터",@"apiURL":@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/board/bigdata/"};
            break;
            //ectBtn
        case 4:
            
            dataCenter.contentsInfo = @{@"title":@"ETC",@"apiURL":@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/board/etc/"};
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:VC animated:YES];
    
}




//등록된 유저인지 찾아내는 메소드
-(void)userRegisterCheck{
    
    NSLog(@"등록된 유저인지 찾자!");
    __block NSArray *results;
    __block BOOL isregisterd = NO;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *destinationURLString = @"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/users/list/";
    
    NSURL *url = [NSURL URLWithString:destinationURLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                    NSLog(@"%@",responseObject);
                                                    results = responseObject;

                                                    //                                                    NSLog(@"results : %@", results);
                                                    //등록된 유저를 찾는 반복문
                                                    for (NSInteger i = 0; i<results.count; i++) {
                                                        
                                                        if([[results[i] objectForKey:@"username"] isEqualToString:self.userID]){
                                                            NSLog(@"등록된 유저다!");
                                                            isregisterd = YES;
                                                        }
                                                    }
                                                    
                                                        if (!isregisterd) {
                                                            [self userRegister];
                                                            NSLog(@"유저를 등록합니다");
                                                        }
                                                        else{
                                                            NSLog(@"이미 등록된 유저입니다");
                                                            [self getToken];
                                                        }
                                                        
                                                    }
                                      //                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                      //                                                        [self.tableView reloadData];
                                      //                                                    });
                                      
                                      //
                                      
                                      ];
    [dataTask resume];
    
}



//카카오 고유 아이디(비밀번호와 동일)로 서버에 등록하는 메소드!
- (void)userRegister {
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
    [bodyParameters setObject:self.userID forKey:@"username"];
    [bodyParameters setObject:self.userID forKey:@"password"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/users/register/"
                                                                                             parameters:bodyParameters
                                                                              constructingBodyWithBlock:nil error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\n\n userRegister task error = %@\n\n", error);
        }
        else {
            NSLog(@"등록 성공!");
               [self getToken];
            
        }
    }];
    
    [uploadTask resume];
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger currentOffset = scrollView.contentOffset.x;
    NSInteger index = currentOffset / 288;
    
    //페이징 스크롤이 완전히 끝나야 페이지 인덱스가 바뀜
    if (currentOffset % 288 == 0) {
        self.pageController.currentPage = index;
    }
}









@end
