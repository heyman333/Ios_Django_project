//
//  AppMainViewController.h
//  Prism
//
//  Created by HanYoungsoo on 2017. 2. 25..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppMainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UIButton *webBtn;
@property (weak, nonatomic) IBOutlet UIButton *mobileBtn;
@property (weak, nonatomic) IBOutlet UIButton *designBtn;
@property (weak, nonatomic) IBOutlet UIButton *bigDBtn;
@property (weak, nonatomic) IBOutlet UIButton *etcBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *picPageScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;

@property (weak, nonatomic) IBOutlet UIView *infoBar;


@end
