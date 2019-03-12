//
//  NetworkUserManager.m
//  WheelsTakeFome
//
//  Created by Igor Novik on 3/11/19.
//  Copyright © 2019 Igor Novik. All rights reserved.
//

#import "NetworkUserManager.h"
#import "User.h"
@import Firebase;

NSString * const kNetworkUserManagerUsersNode = @"users";

@interface NetworkUserManager ()

@property (nonatomic, strong) FIRDatabaseReference *ref;

@end

@implementation NetworkUserManager

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _ref = [[FIRDatabase database] reference];
    }
    
    return self;
}

#pragma mark - 
- (NSDictionary *)userDictFromUser:(User *)user {
    NSDictionary *userDict = @{@"candidate_id": user.userID,
                               @"first_name": user.firstName,
                               @"last_name": user.lastName,
                               @"email": user.email,
                               @"phone": user.phone,
                               @"image_data": [user.imageData base64EncodedStringWithOptions:0]};

    return userDict;
}

- (void)addUser:(User *)user completionBlock:(void(^)(NSError *error))completion {
    NSDictionary *userDict = [self userDictFromUser:user];
    [[[self.ref child:kNetworkUserManagerUsersNode] child:user.userID] setValue:userDict withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        
        NSLog(@"%@", [[ref child:kNetworkUserManagerUsersNode] childByAutoId]);
        
        if (completion) {
            completion(error);
        }
    }];
}

- (void)updateUser:(User *)user completionBlock:(void(^)(NSError *error))completion {
    NSDictionary *userDict = [self userDictFromUser:user];
    [[[self.ref child:kNetworkUserManagerUsersNode] child:user.userID] updateChildValues:userDict withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        
        NSLog(@"%@", [[ref child:kNetworkUserManagerUsersNode] childByAutoId]);
        
        if (completion) {
            completion(error);
        }
    }];
}

@end
