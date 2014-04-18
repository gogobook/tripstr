//
//  PostViewController.m
//  tripstr
//
//  Created by ctwsine on 3/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "PostViewController.h"
#import <UIView+AutoLayout.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "UserModel.h"
#import "ProfileViewController.h"
#import <SIAlertView.h>

@interface PostViewController () <UserModelDelegate>

@property (nonatomic,strong) UIScrollView* scrollView;

@property (nonatomic,strong) UILabel* headline;
@property (nonatomic,strong) UIImageView* locationIndicatorView;
@property (nonatomic,strong) UILabel* location;

//@property (nonatomic,strong) UIImageView* photo;
@property (nonatomic,strong) PFImageView* photo;
@property (nonatomic,strong) UILabel* content;

@property (nonatomic,strong) UIImageView* authorPic;
@property (nonatomic,strong) UILabel* authorNameLabel;
@property (nonatomic,strong) UILabel* authorlocationLabel;


@property (nonatomic,strong) UIButton* toProfileButton;

@property (nonatomic,strong) UserModel* author;

@property (nonatomic,strong) MBProgressHUD* hud;

@end

@implementation PostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
//
    UIButton * heart = [UIButton buttonWithType:UIButtonTypeCustom];
    heart.bounds = CGRectMake(0, 0, 28, 28);
    [heart setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
    
    [heart addTarget:self action:@selector(addToFavorite) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:heart];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    //
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_left"]]];
    
    
    
//    UIImage* backButtonImage = [UIImage imageNamed:@"arrow_left"];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 28, 28);
    [button setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
//    
//    
//    
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:backButtonImage]];
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage
//                                                                             style:UIBarButtonItemStylePlain
//                                                                            target:self
//                                                                            action:@selector(backButtonAction:)];
    NSLog(@"%@",self.navigationItem.leftBarButtonItem);
    //
    [self setLayout];
    
    [self.author fetchUserWithUserId:self.postModel.authorId];
    
}

-(void) setLayout
{
    [self.view addSubview:self.scrollView];
    [self.scrollView  addSubview:self.headline];
    [self.scrollView addSubview:self.location];
//    [self.scrollView addSubview:self.locationIndicatorView];
    [self.scrollView addSubview:self.photo];
    [self.scrollView addSubview:self.content];
    
}

-(void) updateViewConstraints
{
    [super updateViewConstraints];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    
    [self.headline autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:16];
    [self.headline autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    [self.location autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headline];
    [self.location autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
//    [self.locationIndicatorView autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.location];
//    [self.locationIndicatorView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.location];
    
    [self.photo autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.location withOffset:20];
//    [self.photo autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
//    [self.photo autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [self.photo autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.photo autoSetDimension:ALDimensionHeight toSize:280];
    [self.photo autoSetDimension:ALDimensionWidth toSize:280];
    
    [self.content autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.content autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.photo withOffset:20];
    [self.content autoSetDimension:ALDimensionWidth toSize:280];
    
    
}

#pragma mark- actions
-(void) toProfileButtonTapped
{
    UserModel* author = self.author;
    [self performSegueWithIdentifier:@"postToProfileSegue" sender:author];
}

-(void) addToFavorite
{
    self.hud.mode = MBProgressHUDModeText;
    self.hud.labelText = @"已加入最愛";
    [self.hud show:YES];
    [self.hud hide:YES afterDelay:1];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ProfileViewController* pvc = (ProfileViewController*) [segue destinationViewController];
    pvc.author = (UserModel*) sender;
    
}

- (void) backButtonAction:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark- getters

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initForAutoLayout];
    }
    return _scrollView;
}

-(UILabel *)headline
{
    if (!_headline) {
        _headline = [[UILabel alloc] initForAutoLayout];
        _headline.numberOfLines = 2;
        _headline.lineBreakMode = NSLineBreakByWordWrapping;
        _headline.text = self.postModel.headline;
//        _headline.font = [UIFont boldSystemFontOfSize:36];
        _headline.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
    }
    return _headline;
}

-(UIImageView *)locationIndicatorView
{
    if (!_locationIndicatorView) {
        _locationIndicatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location"]];
        _locationIndicatorView.backgroundColor = [UIColor redColor];
    }
    return _locationIndicatorView;
}

