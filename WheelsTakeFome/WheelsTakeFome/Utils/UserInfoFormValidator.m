//
//  UserInfoFormValidator.m
//  WheelsTakeHome
//
//  Created by Igor Novik on 3/11/19.
//  Copyright © 2019 Igor Novik. All rights reserved.
//

#import "UserInfoFormValidator.h"
#import "NSString+Wheels.h"

const NSString * kUserInfoFormValidatorDomain = @"com.wheels.userInfoValidation";
const NSInteger kUserInfoFormValidatorErrorCode = -1;

@implementation UserInfoFormValidator

- (BOOL)isFormValidWithFirstName:(NSString *)firstName 
                        lastName:(NSString *)lastName 
                           email:(NSString *)email 
                           phone:(NSString *)phone 
                           error:(NSError **)error {
    
    if ([firstName isEqualToString:@""]) {
        *error = [self validationErrorWithDescription:@"First Name is required"];
        return NO;
    } 
    else if ([lastName isEqualToString:@""]) {
        *error = [self validationErrorWithDescription:@"Last Name is required"];
        return NO;
    }
    else if ([email isEqualToString:@""]) {
        *error = [self validationErrorWithDescription:@"Email is required"];
        return NO;
    }
    else if ([email isValidEmail] == NO) {
        *error = [self validationErrorWithDescription:@"Email is no valid"];
        return NO;
    }
    else if ([phone isEqualToString:@""]) {
        *error = [self validationErrorWithDescription:@"Phone is required"];
        return NO;
    }
    
    return YES;

}

- (NSError *)validationErrorWithDescription:(NSString *)description {
    NSError *error = [[NSError alloc] initWithDomain:kUserInfoFormValidatorDomain 
                                                code:kUserInfoFormValidatorErrorCode 
                                            userInfo:@{NSLocalizedDescriptionKey: description}];
    return error;
}

@end
