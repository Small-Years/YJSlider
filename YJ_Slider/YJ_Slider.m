//
//  YJSlider.m
//  YJSlider
//
//  Created by YJ on 17/5/4.
//  Copyright © 2017年 com.yangjian. All rights reserved.
//

#define padding 13   //左右两边的距离


#import "YJ_Slider.h"

@interface YJ_Slider()
{
    CGFloat _pointX;//滑块的x位置
    CGFloat k_Point;//每个字号需要移动的位置
    
    CGFloat default_Width;//控件的宽度
    CGFloat max_Value;
    CGFloat min_Value;
    
    
    
}

@property (strong,nonatomic)UIView *selectView;
@property (strong,nonatomic)UIView *defaultView;
@property (strong,nonatomic)UIButton *centerBtn;
@end



@implementation YJ_Slider

-(instancetype)initWithFrame:(CGRect)frame WithColor:(UIColor *)bgColor WithDefaultNum:(int)number WithMaxValue:(CGFloat)maxValue WithMinValue:(CGFloat)minValue{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        default_Width = self.bounds.size.width;
        k_Point = default_Width / (maxValue - minValue);
        max_Value = maxValue;
        min_Value = minValue;
        _pointX = (number-min_Value) * k_Point;
        
        _defaultView = [[UIView alloc] initWithFrame:CGRectMake(padding,(self.bounds.size.height - 5)*0.5,default_Width - padding*2, 5)];
        _defaultView.backgroundColor = [UIColor lightGrayColor];
        _defaultView.layer.cornerRadius = 5/2;
        _defaultView.userInteractionEnabled = NO;
        [self addSubview:_defaultView];
        
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(_defaultView.frame.origin.x, _defaultView.frame.origin.y, _defaultView.bounds.size.width,_defaultView.bounds.size.height)];
        _selectView.backgroundColor = bgColor;
        _selectView.layer.cornerRadius = _defaultView.bounds.size.height/2;
        _selectView.userInteractionEnabled = NO;
        [self addSubview:_selectView];
        
        _centerBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, number +5, number +5)];
        _centerBtn.center = CGPointMake(0,padding);
        _centerBtn.userInteractionEnabled = NO;
        _centerBtn.layer.cornerRadius = 6;
        _centerBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _centerBtn.layer.borderWidth = 2;
        _centerBtn.backgroundColor = bgColor;
        [self addSubview:_centerBtn];
        
        [self refreshSlider];
    }
    return self;
}


#pragma mark ---UIColor Touchu
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self changePointX:touch];
    [self refreshSlider];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self changePointX:touch];
    
    int num = _pointX/k_Point+min_Value;
    if (self.block) {
        self.block(num);
    }
    [self refreshSlider];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self changePointX:touch];
    CGFloat num1 = _pointX/k_Point+min_Value;
    int num = _pointX/k_Point+min_Value;
    
    if (num1 > num + 0.5) {
        num = num +1;
    }
    
    if (self.block) {
        self.block(num);
    }
    [self refreshSlider];
    
}

//计算需要移动的x位置
-(void)changePointX:(UITouch *)touch{
    CGPoint point = [touch locationInView:self];
    _pointX = point.x;
    
    if (_pointX < _defaultView.frame.origin.x) {
        _pointX = _defaultView.frame.origin.x;
    }else if (_pointX > (CGRectGetMaxX(_defaultView.frame)-5)){
        _pointX = CGRectGetMaxX(_defaultView.frame)+1;
    }
    
}
-(void)setMaxValue:(int)maxValue{
    //设置k_point
    max_Value = maxValue;
    k_Point = (default_Width - padding*2) / (max_Value - min_Value);
}
-(void)setMinValue:(int)minValue{
    //设置k_point
    min_Value = minValue;
    k_Point = (default_Width - padding*2) / (max_Value - min_Value);
}



-(void)refreshSlider{
    CGFloat Y = _defaultView.center.y ;
    int num = _pointX/((default_Width- padding*2) / (max_Value - min_Value)) +5;
    _centerBtn.frame = CGRectMake(_pointX,Y,num,num);
    _centerBtn.center = CGPointMake(_pointX,_defaultView.center.y);
    _centerBtn.layer.cornerRadius = num/2;
    CGRect rect = [_selectView frame];
    rect.size.width = _pointX - padding;
    _selectView.frame = rect;
}


@end
