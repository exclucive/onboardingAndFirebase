//
//  User.m
//  WheelsTakeFome
//
//  Created by Igor Novik on 3/11/19.
//  Copyright © 2019 Igor Novik. All rights reserved.
//

#import "User.h"

@interface User()

@end

@implementation User

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email phone:(NSString *)phone {
    self = [super init];
    
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
        _email = email;
        _phone = phone;
    }
    
    return self;
}

- (NSString *)userID {
    if (self.firstName && self.lastName) {
        return [NSString stringWithFormat:@"%@-%@", self.firstName, self.lastName];
    }
    
    return nil;
}

@end
