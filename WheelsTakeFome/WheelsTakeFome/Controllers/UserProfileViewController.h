//
//  ViewController.h
//  WheelsTakeFome
//
//  Created by Igor Novik on 3/11/19.
//  Copyright © 2019 Igor Novik. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

@interface UserProfileViewController : UIViewController

+ (UserProfileViewController *)controllerWith:(User *)user;

@end

