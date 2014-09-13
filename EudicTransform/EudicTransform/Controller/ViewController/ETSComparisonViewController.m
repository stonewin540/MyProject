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
#import "ETSWord.h"
#import "ETSDBTEItems.h"

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
@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) NSArray *courseItems;

@end

@implementation ETSComparisonViewController

#pragma mark - Helper

- (NSArray *)words
{
    if (!_words)
    {
        _words = [[ETSParser defaultParser] wordsFromHTMLString:[ETSParser eudicHTMLString]];
    }
    return _words;
}

- (NSArray *)courseItems
{
    if (!_courseItems)
    {
        if (nil != self.selectedCourse)
        {
            _courseItems = [[ETSDBHelper sharedInstance] selectFromItemsWithCourseId:self.selectedCourse.CoursesId];
        }
    }
    return _courseItems;
}

- (void)prepareData
{
//    NSArray *words = nil;
//    NSArray *courses = nil;
//    words = [[ETSParser defaultParser] wordsFromHTMLString:[ETSParser eudicHTMLString]];
//    if (nil != self.selectedCourse)
//    {
//        courses = [[ETSDBHelper sharedInstance] selectFromItemsWithCourseId:self.selectedCourse.CoursesId];
//    }
//    
    ETSComparisonItem *wordsItem = [[ETSComparisonItem alloc] init];
    wordsItem.type = ETSComparisonItemTypeEudicWords;
    wordsItem.text = @"Eudic MyWords";
    wordsItem.detailText = [NSString stringWithFormat:@"count: %lu", (unsigned long)[self.words count]];
    wordsItem.headerText = @"Eudic";
    ETSComparisonItem *coursesItem = [[ETSComparisonItem alloc] init];
    coursesItem.type = ETSComparisonItemTypeSupermemoCourse;
    coursesItem.text = nil == self.selectedCourse ? @"Choose a Course to be compared" : @"Supermemo Courses";
    coursesItem.detailText = nil == self.selectedCourse ? nil : [NSString stringWithFormat:@"count: %lu", (unsigned long)[self.courseItems count]];
    coursesItem.headerText = @"Supermemo";
    
    self.data = @[@[wordsItem], @[coursesItem]];
}

#pragma mark - Action

- (void)compareButtonTapped:(UIButton *)sender
{
//    NSMutableArray *wordNames = [NSMutableArray array];
//    [self.words enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        ETSWord *word = obj;
//        if ([word.name length] > 0)
//        {
//            [wordNames addObject:word.name];
//        }
//    }];
//    
//    NSMutableArray *itemNames = [NSMutableArray array];
//    [self.courseItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        ETSDBTEItems *item = obj;
//        if ([item.Name length] > 0)
//        {
//            [itemNames addObject:item.Name];
//        }
//    }];
    
//    NSMutableArray *result = [NSMutableArray array];
//    [self.words enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        ETSWord *word = obj;
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.Question LIKE %@", word.name];
//        NSArray *filtered = [self.courseItems filteredArrayUsingPredicate:predicate];
//        if (0 == [filtered count])
//        {
//            [result addObject:word];
//        }
//    }];
//    
//    NSLog(@"%@", result);
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (name IN %@.Question)", self.courseItems];
    NSArray *result = [self.words filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", result);
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
    
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 45)];
    tableFooterView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = tableFooterView;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectInset(tableFooterView.bounds, 15, 0)];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitle:@"Compare" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(compareButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [tableFooterView addSubview:button];
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
