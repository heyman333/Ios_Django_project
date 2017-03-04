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
#import "DataCenter.h"


@interface ProfileSettingController () <UIScrollViewDelegate>
@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *serverToken;
@property (nonatomic) DataCenter *dataCenter;
@property (nonatomic) NSData *publicImageData;
//카카오톡 불
@property (nonatomic) NSNumber *kakaoBool;
//관심분야 불
@property (nonatomic) NSNumber *backBool;
@property (nonatomic) NSNumber *frontBool;
@property (nonatomic) NSNumber *exeBool;
@property (nonatomic) NSNumber *gameBool;
@property (nonatomic) NSNumber *bigBool;
@property (nonatomic) NSNumber *iOSBool;
@property (nonatomic) NSNumber *andBool;
@property (nonatomic) NSNumber *machineBool;
@property (nonatomic) NSNumber *uiBool;
@property (nonatomic) NSNumber *graphicBool;
@property (nonatomic) NSNumber *planBool;

//주소 불
@property (nonatomic) NSNumber *addressBool;

@end

@implementation ProfileSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.kakaoBool = [NSNumber numberWithBool:NO];
    self.backBool = [NSNumber numberWithBool:NO];
    self.frontBool = [NSNumber numberWithBool:NO];
    self.exeBool = [NSNumber numberWithBool:NO];
    self.gameBool = [NSNumber numberWithBool:NO];
    self.bigBool = [NSNumber numberWithBool:NO];
    self.iOSBool = [NSNumber numberWithBool:NO];
    self.andBool = [NSNumber numberWithBool:NO];
    self.machineBool = [NSNumber numberWithBool:NO];
    self.uiBool = [NSNumber numberWithBool:NO];
    self.graphicBool = [NSNumber numberWithBool:NO];
    self.planBool = [NSNumber numberWithBool:NO];
    self.addressBool = [NSNumber numberWithBool:YES];

    self.profileImg.layer.cornerRadius = 80.0;
    self.profileImg.layer.masksToBounds = YES;
    [self.profileImg.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.profileImg.layer setBorderWidth: 2.0];
    
    self.dataCenter = [DataCenter sharedInstance];
    self.nickName.text = [_dataCenter.userInfos objectForKey:@"nickname"];
    self.userId = [NSString stringWithFormat:@"%@",[_dataCenter.userInfos objectForKey:@"userID"]];
    self.serverToken = self.dataCenter.serverToken;
    NSLog(@"servertoken : %@ ",self.serverToken);
    [self profileImgSet];
    //    [self getToken];
}
//
//-(void)getToken{
//    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
//    [bodyParameters setObject:self.userId forKey:@"username"];
//    [bodyParameters setObject:self.userId forKey:@"password"];
//
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/users/auth/token/"
//                                                                                             parameters:bodyParameters
//                                                                              constructingBodyWithBlock:nil error:nil];
//
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//
//    NSURLSessionUploadTask *uploadTask;
//    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//
//        if (error) {
//            NSLog(@"\n\n getToken task error = %@\n\n", error);
//        }
//        else {
//            NSLog(@"토큰을 받아왔습니다");
//            self.serverToken= [responseObject objectForKey:@"token"];
//        }
//    }];
//
//    [uploadTask resume];
//}


//카톡 프로필을 설정하는 메소드
-(void)profileImgSet{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    DataCenter *dataCenter = [DataCenter sharedInstance];
    
    
    NSURL *URL = [NSURL URLWithString:[dataCenter.userInfos objectForKey:@"profile_image"]];
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
                                                  
                                                  self.publicImageData = imageData;
                                                  
                                                  if(imageData !=nil){
                                                      self.profileImg.image = [UIImage imageWithData:imageData];
                                                  }
                                              }];
    [downloadTask resume];
}

