//
//  UIButton+Block.m
//  docotor
//
//  Created by 杨春至 on 16/7/20.
//  Copyright © 2016年 com.hohon.www. All rights reserved.
//

#import "UIButton+Block.h"

#import <objc/runtime.h>
static char *overViewKey;

@implementation UIButton (Block)
-(void)handleClickEvent:(UIControlEvents)aEvent withClickBlick:(ActionBlock)buttonClickEvent
{
    objc_setAssociatedObject(self, &overViewKey, buttonClickEvent, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(buttonClick) forControlEvents:aEvent];
}
-(void)buttonClick
{
    ActionBlock blockClick = objc_getAssociatedObject(self, &overViewKey);
    if (blockClick != nil)
    {
        blockClick();
    }
}
@end
