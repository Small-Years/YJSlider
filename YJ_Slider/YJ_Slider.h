//
//  YJSlider.h
//  YJSlider
//
//  Created by YJ on 17/5/4.
//  Copyright © 2017年 com.yangjian. All rights reserved.
//
typedef void(^valueChangeBlock)(int index);

#import <UIKit/UIKit.h>

@interface YJ_Slider : UIControl

/**
 *  回调
 */
@property (nonatomic,copy)valueChangeBlock block;


-(instancetype)initWithFrame:(CGRect)frame WithColor:(UIColor *)color WithDefaultNum:(int)number WithMaxValue:(CGFloat)maxValue WithMinValue:(CGFloat)minValue;



@property(nonatomic,assign)int maxValue;//最大值
@property(nonatomic,assign)int minValue;//最小值

@end
