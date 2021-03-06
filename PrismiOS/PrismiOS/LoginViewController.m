//
//  ViewController.m
//  PrismiOS
//
//  Created by HanYoungsoo on 2017. 2. 18..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "LoginViewController.h"
#import "ProfileSettingController.h"
#import "AppMainViewController.h"
#import <KakaoOpenSDK/KakaoOpenSDK.h>

@interface LoginViewController ()
@property (nonatomic) __block NSDictionary *userInfos;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // button position
    int xMargin = 30;
    int marginBottom = 25;
    CGFloat btnWidth = self.view.frame.size.width - xMargin * 2;
    int btnHeight = 42;
    
    UIButton* kakaoLoginButton
    = [[KOLoginButton alloc] initWithFrame:CGRectMake(xMargin, self.view.frame.size.height-btnHeight-marginBottom, btnWidth, btnHeight)];
    kakaoLoginButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:kakaoLoginButton];
    
    [kakaoLoginButton addTarget:self
                         action:@selector(invokeLoginWithTarget:)
               forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)invokeLoginWithTarget:(UIButton *)sender{
    
    // ensure old session was closed
    [[KOSession sharedSession] close];
    
    [[KOSession sharedSession] openWithCompletionHandler:^(NSError *error) {
        if ([[KOSession sharedSession] isOpen]) {
            // login success
            NSLog(@"login succeeded.");
            
            [KOSessionTask meTaskWithCompletionHandler:^(KOUser* result, NSError *error) {
                if (result) {
                    // success
                    NSString *nickname = [result propertyForKey:@"nickname"];
                    NSString *profile_image = [result propertyForKey:@"profile_image"];
                    NSNumber *userId = result.ID;
                    self.userInfos = @{@"nickname":nickname, @"profile_image":profile_image,@"userID":userId};
                    
                    AppMainViewController *mainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
                    
                    UIAlertController *gotoMainAlert = [UIAlertController alertControllerWithTitle:@"로그인" message:@"최초 접속시 개인정보를 설정해주세요" preferredStyle: UIAlertControllerStyleAlert];
                    
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self.navigationController pushViewController:mainVC animated:YES];
                    }];
                    
                    [gotoMainAlert addAction:action];
                    [self presentViewController:gotoMainAlert animated:YES completion:nil];

                } else {
                    NSLog(@"사용자 정보를 얻어오지 못했습니다!");
                }
            }];
        } else {
            // failed
            NSLog(@"login failed.%@", error);
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"viewWillDisappear");
    
}


@end
