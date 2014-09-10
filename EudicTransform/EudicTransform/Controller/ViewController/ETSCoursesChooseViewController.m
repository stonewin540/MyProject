//
//  ETSCoursesChooseViewController.m
//  EudicTransform
//
//  Created by stone win on 9/10/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSCoursesChooseViewController.h"
#import "ETSDBTECourses.h"
#import "ETSDBHelper.h"

@interface ETSCoursesChooseViewController ()

@property (nonatomic, strong) ETSDBTECourses *course;
@property (nonatomic, strong) NSArray *data;

@end

@implementation ETSCoursesChooseViewController

- (void)prepareData
{
    self.data = [[ETSDBHelper sharedInstance] selectFromCourses];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithCourse:(ETSDBTECourses *)course
{
    self = [super init];
    if (self)
    {
        self.course = course;
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
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(coursesChooseViewController:didSelectCourse:)])
    {
        [self.delegate coursesChooseViewController:self didSelectCourse:element];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
