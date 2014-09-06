//
//  ETSMasterTablesViewController.m
//  EudicTransform
//
//  Created by stone win on 9/6/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSMasterTablesViewController.h"
#import "ETSDBHelper.h"
#import "ETSDBTMaster.h"
#import "ETSTECoursesViewController.h"
#import "ETSTEItemsViewController.h"

@interface ETSMasterTablesViewController ()

@end

@implementation ETSMasterTablesViewController

- (NSArray *)dataFromTables
{
    
    NSArray *shownTables = @[ETSDBHelperTableCoursesName, ETSDBHelperTableItemsName];
    NSArray *tables = [[ETSDBHelper sharedInstance] selectFromMaster];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name IN %@", shownTables];
    NSArray *filteredArray = [tables filteredArrayUsingPredicate:predicate];
    return filteredArray;
}

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
    
    ETSDBTMaster *table = self.data[indexPath.row];
    cell.textLabel.text = table.name;
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETSDBTMaster *table = self.data[indexPath.row];
    if ([ETSDBHelperTableCoursesName isEqual:table.name])
    {
        ETSTECoursesViewController *controller = [[ETSTECoursesViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([ETSDBHelperTableItemsName isEqual:table.name])
    {
        ETSTEItemsViewController *controller = [[ETSTEItemsViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
