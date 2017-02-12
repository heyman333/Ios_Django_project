//
//  ViewController.m
//  IosClient
//
//  Created by HanYoungsoo on 2017. 1. 30..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <KakaoOpenSDK/KakaoOpenSDK.h>

@interface ViewController ()
@end

@implementation ViewController


- (IBAction)kakaoLogIn:(UIButton *)sender{
   [[KOSession sharedSession] close];
    
    KOSession *session = [KOSession sharedSession];
    // do something for already registered user.
    [session openWithCompletionHandler:^(NSError *error) {
        session.presentingViewController = nil;
        if (session.isOpen) {
            // login success
            NSLog(@"login succeeded.");
            
            [KOSessionTask meTaskWithCompletionHandler:^(KOUser* result, NSError *error) {
                if (result) {
                    // success
                    NSLog(@"userId=%@", result.ID);
                    NSLog(@"nickName=%@, %@", [result propertyForKey:@"nickname"], [result propertyForKey:@"profileImageURL"]);
                    NSLog(@"result = %@", result);
                } else {
                    // failed
                }
            }];
        } else {
            // failed
            NSLog(@"login failed.");
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
