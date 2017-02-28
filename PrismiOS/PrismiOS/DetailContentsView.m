//
//  DetailContentsView.m
//  Prism
//
//  Created by HanYoungsoo on 2017. 2. 26..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "DetailContentsView.h"
#import "DataCenter.h"
#import "StudyDayTableViewCell.h"
#import "UserInfoViewController.h"

@interface DetailContentsView ()
<UITableViewDataSource, UITableViewDelegate>
@property NSDictionary *contentsInfos;
@property NSMutableArray *mutableDays;
@property NSMutableArray *mutableTimes;
@end

@implementation DetailContentsView

- (void)viewDidLoad {
    
    DataCenter *dataCenter = [DataCenter sharedInstance];
    self.contentsInfos = dataCenter.writingInfos;
    self.mutableDays = [[NSMutableArray alloc] init];
    self.mutableTimes = [[NSMutableArray alloc] init];

    NSLog(@"%@", self.contentsInfos);
    self.titleLB.text = [self.contentsInfos objectForKey:@"title"];
    self.writerLB.text = [self.contentsInfos objectForKey:@"name"];
    self.writingContentsTV.text = [self.contentsInfos objectForKey:@"content"];
    [self.writingContentsTV setEditable:NO];
    self.studyManNumLB.text = [NSString stringWithFormat:@"%@",[self.contentsInfos objectForKey:@"people_num"]];

    NSArray *dayArr = @[@"mon",@"tue",@"wed",@"thu",@"fri",@"sat",@"sun"];
    
    for (NSInteger i = 0 ; i< dayArr.count ; i++) {
        if ([self.contentsInfos objectForKey:dayArr[i]] != [NSNull null]) {
            NSString * day = [self.contentsInfos objectForKey:dayArr[i]];
            NSString * time = [self.contentsInfos objectForKey:[NSString stringWithFormat:@"%@_time", dayArr[i]]];
            
            NSLog(@"%@",time);
            
            [self.mutableDays addObject:day];
            [self.mutableTimes addObject:time];
            
        }
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StudyDayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudyDayCell" forIndexPath:indexPath];
    
    
    if(cell == nil){
        cell = [[StudyDayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StudyDayCell"];
        
        
    }

    cell.dayLB.text = [self.mutableDays objectAtIndex:indexPath.row];
    cell.timeLB.text = [self.mutableTimes objectAtIndex:indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.mutableDays.count;
}

- (IBAction)onBackBtn:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)popupProfile
:(id)sender {
    
    UserInfoViewController *modalSetting = [self.storyboard instantiateViewControllerWithIdentifier:@"UserInfoViewController"];
    
    modalSetting.modalPresentationStyle = UIModalPresentationPopover;
    
    [self presentViewController:modalSetting animated:YES completion:nil];
    
    
    
}

                        

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
