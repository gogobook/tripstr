//
//  ProfileViewController.m
//  tripstr
//
//  Created by ctwsine on 3/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "ProfileViewController.h"
#import "PostListTableView.h"
#import "PostListCell.h"

#import "PostModel.h"
#import "PostViewController.h"

@interface ProfileViewController () <UITableViewDataSource,UITableViewDelegate,PostModelDelegate>

@property (nonatomic,strong) UIScrollView* scrollView;

@property (nonatomic,strong) UIImageView* authorPic;
@property (nonatomic,strong) UILabel* authorNameLabel;
@property (nonatomic,strong) UILabel* authorLocationLabel;
@property (nonatomic,strong) UILabel* authorIntroLabel;

@property (nonatomic,strong) UITableView* tableView;

@property (nonatomic,strong) PostModel* post;
@property (nonatomic,strong) NSMutableArray* postArray;

@end

@implementation ProfileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"ProfileVC: %@",self.author.authorId);
    self.post = [[PostModel alloc] init];
    self.post.delegate = self;
    [self.post fetchPostListUser:self.author.authorId];
    [self addLayout];
}

-(void) addLayout
{
//    [self.view addSubview:self.scrollView];
//    
//    [self.scrollView addSubview:self.authorPic];
//    [self.scrollView addSubview:self.authorNameLabel];
//    [self.scrollView addSubview:self.authorLocationLabel];
//    [self.scrollView addSubview:self.authorIntroLabel];
//    
//    [self.scrollView addSubview:self.tableView];
    
    [self.view addSubview:self.authorPic];
    [self.view addSubview:self.authorNameLabel];
    [self.view addSubview:self.authorLocationLabel];
    [self.view addSubview:self.authorIntroLabel];
    
    [self.view addSubview:self.tableView];
}

-(void) updateViewConstraints
{
    [super updateViewConstraints];
//    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
//    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
//    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
//    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
//    
    [self.authorPic autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:6];
    [self.authorPic autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:6];
    [self.authorPic autoSetDimension:ALDimensionHeight toSize:70];
    [self.authorPic autoSetDimension:ALDimensionWidth toSize:70];
    
    [self.authorNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:16];
    [self.authorNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:7];
    [self.authorNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.authorPic withOffset:9];

    [self.authorLocationLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.authorNameLabel];
    [self.authorLocationLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.authorNameLabel];
    [self.authorLocationLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.authorNameLabel withOffset:5];
    
    [self.authorIntroLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.authorPic withOffset:6];
    [self.authorIntroLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.authorPic];
    //用右邊拉開的方式無法成功
//    [self.authorIntroLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.scrollView withOffset:7];
    [self.authorIntroLabel autoSetDimension:ALDimensionWidth toSize:308];
    
    [self.tableView autoSetDimension:ALDimensionWidth toSize:320];
//    [self.tableView autoSetDimension:ALDimensionHeight toSize:275];
    [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.authorIntroLabel withOffset:3];
    [self.tableView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
}


#pragma mark- actions

#pragma mark- getters

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initForAutoLayout];
        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}

-(UIImageView *)authorPic
{
    if (!_authorPic) {
        _authorPic = [[UIImageView alloc] initForAutoLayout];
        [_authorPic setImageWithURL:[NSURL URLWithString:self.author.avatarUrlString]];
        _authorPic.layer.cornerRadius = 35;
        _authorPic.clipsToBounds = YES;
        _authorPic.backgroundColor = [UIColor redColor];
    }
    return _authorPic;
}

-(UILabel *)authorNameLabel
{
    if (!_authorNameLabel) {
        _authorNameLabel = [[UILabel alloc] initForAutoLayout];
        _authorNameLabel.text = self.author.name;
        _authorNameLabel.backgroundColor = [UIColor yellowColor];
//        _authorNameLabel.preferredMaxLayoutWidth = 200;
    }
    return _authorNameLabel;
}

-(UILabel *)authorLocationLabel
{
    if (!_authorLocationLabel) {
        _authorLocationLabel = [[UILabel alloc] initForAutoLayout];
        _authorLocationLabel.text = self.author.location;
        _authorLocationLabel.backgroundColor = [UIColor greenColor];
    }
    return _authorLocationLabel;
}

-(UILabel *)authorIntroLabel
{
    if (!_authorIntroLabel) {
        _authorIntroLabel = [[UILabel alloc] initForAutoLayout];
        _authorIntroLabel.text = self.author.introduction;
        _authorIntroLabel.font = [UIFont systemFontOfSize:12];
        _authorIntroLabel.numberOfLines = 0;
        _authorIntroLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _authorIntroLabel.backgroundColor = [UIColor orangeColor];
    }
    return _authorIntroLabel;
}

-(UITableView *)tableView
{
    NSLog(@"tableView called");
    if (!_tableView) {

        _tableView = [[UITableView alloc] initForAutoLayout];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = YES;
        _tableView.backgroundColor = [UIColor grayColor];
                NSLog(@"inside tableView if %@",_tableView);
        _tableView.bounces = NO;
    }
    return _tableView;
}

#pragma mark- tableView datasource and delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.postArray.count;
}

-(PostListCell *)tableView:(PostListTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileView"];
    if (!cell) {
        cell = [[PostListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfileView"];
    }
    PostModel* post = (PostModel*) self.postArray[indexPath.row];
    cell.titleLabel.text = post.headline;
    cell.locationLabel.text = post.location;
    cell.contentLabel.text = post.content;
    cell.postImageView.file = post.photo;
    [cell.postImageView loadInBackground];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostModel* post = self.postArray[indexPath.row];
    [self performSegueWithIdentifier:@"profileToPostSegue" sender:post];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PostViewController* pvc = (PostViewController* )[segue destinationViewController];
    PostModel* post = (PostModel*) sender;
    pvc.postModel = post;
}
#pragma mark- postModelDelegate
-(void)didFetchDataAll:(NSMutableArray *)postList
{
    self.postArray = postList;
    [self.tableView reloadData];
}

-(void)failToFetchDataAll:(NSError *)error
{
    NSLog(@"eror: %@",error);
}

@end
