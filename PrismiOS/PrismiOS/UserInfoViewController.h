//
//  UserInfoViewController.h
//  Prism
//
//  Created by HanYoungsoo on 2017. 2. 27..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *katakID;
@property (weak, nonatomic) IBOutlet UILabel *interestingLB;
@property (weak, nonatomic) IBOutlet UILabel *mySelfLB;

@end
