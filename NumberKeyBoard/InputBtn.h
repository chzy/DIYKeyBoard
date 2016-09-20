//
//  InputBtn.h
//  DIYKeyBoardDemo
//
//  Created by 杨春至 on 16/9/20.
//  Copyright © 2016年 com.hofon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Block.h"
#import "AllDefine.h"
@interface InputBtn : UIButton
+ (instancetype)shareInputBtnByframe:(CGRect)frame ClickAction:(void(^)(void))clickBlock andType:(ButtonType)type;

//- (instancetype)initWithFrame:(CGRect)frame ClickAction:(void(^)(ButtonType))clickBlock;

@end
