//
//  MainViewController.h
//  IosClient
//
//  Created by HanYoungsoo on 2017. 2. 14..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic) NSDictionary *userInfos;

@end
