//
//  MainViewController.m
//  PrismiOS
//
//  Created by HanYoungsoo on 2017. 2. 19..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "MainViewController.h"
#import <KakaoOpenSDK/KakaoOpenSDK.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)invokeLogout:(UIButton *)sender {
    
    __weak MainViewController *wself = self;
    [[KOSession sharedSession] logoutAndCloseWithCompletionHandler:^(BOOL success, NSError *error) {
        [wself.navigationController popToRootViewControllerAnimated:YES];
    }];
    
}



//-(void)gotoLoginPage{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LogIn" bundle:nil];
//    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"LogIn"];
//        viewController.modalTransitionStyle = UIModalPresentationPageSheet;
//    
//    
//    [self presentViewController:viewController animated:NO completion:nil];
//    
//}




@end
