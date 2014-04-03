//
//  FSActionSheet.h
//  FontStyle
//
//  Created by stone win on 12/26/12.
//  Copyright (c) 2012 stone win. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FSActionSheetDelegate;

@interface FSActionSheet : UIView

@property (nonatomic, assign) id<FSActionSheetDelegate> delegate;

- (void)showInView:(UIView *)view;
- (void)dismiss;
- (void)setSliderRed:(CGFloat)r greed:(CGFloat)g blue:(CGFloat)b;
- (BOOL)isTextMode;

@end

@protocol FSActionSheetDelegate <NSObject>

@optional
- (void)actionSheet:(FSActionSheet *)sheet sliderValueChangedRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b;
- (CGFloat)actionSheetNeedRedForP;
- (CGFloat)actionSheetNeedGreedForP;
- (CGFloat)actionSheetNeedBlueForP;
- (CGFloat)actionSheetNeedRedForT;
- (CGFloat)actionSheetNeedGreedForT;
- (CGFloat)actionSheetNeedBlueForT;

@end
