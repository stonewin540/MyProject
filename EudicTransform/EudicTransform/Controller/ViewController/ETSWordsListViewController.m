//
//  ETSWordsListViewController.m
//  EudicTransform
//
//  Created by stone win on 8/23/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSWordsListViewController.h"
#import "ETSWord.h"
#import "ETSParser.h"

@interface ETSWordsListViewController () <UITableViewDataSource, UITableViewDelegate>

// UI
@property (nonatomic, strong) UITableView *tableView;
// data
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation ETSWordsListViewController

#pragma mark - Helper

- (NSString *)eudicHTMLString
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"myWords" ofType:@"html"];
    if ([path length] > 0)
    {
        NSError *error = nil;
        NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        if (nil == error)
        {
            return string;
        }
    }
    
    return nil;
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"欧陆词典单词本";
        self.data = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (void)asyncReloadWords
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Loading…" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
    
    ETSWordsListViewController *__weak wself = self;
    [[ETSParser defaultParser] asyncWordsFromHTMLString:[wself eudicHTMLString] completionBlock:^(NSArray *words) {
        
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        [wself.data removeAllObjects];
        [wself.data addObjectsFromArray:words];
        [wself.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        
    }];
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
    [self asyncReloadWords];
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

#pragma mark - TableView Delegate

- (NSString *)detailStringWithWord:(ETSWord *)word
{
    NSMutableString *detailText = [NSMutableString string];
    
    [detailText appendString:@"uk "];
    if ([word.phoneticUK length] > 0)
    {
        [detailText appendString:word.phoneticUK];
    }
    [detailText appendString:@"us "];
    if ([word.phoneticUS length] > 0)
    {
        [detailText appendString:word.phoneticUS];
    }
    if ([word.remark length] > 0)
    {
        [detailText appendFormat:@"\n\nremark:\n%@", [word.remark stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
    if ([word.desc length] > 0)
    {
        [detailText appendFormat:@"\n\n%@", [word.desc stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
    
    return [detailText copy];
}

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    ETSWord *word = self.data[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@. %@", word.wordId, word.name];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.text = [self detailStringWithWord:word];
    cell.detailTextLabel.numberOfLines = 0;
    
    return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETSWord *word = self.data[indexPath.row];
    if ([word.desc length] > 0)
    {
        return 44 + ceilf([[self detailStringWithWord:word] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]}].height);
    }
    else
    {
        return 44;
    }
}

@end
