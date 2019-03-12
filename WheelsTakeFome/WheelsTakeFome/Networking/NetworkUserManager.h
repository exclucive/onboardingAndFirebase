//
//  NetworkUserManager.h
//  WheelsTakeFome
//
//  Created by Igor Novik on 3/11/19.
//  Copyright © 2019 Igor Novik. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;

@interface NetworkUserManager : NSObject

- (instancetype)init;

- (void)addUser:(User *)user completionBlock:(void(^)(NSError *error))completion;
- (void)updateUser:(User *)user completionBlock:(void(^)(NSError *error))completion;

@end