-(UILabel *)location
{
    if (!_location) {
        _location = [[UILabel alloc] initForAutoLayout];
        _location.text = self.postModel.location;
    }
    return _location;
}

//-(UIImageView *)photo
//{
//    if (!_photo) {
//        _photo = [[UIImageView alloc] initForAutoLayout];
//        _photo.backgroundColor = [UIColor grayColor];
//        [_photo setImageWithURL:[NSURL URLWithString:self.postModel.photoURLString]];
//    }
//    return _photo;
//}

-(UIImageView *)photo
{
    if (!_photo) {
        _photo = [[PFImageView alloc] initForAutoLayout];
        _photo.backgroundColor = [UIColor lightGrayColor];
        _photo.layer.borderColor = [UIColor blackColor].CGColor;
        _photo.layer.borderWidth = 1;
        _photo.file = (PFFile*) self.postModel.photo;
        [_photo loadInBackground];
    }
    return _photo;
}

-(UILabel *)content
{
    if (!_content) {
        _content = [[UILabel alloc] initForAutoLayout];
        _content.numberOfLines = 0;
        _content.lineBreakMode = NSLineBreakByWordWrapping;
        _content.text = self.postModel.content;
    }
    return _content;
}

-(UIButton *)toProfileButton
{
    if (!_toProfileButton) {
        _toProfileButton = [[UIButton alloc] initForAutoLayout];
        [_toProfileButton setTitle:@"Go to Author Page" forState:UIControlStateNormal];
        [_toProfileButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _toProfileButton.layer.cornerRadius = 5;
        _toProfileButton.clipsToBounds = YES;
        [_toProfileButton addTarget:self action:@selector(toProfileButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        _toProfileButton.layer.borderColor = [UIColor blackColor].CGColor;
        _toProfileButton.layer.borderWidth = 1;
    }
    return  _toProfileButton;
}

-(UserModel *)author
{
    if (!_author) {
        _author = [[UserModel alloc] init];
        _author.delegate = self;
    }
    return _author;
}

-(UIImageView *)authorPic
{
    if (!_authorPic) {
        _authorPic = [[UIImageView alloc] initForAutoLayout];
        [_authorPic setImageWithURL:[NSURL URLWithString:self.author.avatarUrlString]];
        _authorPic.layer.cornerRadius = 33;
        _authorPic.clipsToBounds = YES;
    }
    return _authorPic;
}

-(UILabel *)authorNameLabel
{
    if (!_authorNameLabel) {
        _authorNameLabel = [[UILabel alloc] initForAutoLayout];
        _authorNameLabel.text = self.author.name;
//        _authorNameLabel.font = [UIFont systemFontOfSize:36];
    }
    return _authorNameLabel;
}

-(UILabel *)authorlocationLabel
{
    if (!_authorlocationLabel) {
        _authorlocationLabel = [[UILabel alloc] initForAutoLayout];
        _authorlocationLabel.text = self.author.location;
//        _authorlocationLabel.font = [UIFont systemFontOfSize:36];
    }
    return _authorlocationLabel;
}

-(MBProgressHUD *)hud
{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    return _hud;
}

#pragma mark- userModelDelegate

-(void)didFetchUser:(UserModel *)user
{
    NSLog(@"UserModel: %@",user);
    self.author = user;
    NSLog(@"Author Detail: %@",self.author.introduction);
    
    [self.scrollView addSubview:self.toProfileButton];
    [self.scrollView addSubview:self.authorPic];
    [self.scrollView addSubview:self.authorNameLabel];
    [self.scrollView addSubview:self.authorlocationLabel];
    
    [self.authorPic autoSetDimension:ALDimensionHeight toSize:66];
    [self.authorPic autoSetDimension:ALDimensionWidth toSize:66];
    [self.authorPic autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [self.authorPic autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.content withOffset:20];
    
    [self.authorNameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.content withOffset:17];
    [self.authorNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.authorPic withOffset:7];
    [self.authorNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    
    [self.authorlocationLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.authorNameLabel withOffset:5];
    [self.authorlocationLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.authorNameLabel];
    
    [self.toProfileButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.toProfileButton autoSetDimension:ALDimensionWidth toSize:280];
    [self.toProfileButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.authorPic withOffset:20];
    [self.toProfileButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:16];
}

-(void)failToFetchUser:(NSError *)error
{
    NSLog(@"PostViewError: %@",error);
}

@end
