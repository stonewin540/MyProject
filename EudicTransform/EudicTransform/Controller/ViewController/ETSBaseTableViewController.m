//
//  ETSMasterTableViewController.m
//  EudicTransform
//
//  Created by stone win on 8/30/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSBaseTableViewController.h"
#import "ETSDBHelper.h"
#import "ETSDBTMaster.h"

@interface ETSBaseTableViewController ()

// UI
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ETSBaseTableViewController

#pragma mark - Public

- (void)alertViewOfLoadingWithAsyncProcessBlock:(void(^)(void))processBlock completionBlock:(void(^)(void))completionBlock
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Loading…" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        if (processBlock)
        {
            processBlock();
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock)
            {
                completionBlock();
            }
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        });
    });
}

#pragma mark - DB

- (void)resortData
{
    self.data = self.data;
}

- (void)prepareData
{
    self.data = nil;
}

- (void)reloadTableView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Loading…" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self prepareData];
        [self resortData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        });
    });
}

- (void)reloadTableViewIfNeeded
{
    if (0 == [self.data count])
    {
        [self reloadTableView];
    }
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [self reloadTableViewIfNeeded];
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
    
    return cell;
}

@end
