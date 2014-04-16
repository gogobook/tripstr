//
//  PostListViewController.m
//  tripstr
//
//  Created by ctwsine on 3/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "PostListViewController.h"
#import "PostListTableView.h"
#import "PostListCell.h"
#import "PostModel.h"

#import "AddPostViewController.h"
#import "PostViewController.h"

@interface PostListViewController () <UITableViewDataSource,UITableViewDelegate,PostModelDelegate>

@property (nonatomic,strong) PostListTableView* tableView;

@property (nonatomic,strong) PostModel* post;
@property (nonatomic,strong) NSArray* postList;


@end

@implementation PostListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setLayout];
    [self setupConstraints];
    [self.post fetchPostListAll];

}

-(void) setLayout
{
    [self.view addSubview:self.tableView];
    self.navigationController.navigationBar.translucent = NO;
}

- (void) setupConstraints
{
    NSDictionary* dict =@{@"tableView":self.tableView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:dict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:dict]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- setter
-(void)setPostList:(NSArray *)postList
{
    _postList = postList;
    [self.tableView reloadData];
}

#pragma mark - getter
-(PostListTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[PostListTableView alloc] init];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(PostModel *)post
{
    if (!_post) {
        _post = [[PostModel alloc] init];
        _post.delegate = self;
    }
    return _post;
}

#pragma mark - tableView DataSource

-(NSInteger)tableView:(PostListTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.postList.count;
}

-(PostListCell *)tableView:(PostListTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"PostListCell";
    PostListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PostListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    PostModel* post = self.postList[indexPath.row];
//    cell.textLabel.text = post.headline;
//    cell.detailTextLabel.text = post.content;
    cell.titleLabel.text = post.headline;
    cell.locationLabel.text = post.location;
    cell.contentLabel.text = post.content;
    cell.postImageView.file = post.photo;
    [cell.postImageView loadInBackground];
//    [cell.postImageView setImageWithURL:[NSURL URLWithString:post.photoURLString]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostModel* post = self.postList[indexPath.row];
    [self performSegueWithIdentifier:@"PostListToPostSegue" sender:post];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PostListToPostSegue"]) {
        PostViewController* pvc = (PostViewController*) [segue destinationViewController];
        pvc.postModel = (PostModel*)sender;
    }
    
}

#pragma mark- postModel delegate
-(void)didFetchDataAll:(NSMutableArray *)postList
{
    self.postList = postList;
}

-(void)failToFetchDataAll:(NSError *)error
{
    NSLog(@"plvc error: %@",error);
}

@end
