//
//  DetailContentsView.m
//  Prism
//
//  Created by HanYoungsoo on 2017. 2. 26..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//
#import "DetailContentsView.h"
#import "DataCenter.h"
#import "StudyDayTableViewCell.h"
#import "CommentTableViewCell.h"
#import "UserInfoViewController.h"
#import <AFNetworking.h>

@interface DetailContentsView ()
<UITableViewDataSource, UITableViewDelegate>
@property NSDictionary *contentsInfos;
@property NSMutableArray *mutableDays;
@property NSMutableArray *mutableTimes;
@property NSNumber *board_ID;
@property NSMutableArray *mutableComments;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;


@end
@implementation DetailContentsView

- (void)viewDidLoad {
    
    DataCenter *dataCenter = [DataCenter sharedInstance];
    self.board_ID = dataCenter.board_ID;
    self.contentsInfos = dataCenter.writingInfos;
    self.mutableDays = [[NSMutableArray alloc] init];
    self.mutableTimes = [[NSMutableArray alloc] init];
    self.mutableComments = [[NSMutableArray alloc] init];
    [self getComments];
    
    NSLog(@"%@", self.contentsInfos);
    dataCenter.primary_ID = [self.contentsInfos objectForKey:@"owner"];
    
    self.titleLB.text = [self.contentsInfos objectForKey:@"title"];
    self.locationLB.text = [self.contentsInfos objectForKey:@"location"];
    self.contentLB.text = [self.contentsInfos objectForKey:@"content"];
    self.studyManNumLB.text = [NSString stringWithFormat:@"%@",[self.contentsInfos objectForKey:@"people_num"]];
    self.board_ID = [self.contentsInfos objectForKey:@"id"];
    NSArray *dayArr = @[@"mon_time",@"tue_time",@"wed_time",@"thu_time",@"fri_time",@"sat_time",@"sun_time"];
    NSArray *dayArr2 = @[@"월",@"화",@"수",@"목",@"금",@"토",@"일"];
    
    for (NSInteger i = 0 ; i< dayArr.count ; i++) {
        if ([self.contentsInfos objectForKey:dayArr[i]] != [NSNull null]) {
            NSString * day = [dayArr2 objectAtIndex:i];
            NSString * time = [self.contentsInfos objectForKey:[dayArr objectAtIndex:i]];
            
            NSLog(@"%@",time);
            
            [self.mutableDays addObject:day];
            [self.mutableTimes addObject:time];
            
        }
    }
    
    
    
    [self.heightConstraint setConstant:self.mutableDays.count*44.0];
    
}

//댓글 가져오기
-(void)getComments{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *destinationURLString = [NSString stringWithFormat:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/board/comments/"];
    NSURL *url = [NSURL URLWithString:destinationURLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                    NSArray *results = responseObject;
                                                    
                                                    
                                                    for (NSInteger i = 0 ; i<results.count; i++) {
                                                        
                                                        if([[results[i] objectForKey:@"board_id"] isEqual:self.board_ID]){
                                                            [self.mutableComments addObject:results[i]];
                                                        }
                                                        
                                                    }
                                                    NSLog(@"%ld", (unsigned long)self.mutableComments.count);
                                                    [self.commentTable reloadData];
                                                }
                                      //                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                      //                                                        [self.tableView reloadData];
                                      //                                                    });
                                      
                                      //
                                      
                                      ];
    [dataTask resume];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(tableView == self.studyTimeTable){
        
        StudyDayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudyDayCell" forIndexPath:indexPath];
        
        if(cell == nil){
            cell = [[StudyDayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StudyDayCell"];
        }
        
        cell.dayLB.text = [self.mutableDays objectAtIndex:indexPath.row];
        cell.timeLB.text = [self.mutableTimes objectAtIndex:indexPath.row];
        
        return cell;
    }
    else{
        
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentTableViewCell"];
        }
        
        if([self.mutableComments count] != 0){
            cell.writerLB.text = [[self.mutableComments objectAtIndex:indexPath.row] objectForKey:@"name"];
            cell.comment.text = [[self.mutableComments objectAtIndex:indexPath.row] objectForKey:@"content"];
            cell.timeLB.text =
            [[[self.mutableComments objectAtIndex:indexPath.row] objectForKey:@"date"] substringToIndex:10];
        }
        return cell;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.studyTimeTable) {
        return self.mutableDays.count;
    }
    else{
        return self.mutableComments.count;
    }
    
}

- (IBAction)onBackBtn:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)popupProfile:(id)sender {
    
    UserInfoViewController *modalSetting = [self.storyboard instantiateViewControllerWithIdentifier:@"UserInfoViewController"];
    
    modalSetting.modalPresentationStyle = UIModalPresentationPopover;
    
    [self presentViewController:modalSetting animated:YES completion:nil];
}



- (IBAction)writeComment:(UIButton *)sender {
    
    DataCenter *dataCenter = [DataCenter sharedInstance];

    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
    [bodyParameters setObject:@"한영수333" forKey:@"name"];
    [bodyParameters setObject:@"하이루" forKey:@"content"];
    [bodyParameters setObject:[NSNumber numberWithInt:11] forKey:@"board_id"];
    NSString *urlString = @"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/board/comments/";
    NSString *authURL = [NSString stringWithFormat:@"%@ %@",@"jwt",dataCenter.serverToken];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:authURL forHTTPHeaderField:@"Authorization"];
    
    //    NSURLSessionUploadTask *uploadTask;
    
    [manager POST:urlString parameters:bodyParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success!");
        [self getComments];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error다 이색기야!: %@", error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
