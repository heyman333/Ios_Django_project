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
@property (weak, nonatomic) IBOutlet UILabel *writerLB;
@property (weak, nonatomic) IBOutlet UITextView *writingContentsTV;
@property (weak, nonatomic) IBOutlet UILabel *studyManNumLB;
@property (weak, nonatomic) IBOutlet UITableView *studyTimeTable;
@end
