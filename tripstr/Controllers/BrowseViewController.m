//
//  BrowseViewController.m
//  tripstr
//
//  Created by ctwsine on 3/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "BrowseViewController.h"
#import "PostListTableView.h"
#import "PostListCell.h"
#import "PostModel.h"

#import "PostViewController.h"
#import <MBProgressHUD.h>
#import <Parse/Parse.h>
#import "LoginViewController.h"

@interface BrowseViewController () <UITableViewDataSource, UITableViewDelegate, PostModelDelegate>

@property (nonatomic,strong) PostListTableView* tableView;
@property (nonatomic,strong) NSArray* postList;
@property (nonatomic,strong) PostModel* postModel;
@property (nonatomic,strong) MBProgressHUD* hud;

@end

@implementation BrowseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self setupLayout];
    [self setupConstraints];
    
    [self.postModel fetchPostListAll];

}

- (void)viewDidAppear:(BOOL)animated
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    LoginViewController* lvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"lvc"];
    lvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    BOOL loggedIn = [PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]];
    
    if (!loggedIn)
    {
        [self presentViewController:lvc animated:NO completion:nil];
    } else {
        FBRequest *request = [FBRequest requestForMe];
        [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (error) {
                [PFUser logOut];
                [self presentViewController:lvc animated:YES completion:nil];
            }
        }];
    }
}


- (void)setupLayout
{
    self.navigationItem.title =@"Browse";
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:kColorNavOrange];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.tableView];
}

- (void) setupConstraints
{
    NSDictionary* dict = @{@"tableView":self.tableView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[tableView]|" options:0 metrics:nil views:dict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:dict]];
}

#pragma mark - setter

-(void)setPostList:(NSArray *)postList
{
    _postList = postList;
    [self.tableView reloadData];
}

#pragma mark - getter
- (PostListTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[PostListTableView alloc] init];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (PostModel *)postModel
{
    if (!_postModel) {
        _postModel = [[PostModel alloc] init];
        _postModel.delegate = self;
    }
    return _postModel;
}

#pragma mark - tableView DataSource

-(NSInteger)tableView:(PostListTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.postList.count;
}

- (PostListCell *)tableView:(PostListTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"postlist";
    PostListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PostListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    PostModel* post = (PostModel* )self.postList[indexPath.row];
    cell.textLabel.text = post.headline;
    cell.detailTextLabel.text = post.content;
    return cell;
}

#pragma mark - tableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostModel* post = self.postList[indexPath.row];
    [self performSegueWithIdentifier:@"BrowseToPostSegue" sender:post];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PostViewController* pvc = (PostViewController* )[segue destinationViewController];
    PostModel* post = (PostModel*) sender;
    pvc.postModel = post;
}

#pragma mark - postModel Delegate

-(void)didFetchDataAll:(NSMutableArray *)postList
{
    self.postList = postList;
}

-(void)failToFetchDataAll:(NSError *)error
{
    NSLog(@"%@",error);
}

@end
