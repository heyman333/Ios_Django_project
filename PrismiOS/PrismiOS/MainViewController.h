//
//  MainViewController.h
//  PrismiOS
//
//  Created by HanYoungsoo on 2017. 2. 19..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property const NSString *serverToken;
//@property const NSString *userID;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLB;
@property (weak, nonatomic) IBOutlet UIButton *writeContentBtn;


@end
