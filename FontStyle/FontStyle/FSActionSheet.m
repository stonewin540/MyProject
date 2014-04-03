//
//  FSActionSheet.m
//  FontStyle
//
//  Created by stone win on 12/26/12.
//  Copyright (c) 2012 stone win. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "FSActionSheet.h"

@interface FSActionSheet ()

@property (nonatomic, strong) UILabel *rLabel;
@property (nonatomic, strong) UISlider *rSlider;
@property (nonatomic, strong) UILabel *gLabel;
@property (nonatomic, strong) UISlider *gSlider;
@property (nonatomic, strong) UILabel *bLabel;
@property (nonatomic, strong) UISlider *bSlider;
@property (nonatomic, strong) UIButton *toggleButton;

@end

@implementation FSActionSheet
{
    CGRect _frame;
    CGFloat _rValue;
    CGFloat _gValue;
    CGFloat _bValue;
}

#pragma mark - Helpers

- (void)setValueLabelWithRed:(CGFloat)r greed:(CGFloat)g blue:(CGFloat)b
{
    _rValue = r;
    _gValue = g;
    _bValue = b;
    
    if (_rLabel) _rLabel.text = [NSString stringWithFormat:@"Red: %.f", r];
    if (_gLabel) _gLabel.text = [NSString stringWithFormat:@"Green: %.f", g];
    if (_bLabel) _bLabel.text = [NSString stringWithFormat:@"Blue: %.f", b];
}

- (BOOL)isTextMode
{
    if (!_toggleButton) return YES;
    if ([@"T" isEqualToString:_toggleButton.titleLabel.text])
    {
        return YES;
    }
    return NO;
}

#pragma mark - Setters

- (void)setSliderRed:(CGFloat)r greed:(CGFloat)g blue:(CGFloat)b
{
    r *= 255.f;
    g *= 255.f;
    b *= 255.f;
    
    if (_rSlider)
        _rSlider.value = r;
    if (_gSlider)
        _gSlider.value = g;
    if (_bSlider)
        _bSlider.value = b;
    [self setValueLabelWithRed:r
                         greed:g
                          blue:b];
}

#pragma mark - Actions

- (void)sliderChanged:(UISlider *)sender
{
    switch (sender.tag)
    {
        case 0:
        {
            _rValue = sender.value;
            break;
        }
        case 1:
        {
            _gValue = sender.value;
            break;
        }
        case 2:
        {
            _bValue = sender.value;
            break;
        }
        default:
            break;
    }
    [self setValueLabelWithRed:_rValue
                         greed:_gValue
                          blue:_bValue];
    if ([_delegate respondsToSelector:@selector(actionSheet:sliderValueChangedRed:green:blue:)])
    {
        [_delegate actionSheet:self
         sliderValueChangedRed:_rValue
                         green:_gValue
                          blue:_bValue];
    }
}

- (void)toggleButtonTapped:(UIButton *)sender
{
    CGFloat r, g, b;
    if ([self isTextMode])
    {
        [sender setTitle:@"P"
                forState:UIControlStateNormal];
        r = [_delegate actionSheetNeedRedForP];
        g = [_delegate actionSheetNeedGreedForP];
        b = [_delegate actionSheetNeedBlueForP];
    }
    else
    {
        [sender setTitle:@"T"
                forState:UIControlStateNormal];
        r = [_delegate actionSheetNeedRedForT];
        g = [_delegate actionSheetNeedGreedForT];
        b = [_delegate actionSheetNeedBlueForT];
    }
    [self setSliderRed:r
                 greed:g
                  blue:b];
}

#pragma mark - Customize

- (void)showInView:(UIView *)view
{
    if (!view) return;
    
    // Move self out of screen
    _frame = self.frame;
    _frame.origin.y = APPSIZE.height;
    self.frame = _frame;
    [view performSelectorOnMainThread:@selector(addSubview:)
                           withObject:self
                        waitUntilDone:YES];
    
    // Animation self to bottom of screen with self height
    _frame.origin.y -= CGRectGetHeight(_frame);
    [UIView animateWithDuration:DURATION_SYSTEM
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = _frame;
                     } completion:^(BOOL finished) {
                         if (finished)
                         {
                             
                         }
                     }];
}

