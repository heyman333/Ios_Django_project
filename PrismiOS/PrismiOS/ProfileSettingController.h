//
//  ProfileSettingController.h
//  PrismiOS
//
//  Created by HanYoungsoo on 2017. 2. 18..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileSettingController : UIViewController
//@property NSString *userID;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UITextField *katalkTF;
@property (weak, nonatomic) IBOutlet UITextView *mySelfTF;
@property (weak, nonatomic) IBOutlet UIButton *kaOKBtn;
@property (weak, nonatomic) IBOutlet UIButton *kaNOBtn;
@property (weak, nonatomic) IBOutlet UIButton *inter_backendBtn;
@property (weak, nonatomic) IBOutlet UIButton *inter_frontendBtn;
@property (weak, nonatomic) IBOutlet UIButton *inter_exeBtn;
@property (weak, nonatomic) IBOutlet UIButton *inter_gameBtn;
@property (weak, nonatomic) IBOutlet UIButton *inter_bigBtn;
@property (weak, nonatomic) IBOutlet UIButton *inter_iOSBtn;
@property (weak, nonatomic) IBOutlet UIButton *inter_andBtn;
@property (weak, nonatomic) IBOutlet UIButton *inter_machineBtn;
@property (weak, nonatomic) IBOutlet UIButton *inter_uxuiBtn;
@property (weak, nonatomic) IBOutlet UIButton *inter_graphicBtn;
@property (weak, nonatomic) IBOutlet UIButton *inter_etcBtn;
@property (weak, nonatomic) IBOutlet UITextField *address;

@end
