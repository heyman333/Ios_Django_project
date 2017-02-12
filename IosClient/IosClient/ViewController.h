//
//  ViewController.h
//  IosClient
//
//  Created by HanYoungsoo on 2017. 1. 30..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>

@interface ViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *greetingId;
@property (nonatomic, strong) IBOutlet UILabel *greetingContent;
@property (nonatomic, strong) IBOutlet UILabel *greetingId2;
@property (nonatomic, strong) IBOutlet UILabel *greetingContent2;
@property (strong, nonatomic) IBOutlet UIButton *kakaoLogInBtn;

- (IBAction)kakaoLogIn:(UIButton *)sender;


@end

