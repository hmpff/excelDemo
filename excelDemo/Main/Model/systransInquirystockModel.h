//
//  systransInquirystockModel.h
//  ARCHIE
//
//  Created by administrator on 16/12/31.
//  Copyright © 2016年 ARCHIE. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class systransInquirystockModel;
@interface systransInquirystockModel : NSObject

@property (nonatomic ,strong) NSString *date;//交易日期
@property (nonatomic ,strong) NSString *edtby;//操作员
@property (nonatomic ,strong) NSString *itmid;//物料编号
@property (nonatomic ,strong) NSString *itmname;//物料名称
@property (nonatomic ,strong) NSString *locid; //来源仓区
@property (nonatomic ,strong) NSString *locid2;//目的仓区
@property (nonatomic ,strong) NSString *supid;//供应商编号
@property (nonatomic ,strong) NSString *qty;//交易数量
@property (nonatomic ,strong) NSString *qtypst;//过数状态
@property (nonatomic ,strong) NSString *trnid;//交易编号
@property (nonatomic ,strong) NSString *trnitem;//交易行号
@property (nonatomic ,strong) NSString *type;//交易类型

@property (nonatomic ,strong) systransInquirystockModel *systranstockItem;
@end
