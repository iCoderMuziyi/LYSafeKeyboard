//
//  LYKey.m
//  LYSafeKeyboard
//
//  Created by Mr Li on 16/10/21.
//  Copyright © 2016年 Mr_Li. All rights reserved.
//

#import "LYKey.h"

@interface LYKey ()

@property (weak, nonatomic) IBOutlet UILabel *titileLab;

@end

@implementation LYKey

- (void)awakeFromNib {

    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithRed:0xe6 green:0xe6 blue:0xe6 alpha:1].CGColor;
}

- (void)setTitle:(NSString *)title{
    
    _title = title;
    self.titileLab.text = _title;
}

@end
