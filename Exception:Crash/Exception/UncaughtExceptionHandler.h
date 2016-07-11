//
//  UncaughtExceptionHandler.h
//  Exception
//
//  Created by 解炳灿 on 16/4/25.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UncaughtExceptionHandler : NSObject{
    BOOL dismissed;
}

@end
void HandleException(NSException *exception);
void SignalHandler(int signal);


void InstallUncaughtExceptionHandler(void);
