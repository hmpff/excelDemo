//
//  DetailTableViewCell.m
//  表格优化展示
//
//  Created by More Mocha on 16/11/9.
//  Copyright © 2016年 QivenDev. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "systransInquirystockModel.h"
@interface DetailTableViewCell()
@property (nonatomic ,strong) UILabel *qtypstLabel;
@property (nonatomic ,strong) UILabel *qtyLabel;
@property (nonatomic ,strong) UILabel *locidLabel;
@property (nonatomic ,strong) UILabel *typeLabel;
@property (nonatomic ,strong) UILabel *trnidLabel;
@property (nonatomic ,strong) UILabel *dateLabel;
@property (nonatomic ,strong) UILabel *edtbyLabel;
@end
@implementation DetailTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setCell];

    }
    
    return self;
}

-(void)setItem:(systransInquirystockModel *)Item{
    
    _Item = Item;
    self.edtbyLabel.text = Item.edtby;
    self.dateLabel.text = Item.date;
    self.trnidLabel.text = Item.trnid;
    self.typeLabel.text = Item.type;
    self.locidLabel.text = Item.locid;
    self.qtyLabel.text = Item.qty;
    self.qtypstLabel.text = Item.qtypst;
   
}
-(void)setCell{

     __weak typeof (self) weakSelf = self;
    
    UILabel *edtbyLabel = [[UILabel alloc]init];
    edtbyLabel.textColor = [UIColor lightGrayColor];
    edtbyLabel.textAlignment = NSTextAlignmentCenter;
    edtbyLabel.font = [UIFont systemFontOfSize:FONT(10)];
    
    [weakSelf addSubview:edtbyLabel];
    [edtbyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf);
        make.width.mas_equalTo(kAverageTableViewWidth);
    }];
    _edtbyLabel = edtbyLabel;
    
    UILabel *dateLabel = [[UILabel alloc]init];
    dateLabel.textColor = [UIColor lightGrayColor];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.font = [UIFont systemFontOfSize:FONT(10)];
    
    [weakSelf addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(edtbyLabel.mas_right);
        make.centerY.equalTo(weakSelf);
        make.width.mas_equalTo(kAverageTableViewWidth);
    }];
    _dateLabel = dateLabel;
    
    UILabel *locidLabel = [[UILabel alloc]init];
    locidLabel.textColor = [UIColor lightGrayColor];
    locidLabel.textAlignment = NSTextAlignmentCenter;
    locidLabel.font = [UIFont systemFontOfSize:FONT(10)];
    
    [weakSelf addSubview:locidLabel];
    [locidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateLabel.mas_right);
        make.centerY.equalTo(weakSelf);
        make.width.mas_equalTo(kAverageTableViewWidth);
    }];
    _locidLabel = locidLabel;
    
    UILabel *trnidLabel = [[UILabel alloc]init];
    trnidLabel.textColor = [UIColor lightGrayColor];
    trnidLabel.textAlignment = NSTextAlignmentCenter;
    trnidLabel.font = [UIFont systemFontOfSize:FONT(10)];
    
    [weakSelf addSubview:trnidLabel];
    [trnidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locidLabel.mas_right);
        make.centerY.equalTo(weakSelf);
        make.width.mas_equalTo(kAverageTableViewWidth);
    }];
    _trnidLabel = trnidLabel;
    
    UILabel *typeLabel = [[UILabel alloc]init];
    typeLabel.textColor = [UIColor lightGrayColor];
    typeLabel.textAlignment = NSTextAlignmentCenter;
    typeLabel.font = [UIFont systemFontOfSize:FONT(10)];
    
    [weakSelf addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(trnidLabel.mas_right);
        make.centerY.equalTo(weakSelf);
        make.width.mas_equalTo(kAverageTableViewWidth);
    }];
    _typeLabel = typeLabel;
    
    UILabel *qtyLabel = [[UILabel alloc]init];
    qtyLabel.textColor = [UIColor lightGrayColor];
    qtyLabel.textAlignment = NSTextAlignmentCenter;
    qtyLabel.font = [UIFont systemFontOfSize:FONT(10)];
    
    [weakSelf addSubview:qtyLabel];
    [qtyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(typeLabel.mas_right);
        make.centerY.equalTo(weakSelf);
        make.width.mas_equalTo(kAverageTableViewWidth);
    }];
    _qtyLabel = qtyLabel;
    
    UILabel *qtypstLabel = [[UILabel alloc]init];
    qtypstLabel.textColor = [UIColor lightGrayColor];
    qtypstLabel.textAlignment = NSTextAlignmentCenter;
    qtypstLabel.font = [UIFont systemFontOfSize:FONT(10)];
    
    [weakSelf addSubview:qtypstLabel];
    [qtypstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(qtyLabel.mas_right);
        make.centerY.equalTo(weakSelf);
        make.width.mas_equalTo(kAverageTableViewWidth);
    }];
    _qtypstLabel = qtypstLabel;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [weakSelf addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.height.equalTo(@1);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(weakSelf.mas_width);
    }];
    

}
@end
