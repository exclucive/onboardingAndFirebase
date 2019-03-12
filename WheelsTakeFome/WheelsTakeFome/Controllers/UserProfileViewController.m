//
//  ViewController.m
//  WheelsTakeFome
//
//  Created by Igor Novik on 3/11/19.
//  Copyright © 2019 Igor Novik. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserInfoFormValidator.h"
#import "UIAlertController+Wheels.h"
#import "NetworkUserManager.h"
#import "SHSPhoneLibrary.h"
#import "User.h"

@interface UserProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet SHSPhoneTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIImageView *userPictureImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) User *user;
@property (nonatomic, assign) BOOL isInEditMode;


@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.isInEditMode = NO;
    [self fillTheFormWithUserData:self.user];
    [self enableAllFields:NO];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    [self configPhoneField];
    [self configGestureRecognizers];
}

+ (UserProfileViewController *)controllerWith:(User *)user {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; 
    
    NSString *controllerIdentifier = NSStringFromClass([UserProfileViewController class]);
    UserProfileViewController *profileViewController = [storyboard instantiateViewControllerWithIdentifier:controllerIdentifier];
    profileViewController.user = user;
    
    return profileViewController;
}

#pragma mark - Private

- (void)configPhoneField {
    [self.phoneTextField.formatter setDefaultOutputPattern:@"(###) ###-####"];
    self.phoneTextField.formatter.prefix = @"+1 ";
}

- (void)configGestureRecognizers {
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureTapGestureAction:)];
    [self.userPictureImageView addGestureRecognizer:gestureRecognizer];
    
    UITapGestureRecognizer *mainViewGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.view addGestureRecognizer:mainViewGestureRecognizer];
}

- (void)fillTheFormWithUserData:(User *)user {
    self.firstNameTextField.text = user.firstName;
    self.lastNameTextField.text = user.lastName;
    self.emailTextField.text = user.email;
    self.phoneTextField.text = user.phone;
    
    self.userPictureImageView.image = [UIImage imageWithData:self.user.imageData];
}

- (void)enableAllFields:(BOOL)enabled {
    self.firstNameTextField.enabled = enabled;
    self.lastNameTextField.enabled = enabled;
    self.emailTextField.enabled = enabled;
    self.phoneTextField.enabled = enabled;
    self.userPictureImageView.userInteractionEnabled = enabled;
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

- (void)updateUser:(User *)user {
    __weak typeof(self) weakSelf = self;
    NetworkUserManager *networkManager = [NetworkUserManager new]; 
    [networkManager updateUser:self.user completionBlock:^(NSError *error) {
        weakSelf.view.userInteractionEnabled = YES;
        [weakSelf.activityIndicator stopAnimating];
        
        if (error) {
            [UIAlertController presentAlertWithTitle:error.localizedDescription message:nil on:weakSelf];
        }
    }];
}

#pragma mark - Actions

- (void)pictureTapGestureAction:(UIGestureRecognizer *)gestureRecognizer {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void)tapGestureAction:(UIGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

- (IBAction)editButtonAction:(UIBarButtonItem *)sender {
    if (self.isInEditMode && [self isFormValid]) {        
        sender.title = @"Edit";
        self.isInEditMode = NO;
        [self enableAllFields:NO];
        
        self.user.firstName = self.firstNameTextField.text;
        self.user.lastName = self.lastNameTextField.text;
        self.user.email = self.emailTextField.text;
        self.user.phone = self.phoneTextField.text;
        self.user.imageData = UIImagePNGRepresentation(self.userPictureImageView.image);
        
        [self updateUser:self.user];
    }
    else {
        sender.title = @"Done";
        self.isInEditMode = YES;
        [self enableAllFields:YES];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.userPictureImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
