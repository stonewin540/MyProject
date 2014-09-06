//
//  ETSMasterTableViewController.m
//  EudicTransform
//
//  Created by stone win on 8/30/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSTablesTableViewController.h"
#import "ETSDBHelper.h"
#import "ETSDBTable.h"

@interface ETSTablesTableViewController () <UITableViewDataSource, UITableViewDelegate>

// UI
@property (nonatomic, strong) UITableView *tableView;
// data
@property (nonatomic, strong) NSArray *data;

@end

@implementation ETSTablesTableViewController

#pragma mark - DB

- (void)prepareData
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Loading…" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
    
    NSArray *tables = [[ETSDBHelper sharedInstance] selectFromMaster];
    self.data = tables;
    [self.tableView reloadData];
    
    tables = [tables sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 isKindOfClass:[ETSDBMasterTable class]] && [obj2 isKindOfClass:[ETSDBMasterTable class]])
        {
            return [((ETSDBMasterTable *)obj1).name compare:((ETSDBMasterTable *)obj2).name options:NSCaseInsensitiveSearch];
        }
        else
        {
            return NSOrderedSame;
        }
    }];
    self.data = tables;
    [self.tableView reloadData];
    
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Master Table List";
    }
    return self;
}

- (void)loadTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    
    [self loadTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    [[ETSDBHelper sharedInstance] close];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    ETSDBMasterTable *table = self.data[indexPath.row];
    cell.textLabel.text = table.name;
    
    return cell;
}

@end
