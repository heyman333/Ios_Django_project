//
//  ViewController.h
//  IosClient
//
//  Created by HanYoungsoo on 2017. 1. 30..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
@class User;
@interface LogInViewController : UIViewController
@property (nonatomic, strong) User *user;
- (IBAction)kakaoLogin:(UIButton *)sender;
@end

