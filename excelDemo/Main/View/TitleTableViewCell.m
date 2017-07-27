//
//  TitleTableViewCell.m
//  ARCHIE
//
//  Created by administrator on 17/1/7.
//  Copyright © 2017年 ARCHIE. All rights reserved.
//

#import "TitleTableViewCell.h"
#import "systransInquirystockModel.h"
@interface TitleTableViewCell()
@property (nonatomic ,strong)  UILabel *titleL;
@end
@implementation TitleTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setCell];
        
    }
    
    return self;
}
-(void)setCell{
    
    __weak typeof (self) weakSelf = self;
    
    UILabel *titleL = [[UILabel alloc]init];
    titleL.textColor = [UIColor blackColor];
    titleL.backgroundColor = systranTopViewColor;
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont systemFontOfSize:FONT(10)];
    
    [weakSelf addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.width.mas_equalTo(weakSelf.mas_width);
        make.height.mas_equalTo(weakSelf.mas_height);
    }];
    _titleL = titleL;
    
}
-(void)setItem:(systransInquirystockModel *)Item{
    _Item = Item;
    self.titleL.text = Item.itmname;
}

@end
