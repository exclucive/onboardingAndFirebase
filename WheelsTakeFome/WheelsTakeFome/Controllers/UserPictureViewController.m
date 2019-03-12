//
//  UserPictureViewController.m
//  WheelsTakeHome
//
//  Created by Igor Novik on 3/11/19.
//  Copyright © 2019 Igor Novik. All rights reserved.
//

#import "UserPictureViewController.h"
#import "NetworkUserManager.h"
#import "UIAlertController+Wheels.h"
#import "UserProfileViewController.h"
#import "SHSPhoneLibrary.h"
#import "User.h"

@interface UserPictureViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) User *user;
@property (nonatomic, weak) IBOutlet UIImageView *userPictureImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation UserPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureTapGestureAction:)];
    [self.userPictureImageView addGestureRecognizer:gestureRecognizer];
}

#pragma mark - 

+ (UserPictureViewController *)controllerWith:(User *)user {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; 

    NSString *controllerIdentifier = NSStringFromClass([UserPictureViewController class]);
    UserPictureViewController *pictureViewController = [storyboard instantiateViewControllerWithIdentifier:controllerIdentifier];
    pictureViewController.user = user;
    
    return pictureViewController;
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

- (void)goToProfilePageWith:(User *)user {
    UserProfileViewController *profileController = [UserProfileViewController controllerWith:user]; 
    [self.navigationController pushViewController:profileController animated:YES];
}

- (IBAction)nextButtonAction:(id)sender {
    self.user.imageData = UIImagePNGRepresentation(self.userPictureImageView.image);
    self.view.userInteractionEnabled = NO;
    
    __weak typeof(self) weakSelf = self;
    [self.activityIndicator startAnimating];
    
    NetworkUserManager *networkManager = [NetworkUserManager new]; 
    [networkManager addUser:self.user completionBlock:^(NSError *error) {
        weakSelf.view.userInteractionEnabled = YES;
        [weakSelf.activityIndicator stopAnimating];
        
        if (error) {
            [UIAlertController presentAlertWithTitle:error.localizedDescription message:nil on:weakSelf];
        }
        else {
            [weakSelf goToProfilePageWith:weakSelf.user];
        }
    }];
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
