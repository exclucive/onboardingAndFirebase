//
//  UserInfoViewController.m
//  WheelsTakeHome
//
//  Created by Igor Novik on 3/11/19.
//  Copyright © 2019 Igor Novik. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UIAlertController+Wheels.h"
#import "UserInfoFormValidator.h"
#import "UserPictureViewController.h"
#import "SHSPhoneLibrary.h"
#import "User.h"

@interface UserInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet SHSPhoneTextField *phoneTextField;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configPhoneField];
    [self configGestureRecognizers];
}

#pragma mark - Private helpers

- (void)configPhoneField {
    [self.phoneTextField.formatter setDefaultOutputPattern:@"(###) ###-####"];
    self.phoneTextField.formatter.prefix = @"+1 ";
}

- (void)configGestureRecognizers {
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (BOOL)isFormValid {
    UserInfoFormValidator *validator = [UserInfoFormValidator new]; 
    
    NSError *error = nil;
    BOOL isValid = [validator isFormValidWithFirstName:self.firstNameTextField.text 
                               lastName:self.lastNameTextField.text 
                                  email:self.emailTextField.text 
                                  phone:self.phoneTextField.text 
                                  error:&error];
    
    if (error != nil) {
        [UIAlertController presentAlertWithTitle:error.localizedDescription 
                                         message:nil on:self];
    }
    
    return isValid;
}

#pragma mark - Actions

- (void)tapGestureAction:(UIGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

- (IBAction)nextButtonAction:(id)sender {
    if ([self isFormValid]) {
        User *user = [[User alloc] initWithFirstName:self.firstNameTextField.text 
                                            lastName:self.lastNameTextField.text 
                                               email:self.emailTextField.text 
                                               phone:self.phoneTextField.text];
        
        UserPictureViewController *pictureViewController = [UserPictureViewController controllerWith:user];
        [self.navigationController pushViewController:pictureViewController animated:YES];
    }
}

@end
