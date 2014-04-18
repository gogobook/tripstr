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

#import "ConnectionListCell.h"

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
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : [UIColor blackColor],
                                                                      NSFontAttributeName: [UIFont systemFontOfSize:30]
                                                                      
                                                                      }];

    
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
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}

#pragma mark- tableview delegate/datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.connectionList.count;
}

-(ConnectionListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConnectionListCell* cell = (ConnectionListCell*)[tableView dequeueReusableCellWithIdentifier:@"connectionList"];
    if (!cell) {
        cell = [[ConnectionListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"connectionList"];
    }
    ConnectionsObject* user = (ConnectionsObject*) self.connectionList[indexPath.row];
    cell.userImageView.image = [UIImage imageNamed:user.userImagePath];
    cell.userNameLabel.text = user.userName;
    cell.userStatusLabel.text = user.userStatus;
    cell.userMessageLabel.text = user.userMessage;
    if ([cell.userStatusLabel.text isEqualToString:@"Friend"]) {
        cell.userStatusLabel.backgroundColor = [UIColor greenColor];
    } else {
        cell.userStatusLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}


@end
