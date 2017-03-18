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

@interface MyContentsViewController () <UITableViewDelegate ,UITableViewDataSource>
@property NSMutableArray *resultArr;
@end

@implementation MyContentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultArr = [[NSMutableArray alloc] init];
    NSString *token = [DataCenter sharedInstance].serverToken;
    
    [[DataCenter sharedInstance].nMaager getWebContents:token completion:^(BOOL isSucess, id result) {
        
        if (isSucess) {
            [self.resultArr addObject:result];
        }
        else{
            NSLog(@"fail : %@", result);
        }
    }];
    
    [[DataCenter sharedInstance].nMaager getMobileContents:token completion:^(BOOL isSucess, id result) {
        
        if (isSucess) {
            [self.resultArr addObject:result];
        }
        else{
            NSLog(@"fail : %@", result);
        }
    }];
    
    [[DataCenter sharedInstance].nMaager getBigDataContents:token completion:^(BOOL isSucess, id result) {
        
        if (isSucess) {
            [self.resultArr addObject:result];
        }
        else{
            NSLog(@"fail : %@", result);
        }
    }];
    
    
    [[DataCenter sharedInstance].nMaager getDesignContents:token completion:^(BOOL isSucess, id result) {
        
        if (isSucess) {
            [self.resultArr addObject:result];
        }
        else{
            NSLog(@"fail : %@", result);
        }
    }];
    
    
    [[DataCenter sharedInstance].nMaager getEtcContents:token completion:^(BOOL isSucess, id result) {
        
        if (isSucess) {
            [self.resultArr addObject:result];
        }
        else{
            NSLog(@"fail : %@", result);
        }
    }];
    
    
    NSLog(@"%@", _resultArr);
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BoardContentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BoardContentsCell" forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[BoardContentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BoardContentsCell"];
    }
    
    
    
    return cell;
    
    
}

- (IBAction)onBackBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
