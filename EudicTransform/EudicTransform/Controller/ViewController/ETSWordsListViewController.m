//
//  ETSWordsListViewController.m
//  EudicTransform
//
//  Created by stone win on 8/23/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSWordsListViewController.h"
#import "ETSNewWord.h"

#define FONT_CELL_DETAILTEXTLABEL [UIFont systemFontOfSize:10]
@implementation UITableViewCell (ETSWordsListViewController)

- (void)setWord:(ETSNewWord *)word {
    self.textLabel.text = [NSString stringWithFormat:@"%@. %@", word.serialNumber, word.word];
    
    self.detailTextLabel.textColor = [UIColor grayColor];
    self.detailTextLabel.font = FONT_CELL_DETAILTEXTLABEL;
    self.detailTextLabel.text = word.content;
    self.detailTextLabel.numberOfLines = 0;
}

+ (CGFloat)heightOfWord:(ETSNewWord *)word {
    // html 的高度不好计算，所以干脆显示一屏得了
    CGFloat appHeight = [UIScreen mainScreen].bounds.size.height;
    appHeight -= 64;// navigation bar
    appHeight -= 44;// tab bar
    return appHeight;
}

@end

@interface ETSWordsListViewController () <UITableViewDataSource, UITableViewDelegate>

// UI
@property (nonatomic, strong) UITableView *tableView;
// data
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation ETSWordsListViewController

- (void)setWords:(NSArray *)words {
    self.data = [words mutableCopy];
    [self.tableView reloadData];
}

- (NSArray *)words {
    return self.data;
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

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static const NSInteger kTag = 15010301;
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        UIWebView *webView = [[UIWebView alloc] initWithFrame:cell.contentView.bounds];
        webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        webView.tag = kTag;
        webView.scrollView.scrollEnabled = NO;
        [cell.contentView addSubview:webView];
    }
    
    ETSNewWord *word = self.data[indexPath.row];
    UIWebView *webView = (UIWebView *)[cell.contentView viewWithTag:kTag];
    [webView loadHTMLString:word.content baseURL:nil];
    
    return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell heightOfWord:self.data[indexPath.row]];
}

@end