- (void)dismiss
{
    if (!self.superview) return;
    
    // Animation self outof screen, and remove from super
    _frame = self.frame;
    _frame.origin.y = APPSIZE.height;
    [UIView animateWithDuration:DURATION_SYSTEM
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = _frame;
                     } completion:^(BOOL finished) {
                         if (finished)
                         {
                             [self performSelectorOnMainThread:@selector(removeFromSuperview)
                                                    withObject:nil
                                                 waitUntilDone:YES];
                         }
                     }];
}

#pragma mark - Lifecycle

- (void)setShadow
{
    CGPathRef path = CGPathCreateWithRect(self.bounds, &CGAffineTransformIdentity);
    self.layer.shadowOffset = CGSizeMake(0, -2);
    self.layer.shadowOpacity = .9f;
    self.layer.shadowPath = path;
    self.layer.shadowRadius = 2;
    CGPathRelease(path);
}

- (void)initSubviews
{
    /* --- Red section --- */
    // Red label
    _frame = CGRectMake(10, 10, 150, 20);
    
    _rLabel = [[UILabel alloc] initWithFrame:_frame];
    _rLabel.text = @"Red:";
    [self addSubview:_rLabel];
    
    // Red slider
    _frame.origin.y += 20;
    _frame.size.width = APPSIZE.width - 20;
    
    _rSlider = [[UISlider alloc] initWithFrame:_frame];
    _rSlider.minimumValue = 0;
    _rSlider.maximumValue = 255;
    _rSlider.minimumTrackTintColor = [UIColor redColor];
    _rSlider.maximumTrackTintColor = RGBACOLOR(255, 0, 0, .3f);
    _rSlider.value = 0;
    _rSlider.tag = 0;
    [_rSlider addTarget:self
                 action:@selector(sliderChanged:)
       forControlEvents:UIControlEventValueChanged];
    [self addSubview:_rSlider];
    /* --- end Red section --- */
    
    
    /* --- Green section --- */
    // Green label
    CGFloat offset = 2;
    _frame.origin.y += 20 + offset;
    _frame.size.width = CGRectGetWidth(_rLabel.bounds);
    
    _gLabel = [[UILabel alloc] initWithFrame:_frame];
    _gLabel.text = @"Green:";
    [self addSubview:_gLabel];
    
    // Green slider
    _frame.origin.y += 20;
    _frame.size.width = CGRectGetWidth(_rSlider.bounds);
    
    _gSlider = [[UISlider alloc] initWithFrame:_frame];
    _gSlider.minimumValue = 0;
    _gSlider.maximumValue = 255;
    _gSlider.minimumTrackTintColor = [UIColor greenColor];
    _gSlider.maximumTrackTintColor = RGBACOLOR(0, 255, 0, .3f);
    _gSlider.value = 0;
    _gSlider.tag = 1;
    [_gSlider addTarget:self
                 action:@selector(sliderChanged:)
       forControlEvents:UIControlEventValueChanged];
    [self addSubview:_gSlider];
    /* --- end Green section --- */
    
    
    /* --- Blue section --- */
    // Blue label
    _frame.origin.y += 20 + offset;
    _frame.size.width = CGRectGetWidth(_rLabel.bounds);
    
    _bLabel = [[UILabel alloc] initWithFrame:_frame];
    _bLabel.text = @"Blue:";
    [self addSubview:_bLabel];
    
    // Blue slider
    _frame.origin.y += 20;
    _frame.size.width = CGRectGetWidth(_rSlider.bounds);
    
    _bSlider = [[UISlider alloc] initWithFrame:_frame];
    _bSlider.minimumValue = 0;
    _bSlider.maximumValue = 255;
    _bSlider.minimumTrackTintColor = [UIColor blueColor];
    _bSlider.maximumTrackTintColor = RGBACOLOR(0, 0, 255, .3f);
    _bSlider.value = 0;
    _bSlider.tag = 2;
    [_bSlider addTarget:self
                 action:@selector(sliderChanged:)
       forControlEvents:UIControlEventValueChanged];
    [self addSubview:_bSlider];
    /* --- end Blue section --- */
    
    // Toggle button
    _frame.size = CGSizeMake(50, 50);
    _frame.origin = CGPointMake(self.bounds.size.width - 50, self.bounds.size.height - 50);
    
    _toggleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _toggleButton.frame = _frame;
    [_toggleButton setTitle:@"T"
                   forState:UIControlStateNormal];
    [_toggleButton addTarget:self
                      action:@selector(toggleButtonTapped:)
            forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_toggleButton];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setShadow];
        [self initSubviews];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
