//
//  LoginViewController.m
//  tripstr
//
//  Created by ctwsine on 3/18/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (nonatomic,strong) UIButton* loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setLayout];
    [self setupConstraints];
}

- (void)setLayout
{
    [self.view addSubview:self.loginButton];
}

- (void)setupConstraints
{
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

#pragma mark- actions
- (void)loginAction
{
    NSLog(@"login Action triggered");
    //
    NSArray *permissionsArray = @[ @"user_about_me", @"email", @"user_location"];
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSDictionary* param = @{@"fields": @"id,name,picture,location,email,bio"};
            [FBRequestConnection startWithGraphPath:@"me"
                                         parameters:param
                                         HTTPMethod:@"GET"
                                  completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                      NSLog(@"%@",result);
                                      if (!error) {
                                          [self signupAction:result];
                                      } else {
                                        NSLog(@"%@",error);
                                      }
                                  }];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];

}

-(void) signupAction: (id) result
{
    PFUser* user = [PFUser currentUser];
    user[@"fbID"] = result[@"id"];
    user.email = result[@"email"];
    user[@"location"] = result[@"location"][@"name"];
    user[@"name"] = result[@"name"];
    user[@"avatarURL"] = result[@"picture"][@"data"][@"url"];
    user[@"description"] = result[@"bio"];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"error: %@",error);
        }
    }];
}

#pragma mark- getter
-(UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        _loginButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [_loginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"login-button-small"] forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"login-button-small-pressed"] forState:UIControlStateSelected];
        [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

@end
