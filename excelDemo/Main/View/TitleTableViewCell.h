//
//  TitleTableViewCell.h
//  ARCHIE
//
//  Created by administrator on 17/1/7.
//  Copyright © 2017年 ARCHIE. All rights reserved.
//

#import <UIKit/UIKit.h>
@class systransInquirystockModel;
@class InquerytrnddModel;
@interface TitleTableViewCell : UITableViewCell
@property (strong, nonatomic) systransInquirystockModel *Item;
@property (strong, nonatomic) InquerytrnddModel *InquerytrnddItem;

@end
