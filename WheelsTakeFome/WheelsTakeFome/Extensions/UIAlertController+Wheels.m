//
//  UIAlertViewController+Wheels.m
//  WheelsTakeHome
//
//  Created by Igor Novik on 3/11/19.
//  Copyright © 2019 Igor Novik. All rights reserved.
//

#import "UIAlertController+Wheels.h"

@implementation UIAlertController (Wheels)

+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)messagel on:(UIViewController *)controller {
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:title message:messagel preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertViewController addAction:okAction];
    
    [controller presentViewController:alertViewController animated:YES completion:nil];
}

@end
