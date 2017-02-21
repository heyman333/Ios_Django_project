//
//  ProfileSettingController.m
//  PrismiOS
//
//  Created by HanYoungsoo on 2017. 2. 18..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "ProfileSettingController.h"
#import "MainViewController.h"
#import <AFNetworking.h>


@interface ProfileSettingController ()
@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *serverToken;
@end

@implementation ProfileSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.profileImg.layer.cornerRadius = 60.0;
    self.profileImg.layer.masksToBounds = YES;
    self.nickName.text = [self.userInfos objectForKey:@"nickname"];
    self.userID = [NSString stringWithFormat:@"%@",[self.userInfos objectForKey:@"userID"]];
//    [self userRegister];
    [self userRegisterCheck];
    [self profileImgSet];
}



-(void)userRegisterCheck{
    
    __block NSArray *results;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *destinationURLString = [NSString stringWithFormat:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/users/list/"];
    NSURL *url = [NSURL URLWithString:destinationURLString];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                    
                                                    results = responseObject;
                                                    NSLog(@"results : %@", results);
//                                                    NSLog(@"%@", self.userID)
                                                    
                                                    //등록된 유저를 찾는 반복문
                                                    for (NSInteger i = 0; i<results.count; i++) {
                                                        
                                                        if([[results[i] objectForKey:@"username"] isEqualToString:self.userID]){
                                                            NSLog(@"이미 등록된 유저입니다.");
                                                        }
                                                        else{
                                                            NSLog(@"서버에 유저를 등록합니다.");
                                                            [self userRegister];
                                                        }
                                                    
                                                        }
                                                        
                                                    }
                                                    //                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                    //                                                        [self.tableView reloadData];
                                                    //                                                    });
                                                    
                                                    //                                                    self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>
                                                    
                                        ];
    [dataTask resume];
    

}




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
            [self getToken];
            
        }
    }];
    
    [uploadTask resume];
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
            [self performSegueWithIdentifier:@"main" sender:self];
        }
    }];
    
    [uploadTask resume];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    MainViewController *mainviewController = segue.destinationViewController;
    mainviewController.serverToken = self.serverToken;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
