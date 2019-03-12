//
//  UserInfoFormValidator.h
//  WheelsTakeHome
//
//  Created by Igor Novik on 3/11/19.
//  Copyright © 2019 Igor Novik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoFormValidator : NSObject

- (BOOL)isFormValidWithFirstName:(NSString *)firstName 
                        lastName:(NSString *)lastName 
                           email:(NSString *)email 
                           phone:(NSString *)phone 
                           error:(NSError **)error;

@end
