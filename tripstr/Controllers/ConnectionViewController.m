//
//  ConnectionViewController.m
//  tripstr
//
//  Created by ctwsine on 4/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "ConnectionViewController.h"
#import "DataClient.h"
#import "ConnectionsObject.h"

@interface ConnectionViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) DataClient* dataClient;
@property (nonatomic,strong) NSArray* connectionList;

@property (nonatomic,strong) UITableView* tableView;

@end

@implementation ConnectionViewController

-(id)init
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
    [self.dataClient parseFromConnectionJSONWithComplete:^(NSArray *returnArray) {
        self.connectionList = returnArray;
    } andFail:^(NSError *error) {
        NSLog(@"ERROR: %@", error);
    }];
    [self setLayout];
    
}

-(void) setLayout
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"Connections";
    [self.view addSubview:self.tableView];
}

-(void) updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
}


#pragma mark- setter
-(void)setConnectionList:(NSArray *)connectionList
{
    _connectionList = connectionList;
    [self.tableView reloadData];
}

#pragma mark- getter

-(DataClient *)dataClient
{
    if (!_dataClient) {
        _dataClient = [[DataClient alloc] init];
    }
    return _dataClient;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initForAutoLayout];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor grayColor];
    }
    return _tableView;
}

#pragma mark- tableview delegate/datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.connectionList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"connectionList"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"connectionList"];
    }
    ConnectionsObject* user = (ConnectionsObject*) self.connectionList[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:user.userImagePath];
    cell.textLabel.text = user.userName;
    cell.detailTextLabel.text = user.userStatus;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}


@end
