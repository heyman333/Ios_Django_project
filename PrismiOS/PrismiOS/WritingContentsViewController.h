//
//  WritingContentsViewController.h
//  Prism
//
//  Created by HanYoungsoo on 2017. 3. 2..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WritingContentsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *monTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *monTimeEndTF;
@property (weak, nonatomic) IBOutlet UITextField *tueTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *tueTimeEndTF;
@property (weak, nonatomic) IBOutlet UITextField *wedTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *wedTimeEndTF;
@property (weak, nonatomic) IBOutlet UITextField *thuTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *thuTimeEndTF;
@property (weak, nonatomic) IBOutlet UITextField *friTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *friTimeEndTF;
@property (weak, nonatomic) IBOutlet UITextField *satTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *satTimeEndTF;
@property (weak, nonatomic) IBOutlet UITextField *sunTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *sunTimeEndTF;
@property (weak, nonatomic) IBOutlet UITextField *contentsTitle;
@property (weak, nonatomic) IBOutlet UITextView *mainContents;
@property (weak, nonatomic) IBOutlet UITextField *peopleNum;
@property (weak, nonatomic) IBOutlet UITextField *location;
@end
