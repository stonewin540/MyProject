//
//  ETSTEItemsViewController.m
//  EudicTransform
//
//  Created by stone win on 9/6/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSTEItemsViewController.h"
#import "ETSDBHelper.h"
#import "ETSDBTEItems.h"

@interface ETSTEItemsViewController ()

@property (nonatomic, strong) NSArray *setedItems;
@property (nonatomic, assign) BOOL isInitWithItems;

@end

@implementation ETSTEItemsViewController

- (void)prepareData
{
    if (self.isInitWithItems)
    {
        self.data = self.setedItems;
    }
    else
    {
        self.data = [[ETSDBHelper sharedInstance] selectFromItems];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Items";
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self)
    {
        self.setedItems = items;
        self.isInitWithItems = YES;
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
    
    ETSDBTEItems *element = self.data[indexPath.row];
    cell.textLabel.text = element.Name;
    
    return cell;
}

#pragma mark - TableView Delegate

@end
