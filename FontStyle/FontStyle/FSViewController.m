//
//  FSViewController.m
//  FontStyle
//
//  Created by stone win on 12/26/12.
//  Copyright (c) 2012 stone win. All rights reserved.
//

#import "FSViewController.h"
#import "FSActionSheet.h"

#define HEIGHT_PICKER   162

#define TEXT_CUSTOMTEXTVIEW_PLACEHOLDER @"Custom ur text here!"

#define FONT_FONTNAMELABEL  [UIFont systemFontOfSize:30]

@interface FSViewController () <UIPickerViewDataSource, UIPickerViewDelegate, FSActionSheetDelegate>
{
    CGRect _frame;
    NSArray *_familyNames;
    NSArray *_styleNames;
}

@property (nonatomic, strong) UITextView *customTextView;
@property (nonatomic, strong) UILabel *fontNameLabel;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) FSActionSheet *sheet;

@end

@implementation FSViewController

#pragma mark - Helpers

- (void)reloadComponent1
{
    if (!_picker) return;
    
    [_picker reloadComponent:1];
    [_picker selectRow:0
           inComponent:1
              animated:YES];
}

- (void)reloadStyleNamesForRow:(NSInteger)row
{
    NSString *familyName = [_familyNames objectAtIndex:row];
    _styleNames = [UIFont fontNamesForFamilyName:familyName];
}

- (void)reloadViewFontWithRow:(NSInteger)row
{
    NSInteger count = [_styleNames count];
    if (row < 0 || row >= count) return;
    
    NSString *styleName = [_styleNames objectAtIndex:row];
    if (styleName && [styleName length])
    {
        if (_fontNameLabel)
        {
            _fontNameLabel.text = styleName;
            _fontNameLabel.font = [UIFont fontWithName:styleName
                                                  size:30];
        }
        if (_customTextView)
        {
            _customTextView.font = [UIFont fontWithName:styleName
                                                   size:30];
        }
    }
}

- (BOOL)resignedCustomTextView
{
    if (!_customTextView) return NO;
    if ([_customTextView isFirstResponder])
    {
        [_customTextView resignFirstResponder];
        if (_sheet)
        {
            [_sheet dismiss];
            [self setSheet:nil];
        }
        return YES;
    }
    return NO;
}

#pragma mark - Actions

- (void)customButtonTapped:(UIButton *)sender
{
    if ([self resignedCustomTextView]) return;
    
    if (!_sheet)
    {
        _frame = CGRectMake(0, 0, 320, 196);
        _sheet = [[FSActionSheet alloc] initWithFrame:_frame];
        _sheet.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        _sheet.delegate = self;
        CIColor *color = nil;
        if (_customTextView)
        {
            color = [CIColor colorWithCGColor:_customTextView.textColor.CGColor];
        }
        [_sheet setSliderRed:color.red
                       greed:color.green
                        blue:color.blue];
        [_sheet showInView:self.view];
    }
    else
    {
        [_sheet dismiss];
        [self setSheet:nil];
    }
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _familyNames = [[NSArray alloc] init];
        _styleNames = [[NSArray alloc] init];
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] init];
    self.view = view;
    
    // Custom text view
    _frame.origin = CGPointZero;
    _frame.size = CGSizeMake(APPSIZE.width, 262);
    
    _customTextView = [[UITextView alloc] initWithFrame:_frame];
    //_customTextView.backgroundColor = [UIColor redColor];
    _customTextView.opaque = YES;
    _customTextView.text = TEXT_CUSTOMTEXTVIEW_PLACEHOLDER;
    _customTextView.textAlignment = UITextAlignmentLeft;
    //_customTextView.font = FONT_FONTNAMELABEL;
    [self.view addSubview:_customTextView];
    
    // Custom button
    _frame.size = CGSizeMake(20, 20);
    _frame.origin = CGPointMake(APPSIZE.width - 20 - 10, 10);
    
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    customButton.frame = _frame;
    [customButton addTarget:self
                     action:@selector(customButtonTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customButton];
    
    // Font name label
    _frame.size = [@"A" sizeWithFont:FONT_FONTNAMELABEL];
    _frame.size.width = APPSIZE.width;
    _frame.origin = CGPointMake(0, APPSIZE.height - HEIGHT_PICKER - _frame.size.height);
    
    _fontNameLabel = [[UILabel alloc] initWithFrame:_frame];
    //_fontNameLabel.backgroundColor = [UIColor greenColor];
    _fontNameLabel.opaque = YES;
    _fontNameLabel.textAlignment = UITextAlignmentCenter;
    //_fontNameLabel.font = FONT_FONTNAMELABEL;
    _fontNameLabel.numberOfLines = 1;
    _fontNameLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:_fontNameLabel];
    
    // Picker selector
    _frame.size = CGSizeMake(APPSIZE.width, HEIGHT_PICKER);
    _frame.origin = CGPointMake(0, APPSIZE.height - HEIGHT_PICKER);
    _picker = [[UIPickerView alloc] initWithFrame:_frame];
    _picker.showsSelectionIndicator = YES;
    _picker.dataSource = self;
    _picker.delegate = self;
    [self.view addSubview:_picker];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _familyNames = [UIFont familyNames];
    _styleNames = [UIFont fontNamesForFamilyName:[_familyNames objectAtIndex:0]];
    [self reloadViewFontWithRow:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Picker DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger retVal;
    
    switch (component)
    {
        case 0:
            retVal = [_familyNames count];
            break;
        case 1:
        {
            NSInteger selectedRow = [pickerView selectedRowInComponent:0];
            [self reloadStyleNamesForRow:selectedRow];
            retVal = [_styleNames count];
            break;
        }
        default:
            retVal = 0;
            break;
    }
    
    return retVal;
}

