//
//  ViewController.m
//  DIYKeyBoardDemo
//
//  Created by 杨春至 on 16/9/20.
//  Copyright © 2016年 com.hofon. All rights reserved.
//

#import "ViewController.h"
#import "NumberKeyBoard.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *testTextField;
@property (nonatomic,strong)NumberKeyBoard *numKeyBoard;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _testTextField.inputView = self.numKeyBoard;
    [self numKeyBoard];
}

- (NumberKeyBoard *)numKeyBoard{
    if (!_numKeyBoard) {
        _numKeyBoard = [NumberKeyBoard numberKeyBoardWithFrame:CGRectZero byTextfied:_testTextField];
    }
    return _numKeyBoard;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
