//
//  ViewController.m
//  DataPostTest
//
//  Created by HanYoungsoo on 2017. 2. 10..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
@interface ViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property NSArray *array;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *destinationURLString = [NSString stringWithFormat:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/testapp/Test/?format=json"];
    NSURL *url = [NSURL URLWithString:destinationURLString];
    
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    //    id dataTaskCompletionHandler = ^(NSURLResponse *response, id responseObject, NSError *error) {
    //
    //    };
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                    
                                                    self.array = [responseObject objectForKey:@"results"];
                                                    [self.tableView reloadData];
                                                    
                                                }];
    [dataTask resume];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self.tableView setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"%ld",self.array.count);
    return self.array.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.array objectAtIndex:indexPath.row] objectForKey:@"content"]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[self.array objectAtIndex:indexPath.row] objectForKey:@"id"]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//- (void)getJson{
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    NSString *destinationURLString = [NSString stringWithFormat:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/testapp_Test/"];
//    NSURL *url = [NSURL URLWithString:destinationURLString];
//    
//    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"GET"];
//    
//    //    id dataTaskCompletionHandler = ^(NSURLResponse *response, id responseObject, NSError *error) {
//    //
//    //    };
//    
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
//                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                                                    
//                                                    self.array = [responseObject objectForKey:@"results"];
//                                                    NSLog(@"%@", self.array);
//                                                    
//                                                }];
//    [dataTask resume];
//}


- (void)loginPost {
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    [bodyParameters setObject:@"HanYoungSoo" forKey:@"username"];
    [bodyParameters setObject:@"1234" forKey:@"password"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/register/"
                                                                                             parameters:bodyParameters
                                                                        constructingBodyWithBlock:nil error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\n\n loginPost task error = %@\n\n", error);
        }
        else {
            
            NSLog(@"\n\nreponse = %@\n\n, reponseObject = %@\n\n", response, responseObject);
        }
    }];
    [uploadTask resume];
}

@end
