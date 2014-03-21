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

@interface BrowseViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) PostListTableView* tableView;
@property (nonatomic,strong) NSArray* postList;

@end

@implementation BrowseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"BrowseViewController initiated");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (PostListTableView *)tableView
{
    if (!_tableView) {
        CGRect frame = self.view.frame;
        frame.origin.y = 164;
        _tableView = [[PostListTableView alloc] initWithFrame:frame];
        _tableView.dataSource = self;
        _tableView.delegate = self;
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
    
}

@end