- (IBAction)saveProfile:(UIButton *)sender {
    
    NSString *urlString = @"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/users/profiles/";
    NSString *authURL = [NSString stringWithFormat:@"%@ %@",@"jwt",self.serverToken];
    
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    NSString *name = [self.dataCenter.userInfos objectForKey:@"nickname"];
    NSString *myself = self.mySelfTF.text;
    NSString *katalk = self.katalkTF.text;
    NSString *address = self.address.text;

    [bodyParameters setObject:name forKey:@"name"];
    [bodyParameters setObject:address forKey:@"address"];
    
//    [bodyParameters setObject:@[@"eefef"] forKey:@"interest"];
    [bodyParameters setObject:myself forKey:@"myself"];
    [bodyParameters setObject:katalk forKey:@"katalk"];
    [bodyParameters setObject:self.kakaoBool forKey:@"katalk_ok"];
    [bodyParameters setObject:self.addressBool forKey:@"address_ok"];
    [bodyParameters setObject:self.publicImageData forKey:@"image"];
    
    
    
    //interest
    [bodyParameters setObject:self.frontBool forKey:@"front"];
    [bodyParameters setObject:self.backBool forKey:@"back"];
    [bodyParameters setObject:self.exeBool forKey:@"application"];
    [bodyParameters setObject:self.gameBool forKey:@"game"];
    [bodyParameters setObject:self.bigBool forKey:@"bigdata"];
    [bodyParameters setObject:self.iOSBool forKey:@"ios"];
    [bodyParameters setObject:self.andBool forKey:@"android"];
    [bodyParameters setObject:self.machineBool forKey:@"machine"];
    [bodyParameters setObject:self.uiBool forKey:@"uiux"];
    [bodyParameters setObject:self.graphicBool forKey:@"graphic"];
    [bodyParameters setObject:self.planBool forKey:@"planning"];

    
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//
//    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:bodyParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:self.publicImageData name:@"image" fileName:@"image.png" mimeType:@"image/png"];
//
//        
//    } error:nil];
//
//    [request setValue:authURL forHTTPHeaderField:@"Authorization"];
////    [request setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
//
//    
//    NSURLSessionUploadTask *tast = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        NSLog(@"%@",interArr);
//        if (error) {
//            NSLog(@"%@", error);
//        }
//    }];
//    
//    [tast resume];
    
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:authURL forHTTPHeaderField:@"Authorization"];
    
    //    NSURLSessionUploadTask *uploadTask;
    
//    [manager POST:urlString parameters:bodyParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"success!");
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error다 이색기야!: %@", error);
//    }];
    
    [manager POST:urlString parameters:bodyParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:self.publicImageData name:@"image" fileName:@"image.png" mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success!");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail!");
    }];
    
