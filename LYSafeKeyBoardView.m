//
//  LYSafeKeyBoardView.m
//  LYSafeKeyboard
//
//  Created by Mr Li on 16/10/20.
//  Copyright © 2016年 Mr_Li. All rights reserved.
//

#import "LYSafeKeyBoardView.h"
#import "LYKey.h"
//屏幕宽度
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
//键盘的高度（我确认了自带的数字键盘高度  只有6sp的键盘高度为226 其他为216）
#define KEYBOARD_HEIGHT     (SCREEN_WIDTH == 736 ? 226 : 216)
//键的高度
#define KEY_HEIGHT          KEYBOARD_HEIGHT / 4.0f
//键的宽度
#define KEY_WIDTH           SCREEN_WIDTH / 3.0f

@interface LYSafeKeyBoardView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView        * collectionView;
@property (nonatomic, strong) NSMutableArray          * dataArr;

@end

@implementation LYSafeKeyBoardView

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self showKeyboard];
    }
    return self;
}

#pragma mark - 单例
+ (LYSafeKeyBoardView *)shareKeyBoard{
    
    static LYSafeKeyBoardView * keyBoard = nil;
    static dispatch_once_t pre;
    dispatch_once(&pre, ^{
        
        keyBoard = [[LYSafeKeyBoardView alloc]init];
        
    });
    return keyBoard;
}
#pragma mark - 显示键盘
- (void)showKeyboard{
    
    [self addSubview:self.collectionView];
    self.frame = CGRectMake(0, SCREEN_HEIGHT - KEYBOARD_HEIGHT, SCREEN_WIDTH, KEYBOARD_HEIGHT);
}

#pragma mark - 重写collectionView的get方法
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KEYBOARD_HEIGHT) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"LYKey" bundle:nil] forCellWithReuseIdentifier:@"LYKey"];
    }
    return _collectionView;
}

#pragma mark - 重写dataArr的get方法
- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        NSMutableArray * initArr = [NSMutableArray arrayWithArray:@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"]];
        _dataArr = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (NSInteger i = 0; i < 10; i++) {
            
            NSInteger randNum = arc4random() % initArr.count;
            _dataArr[i] = initArr[randNum];
            initArr[randNum] = [initArr lastObject];
            [initArr removeLastObject];
        }
        [_dataArr insertObject:@"SPACE" atIndex:9];
        [_dataArr insertObject:@"DELETE" atIndex:11];
    }
        return _dataArr;
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LYKey * key = [collectionView dequeueReusableCellWithReuseIdentifier:@"LYKey" forIndexPath:indexPath];
    
    if (self.dataArr.count > 0) {
        
        if (indexPath.row == 9 || indexPath.row == 11) {
            
            [key.contentView addSubview:[self getImageViewWithImageName:self.dataArr[indexPath.row]]];
            
        }else{
            
            key.title = self.dataArr[indexPath.row];
        }
    }
    return key;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(KEY_WIDTH, KEY_HEIGHT);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 9) {
        
        return;
    }
    if (self.clickKeyBlock) {
        
        self.clickKeyBlock(self.dataArr[indexPath.row]);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UIImageView *)getImageViewWithImageName:(NSString *)imageName{
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KEY_WIDTH, KEY_HEIGHT)];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

@end
