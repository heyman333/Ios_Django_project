//
//  ViewController.m
//  IosClient
//
//  Created by HanYoungsoo on 2017. 1. 30..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "LogInViewController.h"
#import "User.h"
#import "MainViewController.h"
#import <AFNetworking.h>
#import <KakaoOpenSDK/KakaoOpenSDK.h>

@interface LogInViewController ()
@property (nonatomic,strong) NSNumber *userToken;
@end
@implementation LogInViewController

//Kakao LogIn 버튼 기능
- (IBAction)kakaoLogin:(UIButton *)sender {
    KOSession *session = [KOSession sharedSession];
    
    [session openWithCompletionHandler:^(NSError *error) {
        if (!session.isOpen) {
            switch (error.code) {
                case KOErrorCancelled:
                    break;
                default:
                    [UIAlertController alertControllerWithTitle:@"에러" message:error.description preferredStyle:UIAlertControllerStyleAlert] ;
                    break;
            }
        }
    }];
}

-(void)checkUserRegister:(KOUser *)result{
    
    NSNumber *idtokenNumber = result.ID;
    NSString *nickName = [result propertyForKey:@"nickname"];
    NSString *profile_image = [result propertyForKey:@"profile_image"];
    
    NSString *idTokenNumberString =[idtokenNumber stringValue];
    __block BOOL resistered = NO;
    __block NSArray *results = @[];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *destinationURLString = [NSString stringWithFormat:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/users/list/"];
    NSURL *url = [NSURL URLWithString:destinationURLString];
    
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                    
                                                    results = responseObject;
                                                    NSLog(@"results : %@", results);
                                                    
                                                    //등록된 유저를 찾는 반복문
                                                    for (NSInteger i = 0; i<results.count; i++) {
                                                        if ([[results[i] objectForKey:@"username"] isEqualToString:idTokenNumberString]){
                                                            NSLog(@"idTokenNumberString:%@",idTokenNumberString);
                                                            NSLog(@"result[i]:%@",[results[i] objectForKey:@"username"]);
                                                            resistered = YES;
                                                            
                                                            self.user.nickName = nickName;
                                                            self.user.profile_image = profile_image;
                                                            
                                                        }
                                                        
                                                    }
                                                    //이미 등록된 유저일때
                                                    if(resistered){
                                                        //로그인
                                                        NSLog(@"이미 등록돼있는 유저입니다.");
                                                        
                                                        self.userToken = result.ID;
                                                        [self userLogin];
                                                        
                                                        
                                                        
                                                    }
                                                    //등록돼있는 유저가 아닐 떄
                                                    else{
                                                        NSLog(@"회원가입이 안돼있는 유저입입니다. 유저를 등롭합니다.");
                                                        self.userToken = result.ID;
                                                        [self userRegister];
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                    //                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                    //                                                        [self.tableView reloadData];
                                                    //                                                    });
                                                    
                                                    //                                                    self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>
                                                    
                                                }];
    [dataTask resume];
    
}




//카카오 고유 아이디(비밀번호와 동일)로 서버에 등록하는 메소드!
- (void)userRegister {
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
    [bodyParameters setObject:[self.userToken stringValue] forKey:@"username"];
    [bodyParameters setObject:[self.userToken stringValue] forKey:@"password"];
    
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
            
            NSLog(@"\n\n reponse = %@\n\n, reponseObject = %@\n\n", response, responseObject);
            [self userLogin];
        }
    }];
    
    [uploadTask resume];
}

-(void)userLogin {
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
    [bodyParameters setObject:[self.userToken stringValue] forKey:@"username"];
    [bodyParameters setObject:[self.userToken stringValue] forKey:@"password"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/users/auth/token/"
                                                                                             parameters:bodyParameters
                                                                              constructingBodyWithBlock:nil error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\n\n userLogin task error = %@\n\n", error);
        }
        else {
            
            NSLog(@"\n\n reponse = %@\n\n, reponseObject = %@\n\n", response, responseObject);
            [self performSegueWithIdentifier:@"MainViewSegue" sender:self];
            
        }
    }];
    
    [uploadTask resume];
}

-(void)writeContent{
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
    [bodyParameters setObject:@"안녕하세요~!!! 제 이름은 한영수입니당~!" forKey:@"content"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/testapp/Test/"
                                                                                             parameters:bodyParameters
                                                                              constructingBodyWithBlock:nil error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\n\n loginPost task error = %@\n\n", error);
        }
        else {
            
            NSLog(@"\n\n reponse = %@\n\n, reponseObject = %@\n\n", response, responseObject);
            
        }
    }];
    
    [uploadTask resume];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MainViewSegue"]){
        NSLog(@"MainViewSegue excute!!!!!!!!!!!!!");
//        NSDictionary *userInfos = @{@"nickName":self.user.nickName , @"profile_image" : self.user.profile_image};
//        
//        MainViewController *controller = segue.destinationViewController;
//        controller.userInfos = userInfos;
    }
    
}

// ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.user = [[User alloc] init];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
