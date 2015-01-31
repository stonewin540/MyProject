//
//  ViewController.m
//  SinaWeiboAlbumGrabber
//
//  Created by stone win on 1/28/15.
//  Copyright (c) 2015 stone win. All rights reserved.
//

#import "ViewController.h"
#import "HTMLParser.h"
#import "SDWebImageManager.h"

static NSString *const kIndicatorWelcome = @"欢迎登录";
static NSString *const kIndicatorLogin = @"登录";
static NSString *const kIndicatorLogedIn = @"微博";

@interface ViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSMutableArray *weiboNodes;

@end

@implementation ViewController

- (void)alertMessage:(NSString *)message duration:(NSTimeInterval)duration {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    });
}

- (BOOL)hasLogedIn {
    static NSString *const kTitle = @"document.title";
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:kTitle];
    return [title hasPrefix:kIndicatorLogedIn];
}

- (void)processButtonItemTapped:(id)sender {
    static NSString *const kInnerHTML = @"document.body.innerHTML";
    NSString *html = [self.webView stringByEvaluatingJavaScriptFromString:kInnerHTML];
    
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
    if (!error)
    {
        static NSString *const kTagDiv = @"div";
        HTMLNode *div = nil;
        HTMLNode *body = [parser body];
        NSArray *children = [body children];
        NSUInteger count = children.count;
        for (int i = 0; i < count; i++)
        {
            HTMLNode *node = children[i];
            if ([kTagDiv isEqualToString:[node tagName]])
            {
                div = node;
                break;
            }
        }
        
        if (nil == div)
        {
            return;
        }
        
        static NSString *const kTagSection = @"section";
        HTMLNode *section = nil;
        children = [div children];
        count = children.count;
        for (int i = 0; i < count; i++)
        {
            HTMLNode *node = children[i];
            if ([kTagSection isEqualToString:[node tagName]])
            {
                section = node;
                break;
            }
        }
        
        if (nil == section)
        {
            return;
        }
        
        static NSString *const kClassCardList = @"card-list";
        div = nil;
        children = [section children];
        count = children.count;
        for (int i = 0; i < count; i++)
        {
            HTMLNode *node = children[i];
            NSString *tagName = [node tagName];
            NSString *className = [node className];
            if ([kTagDiv isEqualToString:tagName] && [kClassCardList isEqualToString:className])
            {
                div = node;
                break;
            }
        }
        
        if (nil == div)
        {
            return;
        }
        
        static NSString *const kClassCard9LineAround = @"card card9 line-around";
//        children = [div children];
//        count = children.count;
//        for (int i = 0; i < count; i++)
//        {
//            HTMLNode *node = children[i];
//            if ([kClassCard9LineAround isEqualToString:[node className]])
//            {
//                HTMLNode *section = nil;
//                NSArray *children = [node children];
//                NSUInteger count = children.count;
//                for (int j = 0; j < count; j++)
//                {
//                    HTMLNode *subnode = children[i];
//                    if ([kTagSection isEqualToString:[subnode tagName]])
//                    {
//                        section = subnode;
//                        break;
//                    }
//                }
//                
//                if (section)
//                {
//                    HTMLNode *p = [section findChildTag:@"p"];
//                    if (p)
//                    {
//                        
//                    }
//                }
//            }
//        }
//        BOOL (^arrayContainsObject)(NSArray *, HTMLNode *) = ^ BOOL (NSArray *array, HTMLNode *node) {
//            BOOL contains = NO;
//            
//            NSUInteger count = array.count;
//            for (int i = 0; i < count; i++)
//            {
//                HTMLNode *weiboNode = array[i];
//                NSString *weiboRawContents = [weiboNode rawContents];
//                NSString *nodeRawContents = [node rawContents];
//                if ([weiboRawContents isEqualToString:nodeRawContents])
//                {
//                    contains = YES;
//                    break;
//                }
//                NSArray *weiboNodeChildren = [weiboNode children];
//                NSArray *nodeChildren = [node children];
//                NSUInteger weiboCount = weiboNodeChildren.count;
//                NSUInteger nodeCount = nodeChildren.count;
//                if (weiboCount != nodeCount)
//                {
//                    continue;
//                }
//                else
//                {
//                    NSUInteger matchCount = weiboCount;
//                    for (int j = 0; j < weiboCount; j++)
//                    {
//                        HTMLNode *weiboSubnode = weiboNodeChildren[j];
//                        HTMLNode *nodeSubnode = nodeChildren[j];
//                        if (![[weiboSubnode rawContents] isEqualToString:[nodeSubnode rawContents]])
//                        {
//                            matchCount--;
//                        }
//                    }
//                    
//                    contains = (weiboCount == matchCount);
//                }
//                
//                if (contains)
//                {
//                    break;
//                }
//            }
//            
//            return contains;
//        };
        
        NSArray *tags = [div findChildrenOfClass:kClassCard9LineAround];
        NSUInteger tagCount = tags.count;
        for (int i = 0; i < tagCount; i++)
        {
            HTMLNode *tagNode = tags[i];
            
            BOOL contains = NO;
            for (int j = 0; j < self.weiboNodes.count; j++)
            {
                HTMLNode *weiboNode = self.weiboNodes[j];
                NSString *weiboRawContents = [weiboNode rawContents];
                NSString *tagRawContents = [tagNode rawContents];
                if ([tagRawContents isEqualToString:weiboRawContents])
                {
                    contains = YES;
                }
            }
            if (!contains)
            {
                [self.weiboNodes addObject:tagNode];
            }
        }
        
        for (int i = 0; i < self.weiboNodes.count; i++)
        {
            HTMLNode *node = self.weiboNodes[i];
            HTMLNode *section = [node findChildTag:@"section"];
            HTMLNode *p = [section findChildTag:@"p"];
            NSString *text = [p contents];
            
            NSMutableArray *urls = [NSMutableArray array];
            HTMLNode *div = [section findChildTag:@"div"];
            HTMLNode *ul = [section findChildTag:@"ul"];
            NSArray *lis = [ul findChildTags:@"li"];
            for (int j = 0; j < lis.count; j++)
            {
                HTMLNode *li = lis[j];
                HTMLNode *img = [li findChildTag:@"img"];
                NSString *url = [img getAttributeNamed:@"data-src"];
                if (!url)
                {
                    url = [img getAttributeNamed:@"src"];
                }
                NSRange range = [url rangeOfString:@"thumb180"];
                NSParameterAssert(range.length > 0);
                url = [url stringByReplacingOccurrencesOfString:@"thumb180" withString:@"large"];
                if (url)
                {
                    [urls addObject:url];
                }
            }
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *rootPath = [paths[0] stringByAppendingPathComponent:@"weibo"];
            if (![[NSFileManager defaultManager] fileExistsAtPath:rootPath])
            {
                NSError *error = nil;
                BOOL succeed = [[NSFileManager defaultManager] createDirectoryAtPath:rootPath withIntermediateDirectories:YES attributes:nil error:&error];
            }
            
            NSString *weiboIndexString = [NSString stringWithFormat:@"weibo%d", i];
            NSString *weiboPath = [rootPath stringByAppendingPathComponent:weiboIndexString];
            if (![[NSFileManager defaultManager] fileExistsAtPath:weiboPath])
            {
                [[NSFileManager defaultManager] createDirectoryAtPath:weiboPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            
            NSString *textPath = [weiboPath stringByAppendingPathComponent:@"text.txt"];
            [text writeToFile:textPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
            for (int j = 0; j < urls.count; j++)
            {
                NSString *imageIndexString = [NSString stringWithFormat:@"image%d.jpg", j];
                NSString *imagePath = [weiboPath stringByAppendingPathComponent:imageIndexString];
                NSURL *url = [NSURL URLWithString:urls[j]];
                [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageLowPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if (!error && finished)
                    {
                        NSData *data = UIImageJPEGRepresentation(image, 1);
                        [data writeToFile:imagePath atomically:YES];
                    }
                }];
            }
        }
    }
    else
    {
        NSLog(@"%s%d\n\t%@", __func__, __LINE__, error);
    }
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _weiboNodes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"process" style:UIBarButtonItemStylePlain target:self action:@selector(processButtonItemTapped:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    static NSString *const kWeiboHome = @"http://www.weibo.com";
    static NSString *const kWeb = @"http://m.weibo.cn/page/tpl?containerid=1005051116029424_-_WEIBO_SECOND_PROFILE_WEIBO&itemid=&title=%E5%85%A8%E9%83%A8%E5%BE%AE%E5%8D%9A";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kWeb]];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
