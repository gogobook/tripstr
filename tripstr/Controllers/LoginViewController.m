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

@property (nonatomic,strong) UIImageView* backgroundImageView;
@property (nonatomic,strong) UIImageView* tripstrLogoImageView;
@property (nonatomic,strong) UILabel* sloganLabel;
@property (nonatomic,strong) UILabel* instructionLabel;
@property (nonatomic,strong) UIButton* loginButton;
@property (nonatomic,strong) UILabel* disclaimerLabel;

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
    
    [self.view addSubview:self.backgroundImageView];
    [self.view sendSubviewToBack:self.backgroundImageView];
//    
//    [self.view addSubview:self.tripstrLogoImageView];
//    [self.view addSubview:self.sloganLabel];
//    [self.view addSubview:self.instructionLabel];
    [self.view addSubview:self.loginButton];
//    [self.view addSubview:self.disclaimerLabel];

}

- (void)setupConstraints
{
    [self.loginButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:67];
    [self.loginButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    [self.loginButton autoSetDimension:ALDimensionWidth toSize:366];
    [self.loginButton autoSetDimension:ALDimensionHeight toSize:50];
    
//    [self.instructionLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    [self.instructionLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.loginButton withOffset:-20];
//    
//    [self.sloganLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    [self.sloganLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.instructionLabel withOffset:-20];
//    
//    [self.tripstrLogoImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    [self.tripstrLogoImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.sloganLabel withOffset:-20];
//    [self.tripstrLogoImageView autoSetDimension:ALDimensionWidth toSize:150];
//    [self.tripstrLogoImageView autoSetDimension:ALDimensionHeight toSize:60];
//    
//    [self.disclaimerLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    [self.disclaimerLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.loginButton withOffset:10];
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
            NSLog(@"new user");
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
            NSLog(@"user already exist");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];

}

-(void) signupAction: (id) result
{
    NSLog(@"signUpAction: result %@",result);
    PFUser* user = [PFUser currentUser];
    user[@"fbID"] = result[@"id"];
    user.email = result[@"email"];
    user[@"location"] = result[@"location"][@"name"];
    user[@"name"] = result[@"name"];
    user[@"avatarURL"] = result[@"picture"][@"data"][@"url"];
    user[@"description"] = result[@"bio"];
    NSLog(@"user: %@", user);
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"inBlock");
        if (succeeded) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"error: %@",error);
        }
    }];
    NSLog(@"endOfSignUp");
}

#pragma mark- getter
-(UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initForAutoLayout];
//        _loginButton.translatesAutoresizingMaskIntoConstraints = NO;
//        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
//        [_loginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_with_facebook"] forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"login-button-small-pressed"] forState:UIControlStateSelected];
        [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

-(UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_background1136"]];
    }
    return _backgroundImageView;
}

-(UIImageView *)tripstrLogoImageView
{
    if (!_tripstrLogoImageView) {
        _tripstrLogoImageView = [[UIImageView alloc] initForAutoLayout];
//        _tripstrLogoImageView.image = [UIImage imageNamed:@"emma"];
        _tripstrLogoImageView.backgroundColor = [UIColor blackColor];
    }
    return _tripstrLogoImageView;
}

-(UILabel *)sloganLabel
{
    if (!_sloganLabel) {
        _sloganLabel = [[UILabel alloc] initForAutoLayout];
        _sloganLabel.text = @"一個人旅行再也不孤單";
        _sloganLabel.textColor = [UIColor whiteColor];
        _sloganLabel.font = [UIFont systemFontOfSize:20];
    }
    return _sloganLabel;
}

-(UILabel *)instructionLabel
{
    if (!_instructionLabel) {
        _instructionLabel = [[UILabel alloc] initForAutoLayout];
        _instructionLabel.text = @"In order to user Tripstr, please login.";
        _instructionLabel.textColor = [UIColor whiteColor];
        _instructionLabel.font = [UIFont fontWithName:@"Helvetica-Neue-Light" size:20];
    }
    return _instructionLabel;
}

-(UILabel *)disclaimerLabel
{
    if (!_disclaimerLabel) {
        _disclaimerLabel = [[UILabel alloc] initForAutoLayout];
        _disclaimerLabel.text = @"We will never post on your Facebook";
        _disclaimerLabel.textColor = [UIColor whiteColor];
        _disclaimerLabel.font = [UIFont fontWithName:@"Helvetica-Neue-Light" size:12];
    }
    return _disclaimerLabel;
}


@end
