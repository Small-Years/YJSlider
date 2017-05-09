//
//  ViewController.m
//  YJSlider_Demo
//
//  Created by yangjian on 2017/5/4.
//  Copyright © 2017年 yangjian. All rights reserved.
//


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "YJ_Slider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0,50,SCREEN_WIDTH,30)];
    titleLable.text = @"10";
    titleLable.textColor = [UIColor blackColor];
    titleLable.font = [UIFont systemFontOfSize:20];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLable];
    
    
    YJ_Slider *slider = [[YJ_Slider alloc]initWithFrame:CGRectMake(0, 100,SCREEN_WIDTH , 50) WithColor:[UIColor redColor] WithDefaultNum:10 WithMaxValue:20 WithMinValue:8];
    slider.block = ^(int value){
        NSLog(@"选中的值是：%d",value);
        titleLable.text = [NSString stringWithFormat:@"%d",value];
    };
    [self.view addSubview:slider];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
