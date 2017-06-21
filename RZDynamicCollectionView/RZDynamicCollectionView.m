//
//  RZDynamicCollectionView.m
//  RZDynamicCollectionView
//
//  Created by zy on 2017/3/25.
//  Copyright © 2017年 renwohua. All rights reserved.
//

#import "RZDynamicCollectionView.h"
#import "RZDynamicCollectionViewCell.h"

@interface RZDynamicCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation RZDynamicCollectionView

// 默认一行3列
static const int columnCount = 3;

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.contentSize = self.bounds.size;
        
        [self registerClass:[RZDynamicCollectionViewCell class] forCellWithReuseIdentifier:[RZDynamicCollectionViewCell RZDynamicCollectionViewCellIdentify]];
    }
    return self;
}

#pragma mark -collection delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.collection_datas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RZDynamicCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RZDynamicCollectionViewCell RZDynamicCollectionViewCellIdentify] forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RZDynamicCollectionViewCell * dynamic_cell = (RZDynamicCollectionViewCell *)cell;
    dynamic_cell.cell_data = self.collection_datas[indexPath.section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RZDynamicCollectionListModel * model = self.collection_datas[indexPath.section];
    
    CGFloat itemW = CGRectGetWidth(self.bounds);
    CGFloat itemH = 0.f;
    
    if (![model.title isEqualToString:@""]) {
        
        itemH += 40.f;
    }
    int col = 0;
    for (int i = 0; i < model.category.count; i++) {
        
        RZDynamicCollectionListCategoryModel * category_model = model.category[i];
        col += category_model.col;
        
        for (int i = 0; i < category_model.row-1; i++) {
            col += category_model.col;
        }
    }
    
    int columnNum = col%columnCount>0?1:0;
    itemH += 118.f * (col/columnCount+columnNum);
    
    return CGSizeMake(itemW, itemH);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
