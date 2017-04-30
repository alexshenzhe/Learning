//
//  NumberRoll.m
//  Draw
//
//  Created by 沈喆 on 17/2/23.
//  Copyright © 2017年 SEN_ZE. All rights reserved.
//

#import "NumberRoll.h"

@interface NumberRoll ()

@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, assign) NSInteger randomNum;
@property (nonatomic, assign) NSInteger range; // 用户输入的抽奖人数

@end

@implementation NumberRoll

- (void)startRoll {
    int i = 1;
    if (![self.myTimer isValid]) {
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:i
                                                        target:self
                                                      selector:@selector(timerAction:)
                                                      userInfo:nil
                                                       repeats:YES];
    }
}

- (NSInteger)stopRoll {
    //先判断定时器是否在运行
    if ([self.myTimer isValid]) {
        [self.myTimer invalidate];//关闭定时器
        self.myTimer = nil;//释放myTimer对象
    }
    return self.randomNum;
}


// 定时器的方法
- (void)timerAction:(NSTimer *)timer {
    [self setRandomRange:self.range];
    [_delegate numIsChangedTo:self.randomNum];
}

//生成随机数方法
- (void)setRandomRange:(NSInteger)randomRange {
    NSInteger range;
    if (randomRange == 0) {
        range = 500;
    }else {
        range = randomRange;
    }
   
    self.randomNum = (arc4random() % range) + 1;
}

- (void)setRangeToRandom:(NSInteger)range {
    self.range = range;
}

@end
