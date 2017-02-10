//
//  ViewController.m
//  IosClient
//
//  Created by HanYoungsoo on 2017. 1. 30..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController ()

@end

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchGreeting];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
