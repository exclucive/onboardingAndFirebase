//
//  UserPictureViewController.h
//  WheelsTakeHome
//
//  Created by Igor Novik on 3/11/19.
//  Copyright © 2019 Igor Novik. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

@interface UserPictureViewController : UIViewController

+ (UserPictureViewController *)controllerWith:(User *)user;

@end
