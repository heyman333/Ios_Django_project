//
//  WritingContentsViewController.m
//  Prism
//
//  Created by HanYoungsoo on 2017. 3. 2..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "WritingContentsViewController.h"
#import "DataCenter.h"
#import <AFNetworking.h>

@interface WritingContentsViewController ()
<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property NSArray *arrs;
@property NSString *category;
@property UIDatePicker *timePicker;

@end

@implementation WritingContentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrs = @[@"웹프로그래밍",@"모바일 프로그래밍",@"디자인",@"빅데이터",@"기타"];
    
    
    self.timePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker.datePickerMode = UIDatePickerModeTime;
    [self.timePicker setMinuteInterval:30];
    
    [self.timePicker addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.monTimeTF.inputView = self.timePicker;
    
    
    
    self.category = @"웹";
//    self.monTimeTF.inputView =
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.arrs.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [self.arrs objectAtIndex:row];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 40.0;

}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    switch (row) {
        case 0:
            self.category = @"웹";
            break;
        case 1:
            self.category = @"모바일";
            break;
        case 2:
            self.category = @"디자인";
            break;
        case 3:
            self.category = @"빅데이터";
            break;
        case 4:
            self.category = @"기타";
            break;
        default:
            break;
    }
}



- (IBAction)writeDoneClicked:(UIBarButtonItem *)sender {
    
    DataCenter *dataCenter = [DataCenter sharedInstance];
    NSString *urlString=@"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/board/write/";
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
    [bodyParameters setObject:@"제목" forKey:@"title"];
    [bodyParameters setObject:[dataCenter.userInfos objectForKey:@"nickname"] forKey:@"name"];
    [bodyParameters setObject:@"나랑 공부할사람!" forKey:@"content"];
    [bodyParameters setObject:@"11:00~13:00" forKey:@"mon_time"];
    [bodyParameters setObject:@"11:00~13:00" forKey:@"tue_time"];
    [bodyParameters setObject:@"11:00~13:00" forKey:@"wed_time"];
    [bodyParameters setObject:@"11:00~13:00" forKey:@"thu_time"];
    [bodyParameters setObject:@"11:00~13:00" forKey:@"fri_time"];
    [bodyParameters setObject:@"11:00~13:00" forKey:@"sat_time"];
    [bodyParameters setObject:@"11:00~13:00" forKey:@"sun_time"];
    [bodyParameters setObject:[NSNumber numberWithInt:10] forKey:@"people_num"];
    [bodyParameters setObject:@"서울" forKey:@"location"];
    [bodyParameters setObject:self.category forKey:@"category"];
    

    NSString *authURL = [NSString stringWithFormat:@"%@ %@",@"jwt",dataCenter.serverToken];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:authURL forHTTPHeaderField:@"Authorization"];
    
    
    [manager POST:urlString parameters:bodyParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        UIAlertController *sucesssAlert = [UIAlertController alertControllerWithTitle:nil message:@"글 입력 성공" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
        
        [sucesssAlert addAction:okAction];
        [self presentViewController:sucesssAlert animated:YES completion:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error다 이색기야!: %@", error);
    }];
    
    
}
- (IBAction)onBackBtn:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)timeChanged:(UIDatePicker *)sender{
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    
    self.monTimeTF.text = [outputFormatter stringFromDate:self.timePicker.date];
    [self.monTimeTF resignFirstResponder];
    
}



@end
