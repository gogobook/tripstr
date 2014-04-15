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

@interface ProfileViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIScrollView* scrollView;

@property (nonatomic,strong) UIImageView* authorPic;
@property (nonatomic,strong) UILabel* authorNameLabel;
@property (nonatomic,strong) UILabel* authorLocationLabel;
@property (nonatomic,strong) UILabel* authorIntroLabel;

@property (nonatomic,strong) UITableView* tableView;


@end

@implementation ProfileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"ProfileVC: %@",self.author);
    [self addLayout];
}

-(void) addLayout
{
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.authorPic];
    [self.scrollView addSubview:self.authorNameLabel];
    [self.scrollView addSubview:self.authorLocationLabel];
    [self.scrollView addSubview:self.authorIntroLabel];
    
    [self.scrollView addSubview:self.tableView];
}

-(void) updateViewConstraints
{
    [super updateViewConstraints];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    
    [self.authorPic autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:4];
    [self.authorPic autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:6];
    [self.authorPic autoSetDimension:ALDimensionHeight toSize:70];
    [self.authorPic autoSetDimension:ALDimensionWidth toSize:70];
    
    [self.authorNameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:16];
    [self.authorNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:7];
    [self.authorNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.authorPic withOffset:9];

    [self.authorLocationLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.authorNameLabel];
    [self.authorLocationLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.authorNameLabel];
    [self.authorLocationLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.authorNameLabel withOffset:5];
    
    [self.authorIntroLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.authorPic withOffset:8];
    [self.authorIntroLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.authorPic];
    //用右邊拉開的方式無法成功
//    [self.authorIntroLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.scrollView withOffset:7];
    [self.authorIntroLabel autoSetDimension:ALDimensionWidth toSize:308];
    
    [self.tableView autoSetDimension:ALDimensionWidth toSize:320];
    [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.authorIntroLabel withOffset:3];
    //[self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
}


#pragma mark- actions

#pragma mark- getters

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initForAutoLayout];
        _scrollView.backgroundColor = [UIColor clearColor];
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
        NSLog(@"inside tableView if");
        _tableView = [[UITableView alloc] initForAutoLayout];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor grayColor];
    }
    return _tableView;
}

#pragma mark- tableView datasource and delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOf Rows called");
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileView"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfileView"];
    }
    cell.textLabel.text = @"title";
    return cell;
}

@end
