//
//  RZDynamicCollectionViewCell.m
//  RZDynamicCollectionView
//
//  Created by zy on 2017/3/25.
//  Copyright © 2017年 renwohua. All rights reserved.
//

#import "RZDynamicCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface RZDynamicCollectionViewCell ()

@property (nonatomic,strong) UIView * back_view;

// title item
@property (nonatomic,  weak) UIImageView * title_imgview;
@property (nonatomic,  weak) UILabel * title_label;
@property (nonatomic,  weak) UIImageView * arrow_imgview;

// img 默认 width and height
@property (nonatomic,assign) CGFloat img_width;
@property (nonatomic,assign) CGFloat img_height;

@property (nonatomic,strong) UILabel * top_line;
@property (nonatomic,strong) UILabel * bottom_line;


@end

@implementation RZDynamicCollectionViewCell

// 默认列间距
static const CGFloat columnMargin = 5;
// 默认行间距
static const CGFloat rowMargin = 0.f;
// 默认一行三列
static const CGFloat columnCount = 3;
// 默认行高
static const CGFloat rowHeight = 117.f;


+ (NSString *)RZDynamicCollectionViewCellIdentify{
    return @"RZDynamicCollectionViewCellIdentify";
}

-(void)setCell_data:(RZDynamicCollectionListModel *)cell_data{
    
    _cell_data = cell_data;
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat imageX = 0.f;
    CGFloat imageY = 0.f;
    CGFloat imageW = (CGRectGetWidth(self.contentView.bounds)-columnMargin*(columnCount-1))/columnCount;
    CGFloat imageH = rowHeight;
    
    if (![cell_data.title isEqualToString:@""]) {
        // 有 类别
        imageY += CGRectGetHeight(self.back_view.frame);
        
        [self.contentView addSubview:self.back_view];
        // 赋值
//        self.title_imgview.image = [UIImage imageNamed:cell_data.icon];
        self.title_label.text = cell_data.title;
        self.arrow_imgview.hidden = NO;
    }
    
    // 每一列的高
    NSMutableArray * columnHeights = [NSMutableArray array];
    for (int i = 0; i < columnCount; i++) {
        [columnHeights addObject:@(imageY)];
    }
    
    for (int i = 0; i < cell_data.category.count; i++) {
        
        RZDynamicCollectionListCategoryModel * model = cell_data.category[i];
        
        int col = model.col;
        int row = model.row;
        
        CGFloat imageViewW = col * imageW + columnMargin * (col-1);
        CGFloat imageViewH = row * imageH + rowMargin * (row-1);
        
        // 找出最短的那列
        // 第几列
        int minHeightCol = 0;
        // 列的高度
        NSNumber * minHeight = columnHeights[0];
        
        for (int i = 0; i < columnHeights.count; i++) {
            
            if ([columnHeights[i] intValue] < minHeight.intValue) {
                minHeight = columnHeights[i];
                minHeightCol = i;
            }
        }
        
        imageY = minHeight.intValue;
        imageX = (imageW + columnMargin) * minHeightCol;
        
        if (imageX + imageViewW > CGRectGetWidth(self.contentView.bounds) || imageX >= CGRectGetWidth(self.contentView.bounds) || imageX < 0.f) {
            
            imageX = 0;
            imageY = [columnHeights[0] intValue];
            minHeightCol = 0;
        }
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:model.image_url];
        [self.contentView addSubview:imageView];
        imageView.frame = CGRectMake(imageX, imageY, imageViewW, imageViewH);
        
        for (int i = 0; i < col; i++) {
            
            int minColHeight = [columnHeights[minHeightCol+i] intValue];
            minColHeight += imageViewH;
            [columnHeights replaceObjectAtIndex:minHeightCol+i withObject:@(minColHeight)];
        }
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RZDynamicCollectionViewTap:)];
        [imageView addGestureRecognizer:tap];
        
        // 如果不是一行一张图的话 就有线
        if (col != columnCount) {
            
            [self.contentView addSubview:self.top_line];
            self.bottom_line.frame = CGRectMake(0.f, CGRectGetMaxY(imageView.frame), CGRectGetWidth(self.contentView.bounds), 0.5);
            [self.contentView addSubview:self.bottom_line];
        }
    }
}

#pragma mark -click
- (void)RZDynamicCollectionViewTap:(UITapGestureRecognizer *)tap{
    
    NSInteger tag = tap.view.tag;
    NSLog(@"-------------  function = %s ,tag = %ld",__func__,tag);
}


#pragma mark -ui
#pragma mark -back view
-(UIView *)back_view{
    
    if (!_back_view) {
        
        _back_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 40.f)];
        _back_view.backgroundColor = [UIColor whiteColor];
        _back_view.tag = 666;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RZDynamicCollectionViewTap:)];
        [_back_view addGestureRecognizer:tap];
    }
    return _back_view;
}

// 小竖条
-(UIImageView *)title_imgview{
    
    if (!_title_imgview) {
        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 8.f, 6.f, 24.f)];
        img.backgroundColor = [UIColor redColor];
        [self.back_view addSubview:img];
        _title_imgview = img;
    }
    return _title_imgview;
}

// title Label
-(UILabel *)title_label{
    
    if (!_title_label) {
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.title_imgview.frame)+8.f, CGRectGetMidY(self.title_imgview.frame)-7.f, CGRectGetWidth(self.bounds)-CGRectGetMaxX(self.title_imgview.frame)-8.f-10.f-8.f, 14.f)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        [self.back_view addSubview:label];
        _title_label = label;
    }
    return _title_label;
}

// 右侧小箭头
-(UIImageView *)arrow_imgview{
    
    if (!_arrow_imgview) {
        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)-7.f-8.f, CGRectGetMidY(self.title_imgview.frame)-6.f, 7.f, 12.f)];
        img.image = [UIImage imageNamed:@"ic_enter"];
        [self.back_view addSubview:img];
        _arrow_imgview = img;
    }
    return _arrow_imgview;
}

// top_line
-(UILabel *)top_line{
    
    if (!_top_line) {
        
        _top_line = [[UILabel alloc]initWithFrame:CGRectMake(16.f, CGRectGetMaxY(self.back_view.frame), CGRectGetWidth(self.bounds)-16.f, 0.5)];
        _top_line.backgroundColor = [UIColor lightGrayColor];
    }
    return _top_line;
}

// bottom_line
-(UILabel *)bottom_line{
    
    if (!_bottom_line) {
        
        _bottom_line = [[UILabel alloc]init];
        _bottom_line.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottom_line;
}

@end
