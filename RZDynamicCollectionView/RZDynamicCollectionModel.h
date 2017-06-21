//
//  RZDynamicCollectionModel.h
//  RZDynamicCollectionView
//
//  Created by zy on 2017/3/25.
//  Copyright © 2017年 renwohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZDynamicCollectionListCategoryModel : NSObject

@property (nonatomic,assign) int row;

@property (nonatomic,assign) int col;

@property (nonatomic,  copy) NSString * image_url;

@property (nonatomic,  copy) NSString * category_goods_list;

@end

@interface RZDynamicCollectionListModel : NSObject

@property (nonatomic,  copy) NSString * icon;

@property (nonatomic,  copy) NSString * title;

@property (nonatomic,  copy) NSString * goods_list_url;

@property (nonatomic,strong) NSArray <RZDynamicCollectionListCategoryModel *> * category;

@end

@interface RZDynamicCollectionModel : NSObject

@property (nonatomic,strong) NSArray <RZDynamicCollectionListModel *> * shop_list;

@end
