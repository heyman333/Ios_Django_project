//
//  BoardContentsCell.h
//  Prism
//
//  Created by HanYoungsoo on 2017. 2. 23..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardContentsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *writingTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *writerLB;

@property (weak, nonatomic) IBOutlet UILabel *tagLB;

@end
