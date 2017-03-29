//
//  MyContentsViewController.m
//  Prism
//
//  Created by HanYoungsoo on 2017. 3. 19..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "MyContentsViewController.h"
#import "DataCenter.h"
#import "BoardContentsCell.h"
#import "DetailContentsView.h"

@interface MyContentsViewController () <UITableViewDelegate ,UITableViewDataSource>
@property NSMutableArray *resultArr;
@property (weak, nonatomic) IBOutlet UITableView *contentsTable;

@end

@implementation MyContentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"---------------------------------------my-------------------");
    self.resultArr = [[NSMutableArray alloc] init];
    NSString *token = [DataCenter sharedInstance].serverToken;
    NSString *user_id = [[DataCenter sharedInstance].userInfos objectForKey:@"userID"];
    NSLog(@"%@", user_id);

    [[DataCenter sharedInstance].nMaager getWebContents:token completion:^(BOOL isSucess, id result) {
        
        if (isSucess) {
            NSArray *results = result;
            for(NSInteger i = 0 ; i< results.count; i++){
                if([[results[i] objectForKey:@"owner"] isEqualToString:user_id]){
                    NSLog(@"ownwer!%@",[results[i] objectForKey:@"owner"]);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.resultArr addObject:results[i]];
                        [self.contentsTable reloadData];
                    });
                }
            }
        
        }
        else{
            NSLog(@"fail : %@", result);
        }
    }];
    
    [[DataCenter sharedInstance].nMaager getMobileContents:token completion:^(BOOL isSucess, id result) {
        
        if (isSucess) {
            NSArray *results = result;
            for(NSInteger i = 0 ; i< results.count; i++){
                if([[results[i] objectForKey:@"owner"] isEqualToString:user_id]){
                    NSLog(@"ownwer!%@",[results[i] objectForKey:@"owner"]);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.resultArr addObject:results[i]];
                        [self.contentsTable reloadData];
                    });
                }
            }
            
        }
        else{
            NSLog(@"fail : %@", result);
        }
    }];
    
    [[DataCenter sharedInstance].nMaager getBigDataContents:token completion:^(BOOL isSucess, id result) {
        
        if (isSucess) {
            NSArray *results = result;
            for(NSInteger i = 0 ; i< results.count; i++){
                if([[results[i] objectForKey:@"owner"] isEqualToString:user_id]){
                    NSLog(@"ownwer!%@",[results[i] objectForKey:@"owner"]);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.resultArr addObject:results[i]];
                        [self.contentsTable reloadData];
                    });
                }
            }
            
        }
        else{
            NSLog(@"fail : %@", result);
        }
    }];
    
    
    [[DataCenter sharedInstance].nMaager getDesignContents:token completion:^(BOOL isSucess, id result) {
        
        if (isSucess) {
            NSArray *results = result;
            for(NSInteger i = 0 ; i< results.count; i++){
                if([[results[i] objectForKey:@"owner"] isEqualToString:user_id]){
                    NSLog(@"ownwer!%@",[results[i] objectForKey:@"owner"]);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.resultArr addObject:results[i]];
                        [self.contentsTable reloadData];
                    });
                }
            }
            
        }
        else{
            NSLog(@"fail : %@", result);
        }
    }];
    
    
    [[DataCenter sharedInstance].nMaager getEtcContents:token completion:^(BOOL isSucess, id result) {
        
        if (isSucess) {
            NSArray *results = result;
            for(NSInteger i = 0 ; i< results.count; i++){
                if([[results[i] objectForKey:@"owner"] isEqualToString:user_id]){
                    NSLog(@"ownwer!%@",[results[i] objectForKey:@"owner"]);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.resultArr addObject:results[i]];
                        [self.contentsTable reloadData];
                    });
                }
            }
            
        }
        else{
            NSLog(@"fail : %@", result);
        }
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.resultArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger boardNum = self.resultArr.count-1-indexPath.row;
    BoardContentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BoardContentsCell" forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[BoardContentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BoardContentsCell"];
    }
    
    if (self.resultArr.count > 0) {
        NSLog(@"table execute!");
        
        cell.writerLB.text = [self.resultArr[boardNum] objectForKey:@"name"];
        cell.writingTitleLB.text = [self.resultArr[boardNum] objectForKey:@"title"];
        cell.categoryLB.text = [self.resultArr[boardNum] objectForKey:@"category"];
        cell.tagLB.text = [NSString stringWithFormat:@"%@", [[self.resultArr[boardNum] objectForKey:@"date"] substringToIndex:10]];
        [cell.categoryLB setHidden:NO];
    }

    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DetailContentsView *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailContentsView"];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    NSInteger boardNum = self.resultArr.count-1-indexPath.row;
    
    DataCenter *dataCenter = [DataCenter sharedInstance];
    dataCenter.writingInfos = [self.resultArr objectAtIndex:boardNum];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    NSLog(@"%@", [NSNumber numberWithInteger:boardNum]);
    
}

- (IBAction)onBackBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
