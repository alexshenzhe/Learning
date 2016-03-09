//
//  ViewController.h
//  Draw
//
//  Created by 沈喆 on 16/3/4.
//  Copyright © 2016年 SEN_ZE. All rights reserved.
//
//该例子，用到了定时器，以及定时器的启动和停止！

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)beginDraw:(UIButton *)sender;//开始抽奖按钮
- (IBAction)stopRoll:(UIButton *)sender;//停止抽奖按钮
- (IBAction)cleanAll:(UIButton *)sender;//清空按钮
- (IBAction)setButton:(UIButton *)sender;//设置按钮



@property (weak, nonatomic) IBOutlet UILabel *rollLabel;//滚动显示区
@property (weak, nonatomic) IBOutlet UILabel *showLabel;//中奖显示区
@property (strong, nonatomic) IBOutlet UITextView *showNumber;//所有中奖显示区
@property (weak, nonatomic) IBOutlet UITextField *rangeField;//随机范围输入框

- (void)updateLabel;//更新Label文字
- (void)rollshow;//滚动显示
- (void)startAgain;//重新开始
- (void)randomNumber;//生成随机数
-(void)viewTapped:(UITapGestureRecognizer*)tapGr;//键盘隐藏
- (void)timerAction:(NSTimer *)timer;//定时器

@end

