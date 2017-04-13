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
@property UIDatePicker *timePicker2;
@property UIDatePicker *timePicker3;
@property UIDatePicker *timePicker4;
@property UIDatePicker *timePicker5;
@property UIDatePicker *timePicker6;
@property UIDatePicker *timePicker7;
@property UIDatePicker *timePicker8;
@property UIDatePicker *timePicker9;
@property UIDatePicker *timePicker10;
@property UIDatePicker *timePicker11;
@property UIDatePicker *timePicker12;
@property UIDatePicker *timePicker13;
@property UIDatePicker *timePicker14;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property NSString *monTime;
@property NSString *tueTime;
@property NSString *wedTime;
@property NSString *thuTime;
@property NSString *friTime;
@property NSString *satTime;
@property NSString *sunTime;
@property UITextField *currentTF;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapgesture;
@end

@implementation WritingContentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:_tapgesture];
    
    self.arrs = @[@"웹프로그래밍",@"모바일 프로그래밍",@"디자인",@"빅데이터",@"기타"];
    
    self.timePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker.datePickerMode = UIDatePickerModeTime;
    [self.timePicker setMinuteInterval:10];
    [self.timePicker addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.timePicker2 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker2.datePickerMode = UIDatePickerModeTime;
    [self.timePicker2 setMinuteInterval:10];
    [self.timePicker2 addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.timePicker3 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker3.datePickerMode = UIDatePickerModeTime;
    [self.timePicker3 setMinuteInterval:10];
    [self.timePicker3 addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.timePicker4 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker4.datePickerMode = UIDatePickerModeTime;
    [self.timePicker4 setMinuteInterval:10];
    [self.timePicker4 addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.timePicker5 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker5.datePickerMode = UIDatePickerModeTime;
    [self.timePicker5 setMinuteInterval:10];
    [self.timePicker5 addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.timePicker6 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker6.datePickerMode = UIDatePickerModeTime;
    [self.timePicker6 setMinuteInterval:10];
    [self.timePicker6 addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.timePicker7 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker7.datePickerMode = UIDatePickerModeTime;
    [self.timePicker7 setMinuteInterval:10];
    [self.timePicker7 addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.timePicker8 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker8.datePickerMode = UIDatePickerModeTime;
    [self.timePicker8 setMinuteInterval:10];
    [self.timePicker8 addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.timePicker9 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker9.datePickerMode = UIDatePickerModeTime;
    [self.timePicker9 setMinuteInterval:10];
    [self.timePicker9 addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.timePicker10 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker10.datePickerMode = UIDatePickerModeTime;
    [self.timePicker10 setMinuteInterval:10];
    [self.timePicker10 addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.timePicker11 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker11.datePickerMode = UIDatePickerModeTime;
    [self.timePicker11 setMinuteInterval:10];
    [self.timePicker11 addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.timePicker12 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker12.datePickerMode = UIDatePickerModeTime;
    [self.timePicker12 setMinuteInterval:10];
    [self.timePicker12 addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.timePicker13 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker13.datePickerMode = UIDatePickerModeTime;
    [self.timePicker13 setMinuteInterval:10];
    [self.timePicker13 addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.timePicker14 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.timePicker14.datePickerMode = UIDatePickerModeTime;
    [self.timePicker14 setMinuteInterval:10];
    [self.timePicker14 addTarget:self action:@selector(timeChanged:)forControlEvents:UIControlEventValueChanged];
    
    self.monTimeTF.inputView = self.timePicker;
    self.timePicker.tag = 1;
    self.monTimeEndTF.inputView = self.timePicker2;
    self.timePicker2.tag = 2;
    self.tueTimeTF.inputView = self.timePicker3;
    self.timePicker3.tag = 3;
    self.tueTimeEndTF.inputView = self.timePicker4;
    self.timePicker4.tag = 4;
    self.wedTimeTF.inputView = self.timePicker5;
    self.timePicker5.tag = 5;
    self.wedTimeEndTF.inputView = self.timePicker6;
    self.timePicker6.tag = 6;
    self.thuTimeTF.inputView = self.timePicker7;
    self.timePicker7.tag = 7;
    self.thuTimeEndTF.inputView = self.timePicker8;
    self.timePicker8.tag = 8;
    self.friTimeTF.inputView = self.timePicker9;
    self.timePicker9.tag = 9;
    self.friTimeEndTF.inputView = self.timePicker10;
    self.timePicker10.tag = 10;
    self.satTimeTF.inputView = self.timePicker11;
    self.timePicker11.tag = 11;
    self.satTimeEndTF.inputView = self.timePicker12;
    self.timePicker12.tag = 12;
    self.sunTimeTF.inputView = self.timePicker13;
    self.timePicker13.tag = 13;
    self.sunTimeEndTF.inputView = self.timePicker14;
    self.timePicker14.tag = 14;
    
    //카테고리 웹으로 초기 설정
    self.category = @"웹";
    //키보드 노티 등록
    [self addObserverMethod];
}
//MARK: - KerboardNotification 구현 / 등록
- (void)addObserverMethod{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboadUpNoti:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboadNotiHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboadUpNoti:(NSNotification *)sender{
    CGSize keySize = [[sender.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.view.frame = CGRectMake(0, -keySize.height, self.view.frame.size.width, self.view.frame.size.height);
}
- (void)keyboadNotiHide:(NSNotification *)sender{
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

//MARK: -pickerView Method
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
//time picker time changed callBack
-(void)timeChanged:(UIDatePicker *)sender{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"a h:mm"];
    if (sender.tag == 1 ) {
        self.monTimeTF.text = [outputFormatter stringFromDate:self.timePicker.date];
        self.currentTF = self.monTimeTF;
    }else if (sender.tag == 2 ) {
        self.monTimeEndTF.text = [outputFormatter stringFromDate:self.timePicker2.date];
        self.monTime = [NSString stringWithFormat:@"%@ ~ %@", self.monTimeTF.text, self.monTimeEndTF.text];
        self.currentTF = self.monTimeEndTF;
    }else if (sender.tag == 3 ) {
        self.tueTimeTF.text = [outputFormatter stringFromDate:self.timePicker3.date];
        self.currentTF = self.tueTimeTF;
    }else if (sender.tag == 4 ) {
        self.tueTimeEndTF.text = [outputFormatter stringFromDate:self.timePicker4.date];
        self.tueTime = [NSString stringWithFormat:@"%@ ~ %@", self.tueTimeTF.text, self.tueTimeEndTF.text];
        self.currentTF = self.tueTimeEndTF;
    }else if (sender.tag == 5 ) {
        self.wedTimeTF.text = [outputFormatter stringFromDate:self.timePicker5.date];
        self.currentTF = self.wedTimeTF;
    }else if (sender.tag == 6 ) {
        self.wedTimeEndTF.text = [outputFormatter stringFromDate:self.timePicker6.date];
        self.wedTime = [NSString stringWithFormat:@"%@ ~ %@", self.wedTimeTF.text, self.wedTimeEndTF.text];
        self.currentTF = self.wedTimeEndTF;
    }else if (sender.tag == 7 ) {
        self.thuTimeTF.text = [outputFormatter stringFromDate:self.timePicker7.date];
        self.currentTF = self.thuTimeTF;
    }else if (sender.tag == 8 ) {
        self.thuTimeEndTF.text = [outputFormatter stringFromDate:self.timePicker8.date];
        self.thuTime = [NSString stringWithFormat:@"%@ ~ %@", self.thuTimeTF.text, self.thuTimeEndTF.text];
        self.currentTF = self.thuTimeEndTF;
    }else if (sender.tag == 9 ) {
        self.friTimeTF.text = [outputFormatter stringFromDate:self.timePicker9.date];
        self.currentTF = self.friTimeTF;
    }else if (sender.tag == 10 ) {
        self.friTimeEndTF.text = [outputFormatter stringFromDate:self.timePicker10.date];
        self.friTime = [NSString stringWithFormat:@"%@ ~ %@", self.friTimeTF.text, self.friTimeEndTF.text];
        self.currentTF = self.friTimeEndTF;
    }else if (sender.tag == 11 ) {
        self.satTimeTF.text = [outputFormatter stringFromDate:self.timePicker11.date];
        self.currentTF = self.satTimeTF;
    }else if (sender.tag == 12 ) {
        self.satTimeEndTF.text = [outputFormatter stringFromDate:self.timePicker12.date];
        self.satTime = [NSString stringWithFormat:@"%@ ~ %@", self.satTimeTF.text, self.satTimeEndTF.text];
        self.currentTF = self.satTimeEndTF;
    }else if (sender.tag == 13 ) {
        self.sunTimeTF.text = [outputFormatter stringFromDate:self.timePicker13.date];
        self.currentTF = self.sunTimeTF;
    }else if (sender.tag == 14 ) {
        self.sunTimeEndTF.text = [outputFormatter stringFromDate:self.timePicker14.date];
        self.sunTime = [NSString stringWithFormat:@"%@ ~ %@", self.sunTimeTF.text, self.sunTimeEndTF.text];
        self.currentTF = self.sunTimeEndTF;
    }
}


//글쓰기 완료 버튼
- (IBAction)writeDoneClicked:(UIBarButtonItem *)sender {
    
    DataCenter *dataCenter = [DataCenter sharedInstance];
    NSString *urlString=@"http://ec2-13-124-114-82.ap-northeast-2.compute.amazonaws.com/board/write/";
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
    [bodyParameters setObject:self.contentsTitle.text forKey:@"title"];
    [bodyParameters setObject:[dataCenter.userInfos objectForKey:@"nickname"] forKey:@"name"];
    [bodyParameters setObject:self.mainContents.text forKey:@"content"];
    
    
    if (self.monTime != nil) {
       [bodyParameters setObject:self.monTime forKey:@"mon_time"];
    }
    if (self.tueTime != nil){
       [bodyParameters setObject:self.tueTime forKey:@"tue_time"];
    }
    if (self.wedTime != nil){
        [bodyParameters setObject:self.wedTime forKey:@"tue_time"];
    }
    if (self.thuTime != nil){
        [bodyParameters setObject:self.thuTime forKey:@"tue_time"];
    }
    if (self.friTime != nil){
        [bodyParameters setObject:self.friTime forKey:@"tue_time"];
    }
    if (self.satTime != nil){
        [bodyParameters setObject:self.satTime forKey:@"tue_time"];
    }
    if (self.sunTime != nil){
        [bodyParameters setObject:self.sunTime forKey:@"tue_time"];
    }

    [bodyParameters setObject:self.peopleNum.text forKey:@"people_num"];
    [bodyParameters setObject:self.location.text forKey:@"location"];
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
- (IBAction)ontapped:(UITapGestureRecognizer *)sender {
    [self.currentTF resignFirstResponder];
}




@end
