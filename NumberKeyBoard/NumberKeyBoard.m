//
//  NumberKeyBoard.m
//  DIYKeyBoardDemo
//
//  Created by 杨春至 on 16/9/20.
//  Copyright © 2016年 com.hofon. All rights reserved.
//

#import "NumberKeyBoard.h"
#import "InputBtn.h"
#import "AllDefine.h"
static CGFloat numKeyBoardHeight = 230;

//左侧输入按钮数量  （0~9 . 键盘收起）
static NSInteger const numKeyBtnCount1 = 12;
//右侧则为删除和确定
typedef void(^Cblock)(void);

@interface NumberKeyBoard ()
//@property (nonatomic,copy) Cblock selfblock;

//属于自己的textfield
@property (nonatomic,weak)UITextField *selftextField;
@end
@implementation NumberKeyBoard

+(instancetype)numberKeyBoardWithFrame:(CGRect)frame byTextfied:(UITextField *)textfield{
    NumberKeyBoard *selfview = [[self alloc]initWithFrame:frame];
    selfview.selftextField = textfield;
    textfield.inputView = selfview;
    return selfview;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (CGRectEqualToRect(frame, CGRectZero)) {
        frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, numKeyBoardHeight);
    }
    if ([super initWithFrame:frame]) {
        
        [self addBTNS];
    }
    self.backgroundColor = [UIColor redColor];
    return self;
}
//装配按键
- (void)addBTNS{
    int row = 4;
    int column = 3;
    NSArray *numArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@".",@"0"];
    CGFloat Kwidth = [UIScreen mainScreen].bounds.size.width/(column +1);
    CGFloat Kheight = numKeyBoardHeight/row;
    
    for (int i = 0; i < numKeyBtnCount1; i++) {
        int perColumn = i%column;
        int perRow = i/column;
        InputBtn *btn = [InputBtn shareInputBtnByframe:CGRectMake(perColumn*Kwidth, perRow*Kheight, Kwidth, Kheight) ClickAction:^{
            
        } andType:i==numKeyBtnCount1-1?KeyButtonEndEdit:KeyButtonTypeOther];
        if (i!=numKeyBtnCount1-1) {
            [btn setTitle:[NSString stringWithFormat:@"%@",numArray[i]] forState:UIControlStateNormal];
            [btn handleClickEvent:UIControlEventTouchUpInside withClickBlick:^{
                [self changetext:numArray[i]];
            }];
        }else{

            btn.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"键盘收"].CGImage);
            btn.layer.contentsGravity = kCAGravityResizeAspect;
            [btn handleClickEvent:UIControlEventTouchUpInside withClickBlick:^{
                [self.selftextField endEditing:YES];
            }];
        }
        [self addSubview:btn];
    }
//额外项
    InputBtn *deletBtn = [InputBtn shareInputBtnByframe:CGRectMake(Kwidth*column, 0, Kwidth, numKeyBoardHeight/2.0) ClickAction:^{
        [self changetext:@""];
    } andType:KeyButtonTypeDel];
  
    CALayer *delLayer = [CALayer layer];
    delLayer.frame = CGRectMake(0, 0, Kwidth*0.4, Kwidth*0.4);
    delLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"文字删除"].CGImage);
    delLayer.position = CGPointMake(deletBtn.bounds.size.width/2.0, deletBtn.bounds.size.height/2.0);
    delLayer.contentsGravity = kCAGravityResizeAspect;
    [deletBtn.layer  addSublayer:delLayer];
    [self addSubview:deletBtn];
    
    
    InputBtn *compeletBtn = [InputBtn shareInputBtnByframe:CGRectMake(Kwidth*column, numKeyBoardHeight/2.0, Kwidth, numKeyBoardHeight/2.0) ClickAction:^{
        
        [self.selftextField endEditing:YES];
        
    } andType:KeyButtonTypeDone];
    [compeletBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self addSubview:compeletBtn];
    
    
    CGFloat lineX = 0;
    CGFloat lineY = 0;

    [self addSubview:[self creatLineViewByCGRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.6)]];
    
    for (int i = 0; i < row; i++) {
            lineY = i*Kheight;
        [self addSubview:[self creatLineViewByCGRect:CGRectMake(0, lineY,i!=2?Kwidth*column:Kwidth*(column+1), 0.6)]];
    }
    
    for (int i = 0; i < column+1; i++) {
            lineX = i*Kwidth;
            [self addSubview:[self creatLineViewByCGRect:CGRectMake(lineX, 0, 0.3, numKeyBoardHeight)]];
    }
    
}
- (UIView *)creatLineViewByCGRect:(CGRect)frame{
    UIView *lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = [UIColor grayColor];
    return lineView;
}

/**
 *  修改textField中的文字
 */
- (void)changetext:(NSString *)text {
    UITextPosition *beginning = self.selftextField.beginningOfDocument;
    UITextPosition *start = self.selftextField.selectedTextRange.start;
    UITextPosition *end = self.selftextField.selectedTextRange.end;
    NSInteger startIndex = [self.selftextField offsetFromPosition:beginning toPosition:start];
    NSInteger endIndex = [self.selftextField offsetFromPosition:beginning toPosition:end];
    
    // 将输入框中的文字分成两部分，生成新字符串，判断新字符串是否满足要求
    NSString *originText = self.selftextField.text;
    NSString *part1 = [originText substringToIndex:startIndex];
    NSString *part2 = [originText substringFromIndex:endIndex];
    
    NSInteger offset;
    
    if (![text isEqualToString:@""]) {
        offset = text.length;
    } else {
        if (startIndex == endIndex) { // 只删除一个字符
            if (startIndex == 0) {
                return;
            }
            offset = -1;
            part1 = [part1 substringToIndex:(part1.length - 1)];
        } else {
            offset = 0;
        }
    }
    
    NSString *newText = [NSString stringWithFormat:@"%@%@%@", part1, text, part2];
    self.selftextField.text = newText;
    
    // 重置光标位置
    UITextPosition *now = [self.selftextField positionFromPosition:start offset:offset];
    UITextRange *range = [self.selftextField textRangeFromPosition:now toPosition:now];
    self.selftextField.selectedTextRange = range;
}


@end
