//
//  TravelListViewController.m
//  tripstr
//
//  Created by ctwsine on 3/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "TravelListViewController.h"
#import "TravelListTableView.h"
#import "TravelListCell.h"
#import "TravelPlanObject.h"

#import "DataClient.h"

@interface TravelListViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) TravelListTableView* tableView;
@property (nonatomic,strong) DataClient* dataClient;

@property (nonatomic,strong) NSArray* travelPlanList;

@end

@implementation TravelListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.dataClient parseFromTravelPlanJSONWithComplete:^(NSArray *returnArray) {
        self.travelPlanList = returnArray;
    } andFail:^(NSError *error) {
        NSLog(@"error: %@",error);
    }];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : [UIColor blackColor],
                                                                      NSFontAttributeName: [UIFont systemFontOfSize:30]
                                                                      
                                                                      }];
        
    [self.view addSubview:self.tableView];
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
    NSDictionary* dict = @{@"tableView":self.tableView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:dict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:dict]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- setter
-(void)setTravelPlanList:(NSArray *)travelPlanList
{
    _travelPlanList = travelPlanList;
    [self.tableView reloadData];
}

#pragma mark- getter
-(TravelListTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[TravelListTableView alloc] initForAutoLayout];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}

-(DataClient *)dataClient
{
    if (!_dataClient) {
        _dataClient = [[DataClient alloc] init];
    }
    return _dataClient;
}

#pragma mark- tableView DataSource
-(NSInteger)tableView:(TravelListTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.travelPlanList.count;
}

-(TravelListCell *)tableView:(TravelListTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"TravelListCell";
    TravelListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TravelListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    TravelPlanObject* travelPlan = (TravelPlanObject*) self.travelPlanList[indexPath.row];
    cell.cityImageView.image = [UIImage imageNamed:travelPlan.cityImagePath];
    cell.titleLabel.text = travelPlan.title;
    cell.cityNameLabel.text = travelPlan.cityName;
    cell.contentLabel.text = travelPlan.content;
    
    return cell;
}

#pragma mark - tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelPlanObject* travelPlan = [[TravelPlanObject alloc] init];
    [self performSegueWithIdentifier:@"TravelListToTravelPlanSegue" sender:travelPlan];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

@end
