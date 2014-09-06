//
//  ETSComparisonViewController.m
//  EudicTransform
//
//  Created by stone win on 9/6/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSComparisonViewController.h"
#import "ETSParser.h"
#import "ETSDBHelper.h"

@interface ETSComparisonItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger count;

@end

@implementation ETSComparisonItem

@end

//static const NSInteger kNumberOfSections = 2;
static const NSInteger kNumberOfRows = 2;

@interface ETSComparisonViewController () <UITableViewDataSource, UITableViewDelegate>

// UI
@property (nonatomic, strong) UITableView *tableView;
// data
@property (nonatomic, strong) NSArray *data;

@end

@implementation ETSComparisonViewController

#pragma mark - Helper

- (NSArray *)prepareData
{
    NSArray *words = nil;
    NSArray *courses = nil;
    words = [[ETSParser defaultParser] wordsFromHTMLString:[ETSParser eudicHTMLString]];
    courses = [[ETSDBHelper sharedInstance] selectFromCourses];
    
    ETSComparisonItem *wordsItem = [[ETSComparisonItem alloc] init];
    wordsItem.name = @"words";
    wordsItem.count = [words count];
    ETSComparisonItem *coursesItem = [[ETSComparisonItem alloc] init];
    coursesItem.name = @"supermemo courses";
    coursesItem.count = [courses count];
    return @[wordsItem, coursesItem];
}

- (void)reloadTableView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Loading…" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        self.data = [self prepareData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            [self.tableView reloadData];
        });
    });
}

#pragma makr - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Comparison";
    }
    return self;
}

- (void)loadTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.tableView.bounds];
    backgroundView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.backgroundView = backgroundView;
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
    if (0 == [self.data count])
    {
        [self reloadTableView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return kNumberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    ETSComparisonItem *item = self.data[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"count: %d", item.count];
    
    return cell;
}

@end
