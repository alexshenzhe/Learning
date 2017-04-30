//
//  NumberRoll.h
//  Draw
//
//  Created by 沈喆 on 17/2/23.
//  Copyright © 2017年 SEN_ZE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NumberRoll;
@protocol NumberRollDelegate <NSObject>

@optional
- (void)numIsChangedTo:(NSInteger)num;

@end

@interface NumberRoll : NSObject

@property(nullable,weak) id<NumberRollDelegate> delegate;

- (void)startRoll;
- (NSInteger)stopRoll;

- (void)setRangeToRandom:(NSInteger)range;
@end
