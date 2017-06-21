//
//  RZDynamicCollectionViewModel.h
//  RZDynamicCollectionView
//
//  Created by zy on 2017/3/25.
//  Copyright © 2017年 renwohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "RZDynamicCollectionModel.h"

@interface RZDynamicCollectionViewModel : NSObject

@property (nonatomic,strong) RACSubject * collect_subject;

@property (nonatomic,strong) RZDynamicCollectionModel * collect_model;

- (void)mockDynamicCollectionData;

@end
