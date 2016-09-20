//
//  InputBtn.m
//  DIYKeyBoardDemo
//
//  Created by 杨春至 on 16/9/20.
//  Copyright © 2016年 com.hofon. All rights reserved.
//

#import "InputBtn.h"
#import "UIButton+Block.h"
typedef void(^Cblock)(void);
@interface InputBtn ()

@property (nonatomic) UIButtonType type;
@property (nonatomic,copy) Cblock selfBlock;

@end
@implementation InputBtn

+ (instancetype)shareInputBtnByframe:(CGRect)frame ClickAction:(void (^)(void))clickBlock andType:(ButtonType)type{
    return [[self alloc]initWithFrame:frame ClickAction:clickBlock andType:type];
}

- (instancetype)initWithFrame:(CGRect)frame ClickAction:(void (^)(void))clickBlock andType:(ButtonType)type{
    self.selfBlock = clickBlock;
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        [self setTitleColor:[UIColor colorWithRed:51.0/256 green:51.0/256 blue:51.0/256 alpha:1] forState:UIControlStateNormal];
        [self setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1]] forState:UIControlStateHighlighted];
        
     [self handleClickEvent:UIControlEventTouchUpInside withClickBlick:^{
         self.selfBlock();
     }];
    }
    return self;
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    
    [super setTitle:title forState:state];
    if (self.type == KeyButtonTypeOther) {
        [self setTitle:title forState:UIControlStateNormal];
        [self handleClickEvent:UIControlEventTouchUpInside withClickBlick:^{

            self.selfBlock();
            
        }];
    }
}

- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
