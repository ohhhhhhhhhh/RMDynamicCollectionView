//
//  RZDynamicCollectionViewModel.m
//  RZDynamicCollectionView
//
//  Created by zy on 2017/3/25.
//  Copyright © 2017年 renwohua. All rights reserved.
//

#import "RZDynamicCollectionViewModel.h"
#import "MJExtension.h"

@implementation RZDynamicCollectionViewModel

-(instancetype)init{
    
    if (self = [super init]) {
        
        self.collect_subject = [RACSubject subject];
        self.collect_model = [[RZDynamicCollectionModel alloc]init];
    }
    return self;
}

- (void)mockDynamicCollectionData{
    
    NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"RZDynamicCollectionMockData" ofType:@"json"]];
    NSError * error = nil;
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    if (!error) {
        self.collect_model = [RZDynamicCollectionModel mj_objectWithKeyValues:dict];
        [self.collect_subject sendNext:@(YES)];
    }else{
         [self.collect_subject sendNext:@(NO)];
    }
}

@end
