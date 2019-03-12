//
//  User.h
//  WheelsTakeFome
//
//  Created by Igor Novik on 3/11/19.
//  Copyright © 2019 Igor Novik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong, readonly) NSString *userID;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSData *imageData;

- (instancetype)initWithFirstName:(NSString *)firstName 
                         lastName:(NSString *)lastName 
                            email:(NSString *)email 
                            phone:(NSString *)phone;

@end
