//
//  DetailContentsView.h
//  Prism
//
//  Created by HanYoungsoo on 2017. 2. 26..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailContentsView : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@property (weak, nonatomic) IBOutlet UILabel *contentLB;

@property (weak, nonatomic) IBOutlet UILabel *studyManNumLB;
@property (weak, nonatomic) IBOutlet UITableView *studyTimeTable;
@property (weak, nonatomic) IBOutlet UITableView *commentTable;
@property (weak, nonatomic) IBOutlet UILabel *locationLB;

@end
