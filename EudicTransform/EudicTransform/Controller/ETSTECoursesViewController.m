//
//  ETSTICoursesViewController.m
//  EudicTransform
//
//  Created by stone win on 9/6/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSTECoursesViewController.h"
#import "ETSDBHelper.h"
#import "ETSDBTECourses.h"
#import "ETSTEItemsViewController.h"

@interface ETSTECoursesViewController ()

@end

@implementation ETSTECoursesViewController

- (NSArray *)dataFromTables
{
    return [[ETSDBHelper sharedInstance] selectFromCourses];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Courses";
    }
    return self;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    ETSDBTECourses *element = self.data[indexPath.row];
    cell.textLabel.text = element.Title;
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETSDBTECourses *element = self.data[indexPath.row];
    NSArray *items = [[ETSDBHelper sharedInstance] selectFromItemsWithCourseId:element.CoursesId];
    ETSTEItemsViewController *controller = [[ETSTEItemsViewController alloc] initWithItems:items];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
