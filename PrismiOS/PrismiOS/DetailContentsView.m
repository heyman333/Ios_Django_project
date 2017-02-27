//
//  DetailContentsView.m
//  Prism
//
//  Created by HanYoungsoo on 2017. 2. 26..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "DetailContentsView.h"
#import "DataCenter.h"

@interface DetailContentsView ()
@property NSDictionary *contentsInfos;
@end

@implementation DetailContentsView

- (void)viewDidLoad {
    
    DataCenter *dataCenter = [DataCenter sharedInstance];
    self.contentsInfos = dataCenter.writingInfos;

    NSLog(@"%@", self.contentsInfos);
    self.titleLB.text = [self.contentsInfos objectForKey:@"title"];
    self.writerLB.text = [self.contentsInfos objectForKey:@"name"];
    self.writingContentsTV.text = [self.contentsInfos objectForKey:@"content"];
    self.studyManNumLB.text = [NSString stringWithFormat:@"%@",[self.contentsInfos objectForKey:@"people_num"]];
 
    
}

- (IBAction)onBackBtn:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
