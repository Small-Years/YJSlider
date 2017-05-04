//
//  YJSlider.m
//  YJSlider
//
//  Created by YJ on 17/5/4.
//  Copyright © 2017年 com.yangjian. All rights reserved.
//


//#define LiuXSlideWidth      (self.bounds.size.width)
//#define LiuXSliderHight     (self.bounds.size.height)
//
//#define LiuXSliderTitle_H   (LiuXSliderHight*.3)
//
//#define CenterImage_W       26.0
//
//#define LiuXSliderLine_W    (LiuXSlideWidth-CenterImage_W)
//#define LiuXSLiderLine_H    6.0
//#define LiuXSliderLine_Y    (LiuXSliderHight-LiuXSliderTitle_H)
//
//#define CenterImage_Y       (LiuXSliderLine_Y+(LiuXSLiderLine_H/2))

#import "YJ_Slider.h"

@interface YJ_Slider()
{
    CGFloat _pointX;//滑块的位置
    CGFloat k_Point;//每个字号需要移动的位置
}


@property (strong,nonatomic)UIView *selectView;
@property (strong,nonatomic)UIView *defaultView;
@property (strong,nonatomic)UIButton *centerBtn;
@end

@implementation YJ_Slider

-(instancetype)initWithFrame:(CGRect)frame WithColor:(UIColor *)bgColor WithDefaultNum:(int)number{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        k_Point = (self.bounds.size.width- 26) / 20;
        _pointX = number * k_Point;
        
        _defaultView = [[UIView alloc] initWithFrame:CGRectMake(13,(self.bounds.size.height - 5)*0.5,self.bounds.size.width - 26, 5)];
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
        _centerBtn.center = CGPointMake(0,13);
        _centerBtn.userInteractionEnabled = NO;
        _centerBtn.layer.cornerRadius = 6;
        _centerBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _centerBtn.layer.borderWidth = 2;
        _centerBtn.backgroundColor = bgColor;
        _centerBtn.center = CGPointMake(_pointX,_defaultView.center.y);
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
    int num = (int)_pointX/((self.bounds.size.width- 26) / 20);
    if (self.block) {
        self.block(num);
    }
    [self refreshSlider];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self changePointX:touch];
//    int num = (int)_pointX/((self.bounds.size.width- 26) / 20);
//    if (self.block) {
//        self.block(num);
//    }
    [self refreshSlider];
    
}

//计算需要移动的x位置
-(void)changePointX:(UITouch *)touch{
    CGPoint point = [touch locationInView:self];
    _pointX = point.x;
    
    if (_pointX < _defaultView.frame.origin.x+13) {
        _pointX = _defaultView.frame.origin.x+13;
    }else if (_pointX > CGRectGetMaxX(_defaultView.frame)-13){
        _pointX = CGRectGetMaxX(_defaultView.frame)-13;
    }
    
}

-(void)refreshSlider{
    
    
    CGFloat Y = _defaultView.center.y ;
    int num = _pointX/((self.bounds.size.width- 26) / 20) +5;
    _centerBtn.frame = CGRectMake(_pointX,Y,num,num);
    _centerBtn.center = CGPointMake(_pointX,_defaultView.center.y);
    _centerBtn.layer.cornerRadius = num/2;
    
    CGRect rect = [_selectView frame];
    rect.size.width = _pointX - 26/2;
    _selectView.frame = rect;
    
    
}


@end
