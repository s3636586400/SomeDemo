//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by 解炳灿 on 16/4/14.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *mainVIew;

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];

}

-(void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)initView {
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    //CollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(214, 214);
    layout.minimumInteritemSpacing = 16;
    layout.minimumLineSpacing = 34;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, self.mainVIew.frame.size.width, self.mainVIew.frame.size.height - 200) collectionViewLayout:layout];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 25, 25, 25);
    [self.collectionView registerNib:[UINib nibWithNibName:@"MICollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.mainVIew addSubview:self.collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
