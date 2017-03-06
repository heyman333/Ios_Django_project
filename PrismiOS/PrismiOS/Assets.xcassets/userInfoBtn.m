//
//  userInfoBtn.m
//  Prism
//
//  Created by HanYoungsoo on 2017. 3. 5..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "userInfoBtn.h"
#import "DataCenter.h"

@implementation userInfoBtn

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
 
 */
- (void)drawRect:(CGRect)rect {
    DataCenter *dataCenter = [DataCenter sharedInstance];
    NSString *reName = [NSString stringWithFormat:@" %@", [dataCenter.writingInfos objectForKey:@"name"]];

    NSString *name = reName;
    [self setTitle:name forState:UIControlStateNormal];
//    [[self layer] setMasksToBounds:YES];
//    [self.layer setCornerRadius:20.0f];
//    [self.layer setBorderColor:[UIColor grayColor].CGColor];
//    [self.layer setBorderWidth:1.0];

}

@end