//        [manager POST:urlString parameters:bodyParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"success!");
//    
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"error다 이색기야!: %@", error);
//        }];

    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)interestBtnClicked:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
            if (sender.isSelected) {
                NSLog(@"백엔드 취소");
                [sender setSelected:NO];
                self.backBool = [NSNumber numberWithBool:NO];
                
            }
            else{
                [sender setSelected:YES];
                NSLog(@"백엔드 입력");
                self.backBool = [NSNumber numberWithBool:YES];
                
            }
            break;
        case 1:
            if (sender.isSelected) {
                NSLog(@"프론트 취소");
                [sender setSelected:NO];
                self.frontBool = [NSNumber numberWithBool:NO];
                
            }
            else{
                [sender setSelected:YES];
                NSLog(@"프론트 입력");
                self.frontBool = [NSNumber numberWithBool:YES];
                
                break;
            case 2:
                if (sender.isSelected) {
                    NSLog(@"응용프로그래밍 취소");
                    [sender setSelected:NO];
                    self.exeBool = [NSNumber numberWithBool:NO];
                    
                }
                else{
                    [sender setSelected:YES];
                    NSLog(@"응용프로그래밍 입력");
                    self.exeBool = [NSNumber numberWithBool:YES];
                }
                break;
            case 3:
                if (sender.isSelected) {
                    NSLog(@"게임프로그래밍 취소");
                    [sender setSelected:NO];
                    self.gameBool = [NSNumber numberWithBool:NO];
                    
                }
                else{
                    [sender setSelected:YES];
                    NSLog(@"게임프로그래밍 입력");
                    self.gameBool = [NSNumber numberWithBool:YES];
                }
                break;
            case 4:
                if (sender.isSelected) {
                    NSLog(@"빅데이터 취소");
                    [sender setSelected:NO];
                    self.bigBool = [NSNumber numberWithBool:NO];
                    
                }
                else{
                    [sender setSelected:YES];
                    NSLog(@"빅데이터 입력");
                    self.bigBool = [NSNumber numberWithBool:YES];
                }
                
                break;
            case 5:
                if (sender.isSelected) {
                    NSLog(@"iOS 취소");
                    [sender setSelected:NO];
                    self.iOSBool = [NSNumber numberWithBool:NO];
                    
                }
                else{
                    [sender setSelected:YES];
                    NSLog(@"iOS 입력");
                    self.iOSBool = [NSNumber numberWithBool:YES];
                }
                break;
            case 6:
                if (sender.isSelected) {
                    NSLog(@"안드로이드 취소");
                    [sender setSelected:NO];
                    self.andBool = [NSNumber numberWithBool:NO];
                    
                }
                else{
                    [sender setSelected:YES];
                    NSLog(@"안드로이드 입력");
                    self.andBool = [NSNumber numberWithBool:YES];
                }
                break;
            case 7:
                if (sender.isSelected) {
                    NSLog(@"머신러닝 취소");
                    [sender setSelected:NO];
                    self.machineBool = [NSNumber numberWithBool:NO];
                    
                }
                else{
                    [sender setSelected:YES];
                    NSLog(@"머신러닝 입력");
                    self.machineBool = [NSNumber numberWithBool:YES];
                }
                break;
            case 8:
                if (sender.isSelected) {
                    NSLog(@"UX/UI 취소");
                    [sender setSelected:NO];
                    self.uiBool = [NSNumber numberWithBool:NO];
                    
                }
                else{
                    [sender setSelected:YES];
                    NSLog(@"UX/UI 입력");
                    self.uiBool = [NSNumber numberWithBool:YES];
                }
                break;
            case 9:
                if (sender.isSelected) {
                    NSLog(@"그래픽디자인 취소");
                    [sender setSelected:NO];
                    self.graphicBool = [NSNumber numberWithBool:NO];
                    
                }
                else{
                    [sender setSelected:YES];
                    NSLog(@"그래픽디자인 입력");
                    self.graphicBool = [NSNumber numberWithBool:YES];
                }
                break;
            case 10:
                if (sender.isSelected) {
                    NSLog(@"기획 취소");
                    [sender setSelected:NO];
                    self.planBool = [NSNumber numberWithBool:NO];
                    
                }
                else{
                    [sender setSelected:YES];
                    NSLog(@"기획 입력");
                    self.planBool = [NSNumber numberWithBool:YES];
                }
                break;
            default:
                break;
            }
            
    }
}
- (IBAction)kakaoOkBtnCiicked:(UIButton *)sender {
    
    switch (sender.tag) {
        case 100:
            if (sender.isSelected) {
                NSLog(@"공개 취소");
                self.kakaoBool = [NSNumber numberWithBool:NO];
                [sender setSelected:NO];
                
            }
            else{
                if (!self.kaNOBtn.isSelected) {
                    [sender setSelected:YES];
                    NSLog(@"공개");
                    self.kakaoBool = [NSNumber numberWithBool:YES];
                }
                else{
                    [self.kaNOBtn setSelected:NO];
                    [sender setSelected:YES];
                    NSLog(@"공개");
                    self.kakaoBool = [NSNumber numberWithBool:YES];
                    
                }
                
            }
            break;
        case 200:
            if (sender.isSelected) {
                NSLog(@"공개 취소");
                self.kakaoBool = [NSNumber numberWithBool:NO];
                [sender setSelected:NO];
                
            }
            else{
                if (!self.kaOKBtn.isSelected) {
                    [sender setSelected:YES];
                    NSLog(@"비공개");
                    self.kakaoBool = [NSNumber numberWithBool:NO];
                }
                else{
                    [self.kaOKBtn setSelected:NO];
                    [sender setSelected:YES];
                    NSLog(@"비공개");
                    self.kakaoBool = [NSNumber numberWithBool:NO];
                    
                }

            }
            break;
        default:
            break;
    }
}


@end

