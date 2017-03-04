//
//  MainViewController.h
//  PrismiOS
//
//  Created by HanYoungsoo on 2017. 2. 19..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebContents : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *writeContentBtn;
@property (weak, nonatomic) IBOutlet UITableView *writeContentsTable;
@property (weak, nonatomic) IBOutlet UINavigationItem *naviTitle;
@end
