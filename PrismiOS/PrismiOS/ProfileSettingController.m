//
//  ProfileSettingController.m
//  PrismiOS
//
//  Created by HanYoungsoo on 2017. 2. 18..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "ProfileSettingController.h"
#import "AppMainViewController.h"
#import <AFNetworking.h>


@interface ProfileSettingController () <UIScrollViewDelegate>
@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *serverToken;
@end

@implementation ProfileSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profileImg.layer.cornerRadius = 60.0;
    self.profileImg.layer.masksToBounds = YES;
    [self.profileImg.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.profileImg.layer setBorderWidth: 2.0];
    
    self.nickName.text = [self.userInfos objectForKey:@"nickname"];
    self.userID = [NSString stringWithFormat:@"%@",[self.userInfos objectForKey:@"userID"]];
    [self userRegisterCheck];
    [self profileImgSet];
}

//등록된 유저인지 찾아내는 메소드
-(void)userRegisterCheck{
    
    __block NSArray *results;
    __block BOOL isregisterd;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *destinationURLString = [NSString stringWithFormat:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/users/list/"];
    NSURL *url = [NSURL URLWithString:destinationURLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                    
                                                    results = responseObject;
                                                    //                                                    NSLog(@"results : %@", results);
                                                    //등록된 유저를 찾는 반복문
                                                    for (NSInteger i = 0; i<results.count; i++) {
                                                        
                                                        if([[results[i] objectForKey:@"username"] isEqualToString:self.userID]){
                                                            isregisterd = YES;
                                                        }
                                                        
                                                        if (!isregisterd) {
                                                            [self userRegister];
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                      //                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                      //                                                        [self.tableView reloadData];
                                      //                                                    });
                                      
                                      //
                                      
                                      ];
    [dataTask resume];
    
}
//카톡 프로필을 설정하는 메소드
-(void)profileImgSet{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[self.userInfos objectForKey:@"profile_image"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request
                                                                     progress:^(NSProgress * _Nonnull downloadProgress){  /* update your progress view  */ }
                                                                  destination:^NSURL *(NSURL *targetPath, NSURLResponse *response)
                                              {
                                                  NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                                                  return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
                                              }
                                                            completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error)
                                              {
                                                  NSLog(@"File downloaded to: %@", filePath);
                                                  
                                                  NSData *imageData = [NSData dataWithContentsOfURL:filePath];
                                                  
                                                  self.profileImg.image = [UIImage imageWithData:imageData];
                                                  self.backImg.image = [UIImage imageWithData:imageData];

                                                  if (!UIAccessibilityIsReduceTransparencyEnabled()) {
                                                      self.backImg.backgroundColor = [UIColor blackColor];
                                                      
                                                      UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
                                                      UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                                                      blurEffectView.frame = self.backImg.bounds;
                                                      blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                                                      [self.backImg setAlpha:1.9];
                                                      [self.backImg addSubview:blurEffectView];
//
                                                  } else {
                                                      self.backImg.backgroundColor = [UIColor blackColor];
                                                  }
                            
                                                  
                                              }];
    [downloadTask resume];
}



//카카오 고유 아이디(비밀번호와 동일)로 서버에 등록하는 메소드!
- (void)userRegister {
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
    [bodyParameters setObject:self.userID forKey:@"username"];
    [bodyParameters setObject:self.userID forKey:@"password"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/users/register/"
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
            
        }
    }];
    
    [uploadTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
