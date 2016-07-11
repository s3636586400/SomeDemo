//
//  BaseMapController.h
//  MapDemo
//
//  Created by 解炳灿 on 16/4/14.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "BaseViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface BaseMapController : BaseViewController<MAMapViewDelegate>

@property (strong, nonatomic) MAMapView *mapView;

@end
