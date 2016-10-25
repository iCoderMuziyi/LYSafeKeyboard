//
//  ViewController.m
//  LYSafeKeyboard
//
//  Created by Mr Li on 16/10/20.
//  Copyright © 2016年 Mr_Li. All rights reserved.
//

#import "ViewController.h"
#import <sys/utsname.h>
#import "LYSafeKeyBoardView.h"

@interface ViewController ()


@property (nonatomic, strong) UITextField        * textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.textField];
}


- (UITextField *)textField{
    
    if (!_textField) {
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 100)];
        _textField.backgroundColor = [UIColor cyanColor];
        _textField.inputView = LY_SAFE_KEYBOARD;
        LY_SAFE_KEYBOARD.clickKeyBlock = ^(NSString * value){
            
            if ([value isEqualToString:@"DELETE"]) {
                
                if (self.textField.text.length > 0) {
                    
                    self.textField.text = [self.textField.text substringToIndex:self.textField.text.length - 1];
                    
                }else{
                    
                    return;
                }
                
            }else{
                
                self.textField.text = [NSString stringWithFormat:@"%@%@", self.textField.text, value];
            }
        };

        }
    return _textField;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch * tc = [touches anyObject];
    if (tc.view != self.textField) {
        
        [self.textField resignFirstResponder];
    }
}

@end
