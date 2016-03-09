//
//  ViewController.m
//  Draw
//
//  Created by 沈喆 on 16/3/4.
//  Copyright © 2016年 SEN_ZE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSInteger randomValue;
    NSTimer *myTimer;
    NSInteger showValue;
    NSMutableString *allNumber;
    NSInteger randomRange;
}

@end

@implementation ViewController
//生成随机数方法
- (void)randomNumber {
    if (randomRange == 0) {
        randomValue = (arc4random() % 500) + 1;
    }else {
        randomValue = (arc4random() % randomRange) + 1;
    }
    
}

//更新Label文字的方法
- (void)updateLabel {
    self.rollLabel.text = [NSString stringWithFormat:@"%ld",randomValue];
    self.showLabel.text = [NSString stringWithFormat:@"%ld",showValue];
    self.showNumber.text = [NSString stringWithFormat:@"%@",allNumber];
}

//滚动显示方法
- (void)rollshow {
    int i = 0.1;
    if (![myTimer isValid]) {
        myTimer = [NSTimer scheduledTimerWithTimeInterval:i
                                                   target:self
                                                 selector:@selector(timerAction:)
                                                 userInfo:nil
                                                  repeats:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (allNumber == nil) {
        allNumber = [NSMutableString stringWithFormat:@"本次中奖号码:"];
    }
    [self updateLabel];
    
    // 创建自定义的触摸手势来实现对键盘的隐藏
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重新开始方法
- (void)startAgain {
    randomValue = 0;
    showValue = 0;
    allNumber = [NSMutableString stringWithFormat:@"本次中奖号码:"];
    [self updateLabel];
}

//开始抽奖按钮的方法
- (IBAction)beginDraw:(UIButton *)sender {
    [self rollshow];

}

//停止抽奖按钮的方法
- (IBAction)stopRoll:(UIButton *)sender {
    //先判断定时器是否在运行
    if ([myTimer isValid]) {
        [myTimer invalidate];//关闭定时器
        myTimer = nil;//释放myTimer对象
        
        //拼接字符串，将产生的中奖号码进行拼接
        allNumber = [NSMutableString stringWithFormat:@"%@ %ld",allNumber,randomValue];
    }
    showValue = randomValue;
    [self updateLabel];
}

//定时器的方法
- (void)timerAction:(NSTimer *)timer {
    [self randomNumber];
    [self updateLabel];
}


//清除按钮的方法
- (IBAction)cleanAll:(UIButton *)sender {
    //提示框
    NSString *title = @"清除数据";
    NSString *message = @"注意！中奖号码清除以后将不能恢复！";
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {}];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                            [self startAgain];
                                                        }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

//设置按钮的方法
- (IBAction)setButton:(UIButton *)sender {
    //设置一个临时变量
    NSInteger rangeNow = [self.rangeField.text integerValue];

    if (rangeNow > 1) {
        randomRange = rangeNow;
        //提示框
        NSString *title = @"设置成功";
        NSInteger text = [self.rangeField.text integerValue];
        NSString *message = [NSString stringWithFormat:@"您已经成功将抽奖人数设置成%ld人",text];
        NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                self.rangeField.text = nil;
                                                            }];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if (rangeNow <= 1) {
        //提示框
        NSString *title = @"提示";
        NSString *message = @"大哥，请确认人数以后再输入！\n人数要大于1人！！！";
        NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                self.rangeField.text = nil;
                                                            }];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

//键盘隐藏的方法
-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    [self.rangeField resignFirstResponder];
}
@end
