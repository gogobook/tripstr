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
#import "TravelPlanModel.h"

@interface TravelListViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) TravelListTableView* tableView;

@end

@implementation TravelListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

#pragma mark- getter
-(TravelListTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[TravelListTableView alloc] initWithFrame:CGRectMake(0, 60, 320, 400)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark- tableView DataSource
-(NSInteger)tableView:(TravelListTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(TravelListCell *)tableView:(TravelListTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"TravelListCell";
    TravelListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TravelListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"Title";
    cell.detailTextLabel.text = @"detail...";
    return cell;
}

#pragma mark - tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelPlanModel* travelPlan = [[TravelPlanModel alloc] init];
    [self performSegueWithIdentifier:@"TravelListToTravelPlanSegue" sender:travelPlan];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end
