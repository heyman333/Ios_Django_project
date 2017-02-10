//
//  ViewController.h
//  Rest
//
//  Created by HanYoungsoo on 2017. 2. 5..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *greetingId;
@property (nonatomic, strong) IBOutlet UILabel *greetingContent;
@property (nonatomic, strong) IBOutlet UILabel *greetingId2;
@property (nonatomic, strong) IBOutlet UILabel *greetingContent2;

@property NSArray *testArray;

- (IBAction)fetchGreeting;


@end

