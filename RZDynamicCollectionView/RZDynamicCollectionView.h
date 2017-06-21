//
//  RZDynamicCollectionView.h
//  RZDynamicCollectionView
//
//  Created by zy on 2017/3/25.
//  Copyright © 2017年 renwohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZDynamicCollectionModel.h"

@interface RZDynamicCollectionView : UICollectionView

@property (nonatomic,strong) NSArray <RZDynamicCollectionListModel *> * collection_datas;

@end
