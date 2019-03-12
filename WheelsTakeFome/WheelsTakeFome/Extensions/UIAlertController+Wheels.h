//
//  UIAlertViewController+Wheels.h
//  WheelsTakeHome
//
//  Created by Igor Novik on 3/11/19.
//  Copyright © 2019 Igor Novik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Wheels)

+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)messagel on:(UIViewController *)controller;

@end
