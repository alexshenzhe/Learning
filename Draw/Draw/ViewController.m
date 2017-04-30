//
//  ViewController.m
//  Draw
//
//  Created by 沈喆 on 16/3/4.
//  Copyright © 2016年 SEN_ZE. All rights reserved.
//

#import "ViewController.h"
#import "NumberRoll.h"

@interface ViewController () <NumberRollDelegate>

@property (weak, nonatomic) IBOutlet UILabel *rollLabel; // 滚动显示区
@property (weak, nonatomic) IBOutlet UILabel *showLabel; // 当前中奖显示区
@property (strong, nonatomic) IBOutlet UITextView *showNumber; // 所有中奖显示区
@property (weak, nonatomic) IBOutlet UITextField *rangeField; // 随机范围输入框

- (IBAction)beginDraw:(UIButton *)sender; // 开始抽奖按钮
- (IBAction)stopRoll:(UIButton *)sender; // 停止抽奖按钮
- (IBAction)cleanAll:(UIButton *)sender; // 清空按钮
- (IBAction)setButton:(UIButton *)sender; // 设置按钮

@property (nonatomic, strong) NumberRoll *numberRoll;
@property (nonatomic, copy) NSMutableString *allNumbers;
@property (nonatomic, assign) NSInteger rangeNow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numberRoll = [[NumberRoll alloc] init];
    self.numberRoll.delegate = self;

    if (self.allNumbers == nil) {
        self.allNumbers = [NSMutableString stringWithFormat:@"本次中奖号码:"];
    }
    [self updateResultsLabel];
    [self updateRollLabel];
    
    // 创建自定义的触摸手势来实现对键盘的隐藏
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 更新中奖信息Label文字的方法
- (void)updateResultsLabel {
    self.showLabel.text = [NSString stringWithFormat:@"%ld", self.rangeNow];
    self.showNumber.text = [NSString stringWithFormat:@"%@", self.allNumbers];
}

// 更新滚动Label文字的方法
- (void)updateRollLabel {
    self.rollLabel.text = [NSString stringWithFormat:@"%ld", self.rangeNow];
}

// 重新开始方法
- (void)startAgain {
    self.rangeNow = 0;
    self.allNumbers = [NSMutableString stringWithFormat:@"本次中奖号码:"];
    [self updateResultsLabel];
    [self updateRollLabel];
}

// 开始抽奖按钮
- (IBAction)beginDraw:(UIButton *)sender {
    [self.numberRoll startRoll];
}

// 停止抽奖按钮的方法
- (IBAction)stopRoll:(UIButton *)sender {
    self.rangeNow = [self.numberRoll stopRoll];
    [self updateRollLabel];
//    拼接字符串，将产生的中奖号码进行拼接
    self.allNumbers = [NSMutableString stringWithFormat:@"%@ %ld", self.allNumbers, self.rangeNow];
    [self updateResultsLabel];
}

// 清除按钮的方法
- (IBAction)cleanAll:(UIButton *)sender {
    //提示框
    NSString *title = @"清除数据";
    NSString *message = @"注意！中奖号码清除以后将不能恢复！";
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    [self showAlertBoxText:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle ifClean:YES setRange:self.rangeNow];
}

// 设置按钮的方法
- (IBAction)setButton:(UIButton *)sender {
    // 设置一个临时变量
    NSInteger tempRange = [self.rangeField.text integerValue];

    if (tempRange > 1) {
        // 提示框
        NSString *title = @"确认";
        NSString *message = [NSString stringWithFormat:@"请点击确定按钮确认将抽奖人数设置成%ld人", tempRange];
        NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);;
        NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
        [self showAlertBoxText:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle ifClean:NO setRange:tempRange];
    } else if (tempRange <= 1) {
        // 提示框
        NSString *title = @"提示";
        NSString *message = @"人数必须大于1人抽奖才有效！！！";
        NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
        NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
        [self showAlertBoxText:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle ifClean:NO setRange:self.rangeNow];
    }
}

// 显示警告提示框
- (void)showAlertBoxText:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle ifClean:(BOOL)clean setRange:(NSInteger)range {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {}];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                            if (clean) {
                                                                [self startAgain];
                                                            } else {
                                                                [self.numberRoll setRangeToRandom:range]; // 传递抽奖人数
                                                            }
                                                            self.rangeField.text = nil;
                                                        }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 键盘隐藏的方法
-(void)viewTapped:(UITapGestureRecognizer*)tapGr {
    [self.rangeField resignFirstResponder];
}

#pragma mark - NumberRollDelegate

- (void)numIsChangedTo:(NSInteger)num {
    self.rangeNow = num;
    [self updateRollLabel];
    
}

@end
