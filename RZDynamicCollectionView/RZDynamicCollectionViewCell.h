//
//  RZDynamicCollectionViewCell.h
//  RZDynamicCollectionView
//
//  Created by zy on 2017/3/25.
//  Copyright © 2017年 renwohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZDynamicCollectionModel.h"

@interface RZDynamicCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) RZDynamicCollectionListModel * cell_data;

+ (NSString *)RZDynamicCollectionViewCellIdentify;

@end
