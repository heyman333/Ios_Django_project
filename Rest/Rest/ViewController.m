//
//  ViewController.m
//  Rest
//
//  Created by HanYoungsoo on 2017. 2. 5..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

@implementation ViewController

- (IBAction)fetchGreeting;
{
    NSURL *url = [NSURL URLWithString:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/testapp/?format=json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
             
            self.greetingId.text = [[jsonArray[0] valueForKey:@"id"] stringValue];
            self.greetingContent.text = [jsonArray[0] valueForKey:@"content"];
    
            self.greetingId2.text = [[jsonArray[1] valueForKey:@"id"] stringValue];
            self.greetingContent2.text = [jsonArray[1] valueForKey:@"content"];
         }
         else{
             NSLog(@"Error");
         }
     }];
}

- (void)dataFromAPIServer {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *destinationURLString = [NSString stringWithFormat:@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com:7777/testapp_Test/"];
    NSURL *url = [NSURL URLWithString:destinationURLString];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
//    id dataTaskCompletionHandler = ^(NSURLResponse *response, id responseObject, NSError *error) {
//        
//    };
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                    
                                                
                                                    self.testArray = [responseObject objectForKey:@"results"];
                                                    NSLog(@"%@", self.testArray);
                                                    
                                                }];
    [dataTask resume];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.testArray = @[];
    
//    [self fetchGreeting];
    [self dataFromAPIServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
