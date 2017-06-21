//
//  RZDynamicCollectionModel.m
//  RZDynamicCollectionView
//
//  Created by zy on 2017/3/25.
//  Copyright © 2017年 renwohua. All rights reserved.
//

#import "RZDynamicCollectionModel.h"
#import "MJExtension.h"

@implementation RZDynamicCollectionListCategoryModel

@end

@implementation RZDynamicCollectionListModel

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"category":[RZDynamicCollectionListCategoryModel class]};
}

@end

@implementation RZDynamicCollectionModel

+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"shop_list":[RZDynamicCollectionListModel class]};
}

@end