#pragma mark - Picker Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    
    switch (component)
    {
        case 0:
            title = [_familyNames objectAtIndex:row];
            break;
        case 1:
            title = [_styleNames objectAtIndex:row];
            break;
        default:
            title = nil;
            break;
    }
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {
            [self reloadStyleNamesForRow:row];
            [self reloadComponent1];
            [self reloadViewFontWithRow:0];
            break;
        }
        case 1:
        {
            [self reloadViewFontWithRow:row];
            break;
        }
        default:
            break;
    }
}

#pragma mark - FSAction sheet Delegate

- (void)actionSheet:(FSActionSheet *)sheet sliderValueChangedRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b
{
    if (_customTextView)
    {
        if ([sheet isTextMode])
        {
            _customTextView.textColor = RGBCOLOR(r, g, b);
        }
        else
        {
            _customTextView.backgroundColor = RGBCOLOR(r, g, b);
            if (_fontNameLabel) _fontNameLabel.backgroundColor = _customTextView.backgroundColor;
        }
    }
}

- (CGFloat)actionSheetNeedRedForP
{
    CIColor *color = nil;
    if (_customTextView)
    {
        color = [CIColor colorWithCGColor:_customTextView.backgroundColor.CGColor];
    }
    return color.red;
}

- (CGFloat)actionSheetNeedGreedForP
{
    CIColor *color = nil;
    if (_customTextView)
    {
        color = [CIColor colorWithCGColor:_customTextView.backgroundColor.CGColor];
    }
    return color.green;
}

- (CGFloat)actionSheetNeedBlueForP
{
    CIColor *color = nil;
    if (_customTextView)
    {
        color = [CIColor colorWithCGColor:_customTextView.backgroundColor.CGColor];
    }
    return color.blue;
}

- (CGFloat)actionSheetNeedRedForT
{
    CIColor *color = nil;
    if (_customTextView)
    {
        color = [CIColor colorWithCGColor:_customTextView.textColor.CGColor];
    }
    return color.red;
}

- (CGFloat)actionSheetNeedGreedForT
{
    CIColor *color = nil;
    if (_customTextView)
    {
        color = [CIColor colorWithCGColor:_customTextView.textColor.CGColor];
    }
    return color.green;
}

- (CGFloat)actionSheetNeedBlueForT
{
    CIColor *color = nil;
    if (_customTextView)
    {
        color = [CIColor colorWithCGColor:_customTextView.textColor.CGColor];
    }
    return color.blue;
}

@end
