//
//  MainViewController.m
//  PrismiOS
//
//  Created by HanYoungsoo on 2017. 2. 19..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "WebContents.h"
#import "BoardContentsCell.h"
#import "DataCenter.h"
#import "DetailContentsView.h"
#import <KakaoOpenSDK/KakaoOpenSDK.h>
#import <AFNetworking.h>

@interface WebContents ()
<UITableViewDelegate,UITableViewDataSource>
@property NSString *userID;
@property NSArray *boardArr;
@property NSString *serverToken;
@property NSString *apiURL;
@property NSString *titleName;
@property NSNumber *selectedCell;
@property NSDictionary *commentsDic;
@end

@implementation WebContents

- (void)viewDidLoad {
    [super viewDidLoad];
    self.boardArr = @[];
    self.writeContentsTable.dataSource =self;
    self.writeContentsTable.delegate =self;
    
    self.writeContentBtn.layer.cornerRadius = 35;
    self.writeContentBtn.layer.masksToBounds = YES;
    
    [self.writeContentBtn.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.writeContentBtn.layer setBorderWidth: 0.7];

    DataCenter *dataCenter = [DataCenter sharedInstance];
    self.serverToken = dataCenter.serverToken;
    NSLog(@"serverOkten : %@",self.serverToken);
    self.apiURL = [dataCenter.contentsInfo objectForKey:@"apiURL"];
    self.titleName = [dataCenter.contentsInfo objectForKey:@"title"];
    NSLog(@"%@", self.apiURL);
    NSLog(@"%@", self.titleName);
    self.naviTitle.title = self.titleName;
    
    [self getboardContents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//글목록을 불러오자!
-(void)getboardContents{

    NSString *urlString = self.apiURL;
    NSString *authURL = [NSString stringWithFormat:@"%@ %@",@"jwt",self.serverToken];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:authURL forHTTPHeaderField:@"Authorization"];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success!");    
        self.boardArr = responseObject;
        [self.writeContentsTable reloadData];
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error다 이색기야!: %@", error);
         }];
}


- (IBAction)onBackBtn:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

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

//테이블 뷰 데이터소스, 테이블 뷰 델레게이트 구현

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.boardArr.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSInteger boardNum = self.boardArr.count-1-indexPath.row;


    NSDictionary *dicTemp = [self.boardArr objectAtIndex:boardNum];

    BoardContentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BoardContentsCell"];
    
    
    if (cell == nil) {
        cell = [[BoardContentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BoardContentsCell"];
    }

    cell.writerLB.text = [dicTemp objectForKey:@"name"];
    cell.writingTitleLB.text = [dicTemp objectForKey:@"title"];
    cell.tagLB.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:boardNum]];

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DetailContentsView *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailContentsView"];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    
    NSInteger boardNum = self.boardArr.count-1-indexPath.row;
    
    DataCenter *dataCenter = [DataCenter sharedInstance];
    dataCenter.writingInfos = [self.boardArr objectAtIndex:boardNum];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    NSLog(@"%@", [NSNumber numberWithInteger:boardNum]);

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getboardContents];
    
    
}

@end
