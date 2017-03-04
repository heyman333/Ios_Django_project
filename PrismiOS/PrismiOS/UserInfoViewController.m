//
//  UserInfoViewController.m
//  Prism
//
//  Created by HanYoungsoo on 2017. 2. 27..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "UserInfoViewController.h"
#import "DataCenter.h"
#import <AFNetworking.h>

@interface UserInfoViewController ()
@property NSString *primary_ID;
@property NSString *serverToken;
@property NSArray *resultArr;
@property NSDictionary *resultDic;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DataCenter *dataCenter = [DataCenter sharedInstance];
    self.primary_ID = dataCenter.primary_ID;
    self.serverToken = dataCenter.serverToken;
    
    self.profileImg.layer.cornerRadius = 60.0;
    self.profileImg.layer.masksToBounds = YES;
    [self.profileImg.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.profileImg.layer setBorderWidth: 2.0];
    
    self.address.text=@"등록안함";
    self.katakID.text=@"등록안함";
    self.interestingLB.text=@"등록안함";
    self.mySelfLB.text=@"등록안함";
    
    
    
    [self getUserProfile];

    
}

-(void)getUserProfile{
    
    NSString *urlString = @"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/users/profiles/";
    
    NSString *authURL = [NSString stringWithFormat:@"%@ %@",@"jwt",self.serverToken];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:authURL forHTTPHeaderField:@"Authorization"];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success!");
        
        self.resultArr = responseObject;
        
        for(NSInteger i = 0 ; i < self.resultArr.count; i++){
            if ([[self.resultArr[i] objectForKey:@"owner"] isEqualToString:self.primary_ID]) {
                self.resultDic = self.resultArr[i];
            }
        }
        
        [self profileImgSet];
        NSLog(@"%@",self.resultDic);
        self.nameLB.text = [self.resultDic objectForKey:@"name"];
        
        if([self.resultDic objectForKey:@"address"] != [NSNull null]){
            self.address.text = [self.resultDic objectForKey:@"address"];
        }
        
        if ([self.resultDic objectForKey:@"katalk_ok"] == [NSNumber numberWithBool:NO]) {
            self.katakID.text = @"비공개";
        }
        
        else if([self.resultDic objectForKey:@"katalk"] != [NSNull null]){
            self.katakID.text = [self.resultDic objectForKey:@"katalk"];
        }
        
        if([self.resultDic objectForKey:@"myself"] != [NSNull null]){
            self.mySelfLB.text = [self.resultDic objectForKey:@"myself"];
        }
    
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error다 이색기야!: %@", error);
         }];
 
    
}

-(void)profileImgSet{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    
    
    NSURL *URL = [NSURL URLWithString:[self.resultDic objectForKey:@"image"]];
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
                                                
                                                  if(imageData !=nil){
                                                      self.profileImg.image = [UIImage imageWithData:imageData];
                                                  }
                                              }];
    [downloadTask resume];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}















- (IBAction)onBackBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
