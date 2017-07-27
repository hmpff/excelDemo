//
//  TopCollectionViewCell.m
//  表格优化展示
//
//  Created by More Mocha on 16/11/8.
//  Copyright © 2016年 QivenDev. All rights reserved.
//

#import "TopCollectionViewCell.h"
@interface TopCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *edtbyLabel;

@end
@implementation TopCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    self.frame = CGRectMake(0, 0, (ARCHIEScreenW/3)*7, 30);
}


@end
