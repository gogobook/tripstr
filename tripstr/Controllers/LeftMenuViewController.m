//
//  LeftMenuViewController.m
//  tripstr
//
//  Created by ctwsine on 3/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftMenuTableView.h"
#import "LeftMenuCell.h"

#import "BrowseViewController.h"
#import "TravelListViewController.h"
#import "PostListViewController.h"

#import <UIViewController+JASidePanel.h>
#import <JASidePanelController.h>

typedef enum LeftMenuItem {
    LeftMenuItemBrowse,LeftMenuItemTravels,LeftMenuItemPosts
}LeftMenuItem;

@interface LeftMenuViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) LeftMenuTableView* tableView;
@property (nonatomic,strong) NSArray* menuList;
//
//@property (nonatomic,strong) BrowseViewController* browseViewController;
//@property (nonatomic,strong) TravelListViewController* travelListViewcontroller;
//@property (nonatomic,strong) PostListViewController* postListViewController;

@end

@implementation LeftMenuViewController

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

#pragma mark- tableView
-(LeftMenuTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[LeftMenuTableView alloc] initWithFrame:CGRectMake(0, 64, 320, 480)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSArray *)menuList
{
    if (!_menuList) {
        _menuList = @[@"Browse",@"Travel Plans",@"Posts"];
    }
    return _menuList;
}

#pragma mark- tableView DataSource
-(NSInteger)tableView:(LeftMenuTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuList count];
}
-(LeftMenuCell *)tableView:(LeftMenuTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"LeftMenuCell";
    LeftMenuCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LeftMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.menuList[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString* segueID;
    switch (indexPath.row) {
        case LeftMenuItemBrowse:
        {
            NSLog(@"Browse tapped");
            BrowseViewController* bvc = [self.storyboard instantiateViewControllerWithIdentifier:@"bvc"];
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:bvc];
            break;
        }
        case LeftMenuItemTravels:
        {
            NSLog(@"Travel tapped");
            TravelListViewController* tlvc = [self.storyboard instantiateViewControllerWithIdentifier:@"tlvc"];
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:tlvc];
            break;
        }
        case LeftMenuItemPosts:
        {
            NSLog(@"Posts tapped");
            PostListViewController* plvc = [self.storyboard instantiateViewControllerWithIdentifier:@"plvc"];
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:plvc];
            break;
        }
        default:
            NSLog(@"indexPath.row is not right");
            break;
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
