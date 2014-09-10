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
#import "ETSCoursesChooseViewController.h"
#import "ETSDBTECourses.h"

typedef NS_ENUM(NSUInteger, ETSComparisonItemType) {
    ETSComparisonItemTypeEudicWords,
    ETSComparisonItemTypeSupermemoCourse,
};

@interface ETSComparisonItem : NSObject

@property (nonatomic, assign) ETSComparisonItemType type;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *detailText;
@property (nonatomic, copy) NSString *headerText;

@end

@implementation ETSComparisonItem

@end

@interface ETSComparisonViewController () <UITableViewDataSource, UITableViewDelegate, ETSCoursesChooseViewControllerDelegate>

// UI
@property (nonatomic, strong) UITableView *tableView;
// data
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) ETSDBTECourses *selectedCourse;

@end

@implementation ETSComparisonViewController

#pragma mark - Helper

- (void)prepareData
{
    NSArray *words = nil;
    NSArray *courses = nil;
    words = [[ETSParser defaultParser] wordsFromHTMLString:[ETSParser eudicHTMLString]];
    if (nil != self.selectedCourse)
    {
        courses = [[ETSDBHelper sharedInstance] selectFromItemsWithCourseId:self.selectedCourse.CoursesId];
    }
    
    ETSComparisonItem *wordsItem = [[ETSComparisonItem alloc] init];
    wordsItem.type = ETSComparisonItemTypeEudicWords;
    wordsItem.text = @"Eudic MyWords";
    wordsItem.detailText = [NSString stringWithFormat:@"count: %u", [words count]];
    wordsItem.headerText = @"Eudic";
    ETSComparisonItem *coursesItem = [[ETSComparisonItem alloc] init];
    coursesItem.type = ETSComparisonItemTypeSupermemoCourse;
    coursesItem.text = nil == self.selectedCourse ? @"Choose a Course to be compared" : @"Supermemo Courses";
    coursesItem.detailText = nil == self.selectedCourse ? nil : [NSString stringWithFormat:@"count: %u", [courses count]];
    coursesItem.headerText = @"Supermemo";
    
    self.data = @[@[wordsItem], @[coursesItem]];
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
//    self.tableView.scrollEnabled = NO;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSArray *rows = self.data[indexPath.section];
    ETSComparisonItem *item = rows[indexPath.row];
    cell.textLabel.text = item.text;
    cell.detailTextLabel.text = item.detailText;
    
    return cell;
}

#pragma mark - TableView Delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ETSComparisonItem *item = [self.data[section] firstObject];
    return item.headerText;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETSComparisonItem *item = self.data[indexPath.section][indexPath.row];
    switch (item.type)
    {
        case ETSComparisonItemTypeSupermemoCourse:
        {
            ETSCoursesChooseViewController *controller = [[ETSCoursesChooseViewController alloc] init];
            controller.delegate = self;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case ETSComparisonItemTypeEudicWords:
            break;
    }
}

#pragma mark - CoursesChooseViewController Delegate

- (void)coursesChooseViewController:(ETSCoursesChooseViewController *)controller didSelectCourse:(ETSDBTECourses *)course
{
    self.selectedCourse = course;
    [self reloadTableView];
    [controller.navigationController popViewControllerAnimated:YES];
}

@end
