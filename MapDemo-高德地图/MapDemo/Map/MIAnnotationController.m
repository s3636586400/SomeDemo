//
//  MIAnnotationController.m
//  MapDemo
//
//  Created by s3636586400 on 16/7/5.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "MIAnnotationController.h"

@interface MIAnnotationController ()

@end

@implementation MIAnnotationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义标注";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989831, 116.481018);
    pointAnnotation.title = @"MaskIsland";
    pointAnnotation.subtitle = @"Can you hear me";
    [self.mapView addAnnotation:pointAnnotation];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";

        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.image = [UIImage imageNamed:@"emoji"];
        annotationView.layer.cornerRadius = 20;
        annotationView.clipsToBounds = YES;
        annotationView.centerOffset = CGPointMake(0, -20);
        
        return annotationView;
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
