//
//  ViewController.m
//  RZDynamicCollectionView
//
//  Created by zy on 2017/3/25.
//  Copyright © 2017年 renwohua. All rights reserved.
//

#import "ViewController.h"
#import "RZDynamicCollectionViewModel.h"
#import "RZDynamicCollectionView.h"

@interface ViewController ()

@property (nonatomic,strong) RZDynamicCollectionViewModel * collect_viewmodel;

@property (nonatomic,  weak) RZDynamicCollectionView * collect_view;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor redColor];
    
    NSLog("Git测试");
    
    self.collect_viewmodel = [[RZDynamicCollectionViewModel alloc]init];
    
    [self blindCollectionViewModel];
    
    [self.collect_viewmodel mockDynamicCollectionData];
}

- (void)blindCollectionViewModel{
    
    [self.collect_viewmodel.collect_subject subscribeNext:^(NSNumber * success) {
        
        if (success.boolValue) {
            
            self.collect_view.collection_datas = self.collect_viewmodel.collect_model.shop_list;
            NSLog(@"成功了");
        }else{
            NSLog(@"失败了");
        }
    }];
}

#pragma mark -make ui
-(RZDynamicCollectionView *)collect_view{
    
    if (!_collect_view) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        RZDynamicCollectionView * view = [[RZDynamicCollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [self.view addSubview:view];
        _collect_view = view;
    }
    return _collect_view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
