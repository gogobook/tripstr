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

@interface BrowseViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) PostListTableView* tableView;
@property (nonatomic,strong) NSArray* postList;

@end

@implementation BrowseViewController

- (id)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupLayout];
    [self setupConstraints];

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


#pragma mark - getter
- (PostListTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[PostListTableView alloc] init];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}


#pragma mark - tableView DataSource

-(NSInteger)tableView:(PostListTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (PostListCell *)tableView:(PostListTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"postlist";
    PostListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PostListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"Title";
    cell.detailTextLabel.text = @"description";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostModel* post = self.postList[indexPath.row];
    [self performSegueWithIdentifier:@"BrowseToPostViewSegue" sender:post];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PostViewController* pvc = (PostViewController* )[segue destinationViewController];
    PostModel* post = (PostModel*) sender;
    pvc.postModel = post;
}

@end
