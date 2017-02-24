//
//  MainViewController.m
//  PrismiOS
//
//  Created by HanYoungsoo on 2017. 2. 19..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "MainViewController.h"
#import "BoardContentsCell.h"
#import <KakaoOpenSDK/KakaoOpenSDK.h>
#import <AFNetworking.h>

@interface MainViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property NSString *userID;
@property NSArray *boardArr;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.boardArr = @[];
    self.writeContentsTable.dataSource =self;
    self.writeContentsTable.delegate =self;
    
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

//글목록을 불러오자!
-(void)getboardContents{
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    NSString *destinationURLString = [NSString stringWithFormat:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/board/board/"];
//    
//    NSString *authURL = [NSString stringWithFormat:@"%@ %@",@"jwt",self.serverToken];
//    NSURL *url = [NSURL URLWithString:destinationURLString];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"GET"];
//    
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
//                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                                                    
//                                                    NSLog(@"results123 : %@",  responseObject);
//
//                                                }
//                                      //                                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                      //                                                        [self.tableView reloadData];
//                                      //                                                    });
//                                      
//                                      //                                                    self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>
//                                      
//                                      ];
//    [dataTask resume];
    
    
//    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
//    [bodyParameters setObject:@"타이틀입니다.2" forKey:@"title"];
//    [bodyParameters setObject:@"한영수2" forKey:@"name"];
//    [bodyParameters setObject:@"나는 iOS개발자다2     !!!" forKey:@"content"];
    NSString *urlString = @"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/board/board/";
    NSString *authURL = [NSString stringWithFormat:@"%@ %@",@"jwt",self.serverToken];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:authURL forHTTPHeaderField:@"Authorization"];
    
    //    NSURLSessionUploadTask *uploadTask;
    
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success!");
        self.boardArr = responseObject;
        
        [self.writeContentsTable reloadData];
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error다 이색기야!: %@", error);
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
            NSLog(@"%@",responseObject);
            self.serverToken = [responseObject objectForKey:@"token"];
            [self getboardContents];
            
            
        }
    }];
    
    [uploadTask resume];
}


//- (IBAction)writecontent:(UIButton *)sender {
//    
//    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
//    
//    [bodyParameters setObject:@"타이틀입니다.2" forKey:@"title"];
//    [bodyParameters setObject:@"한영수2" forKey:@"name"];
//    [bodyParameters setObject:@"나는 iOS개발자다2     !!!" forKey:@"content"];
//    NSString *urlString = @"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/board/board/";
//    NSString *authURL = [NSString stringWithFormat:@"%@ %@",@"jwt",self.serverToken];
//    
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:authURL forHTTPHeaderField:@"Authorization"];
//    
//    //    NSURLSessionUploadTask *uploadTask;
//    
//    [manager POST:urlString parameters:bodyParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"success!");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error다 이색기야!: %@", error);
//    }];
//}


- (IBAction)invokeLogout:(UIButton *)sender {
    
    __weak MainViewController *wself = self;
    [[KOSession sharedSession] logoutAndCloseWithCompletionHandler:^(BOOL success, NSError *error) {
        [wself.navigationController popToRootViewControllerAnimated:YES];
    }];
    
}


//테이블 뷰 데이터소스, 테이블 뷰 델레게이트 구현

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.boardArr.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dicTemp = [self.boardArr objectAtIndex:indexPath.row];

    BoardContentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BoardContentsCell"];
    
    
    if (cell == nil) {
        cell = [[BoardContentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BoardContentsCell"];
    }

    cell.writerLB.text = [dicTemp objectForKey:@"name"];
    cell.writingTitleLB.text = [dicTemp objectForKey:@"title"];
    cell.tagLB.text = @"JAVA, 웹프로그래밍";
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}








@end
