//
//  MIPinAnnotationController.m
//  MapDemo
//
//  Created by s3636586400 on 16/7/5.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "MIPinAnnotationController.h"

@interface MIPinAnnotationController ()

@end

@implementation MIPinAnnotationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"大头针标注";
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

        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        annotationView.draggable = YES;
        annotationView.pinColor = MAPinAnnotationColorRed;
        
        return annotationView;
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
