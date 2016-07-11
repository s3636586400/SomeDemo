//
//  BaseMapController.m
//  MapDemo
//
//  Created by 解炳灿 on 16/4/14.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "BaseMapController.h"

@implementation BaseMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
}

- (MAMapView *)mapView {
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mapView.delegate = self;
        //设置定位图层显示模式
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        //设置当前缩放级别
        [_mapView setZoomLevel:16.1 animated:YES];
    }
    
    return _mapView;
}

#pragma mark MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if (updatingLocation) {
        NSLog(@"lat:%f,lon:%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

#pragma mark 自定义精度圈
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MAAnnotationView *view = views[0];
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.lineWidth = 1;
        pre.lineDashPattern = @[@6,@3];
        
        [self.mapView updateUserLocationRepresentation:pre];
        view.calloutOffset = CGPointMake(0, 0);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
