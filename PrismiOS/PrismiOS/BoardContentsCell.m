//
//  BoardContentsCell.m
//  Prism
//
//  Created by HanYoungsoo on 2017. 2. 23..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "BoardContentsCell.h"

@implementation BoardContentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //내글 보기 shadow
    _mycontentsView.layer.shadowColor = [UIColor blackColor].CGColor;
    _mycontentsView.layer.shadowOpacity = 0.7;
    _mycontentsView.layer.shadowOffset = CGSizeMake(5, 5);
    _mycontentsView.layer.shadowRadius = 5;
    //모든 글 보기 shadow
    _allcontentsView.layer.shadowColor = [UIColor blackColor].CGColor;
    _allcontentsView.layer.shadowOpacity = 0.7;
    _allcontentsView.layer.shadowOffset = CGSizeMake(5, 5);
    _allcontentsView.layer.shadowRadius = 5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
