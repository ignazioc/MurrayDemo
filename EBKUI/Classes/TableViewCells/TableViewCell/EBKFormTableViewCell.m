//
//  EBKFormTableViewCell.m
//  eBay Kleinanzeigen
//
//  Created by Hoefele, Claus(choefele) on 28.08.12.
//  Copyright (c) 2012 eBay Kleinanzeigen. All rights reserved.
//

#import "EBKFormTableViewCell.h"
#import "EBKOverlayView.h"
#import "EBKTransparentInterceptorBackgroundView.h"
#import <EBKUI/EBKUI-Swift.h>

#define ERROR_POPOVER_MARGIN 5

@interface EBKFormTableViewCell ()

@property (nonatomic, strong) EBKOverlayView *errorPopoverView;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, assign) BOOL displaysOverlay;
@property (nonatomic) BOOL hasError;

@end

@implementation EBKFormTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpFormTableViewCell];
}

- (BOOL)isAccessibilityElement
{
    return YES;
}

- (NSString *)accessibilityLabel
{
    return self.textLabel.text;
}

- (NSString *)accessibilityValue
{
    return self.detailTextLabel.text;
}

- (UIAccessibilityTraits)accessibilityTraits
{
    return (self.accessoryType == UITableViewCellAccessoryNone) ? UIAccessibilityTraitNone : UIAccessibilityTraitButton;
}

- (void)setUpFormTableViewCell
{
    self.accessoryType = self.accessoryType; // To set image
    self.textLabel.font = [UIFont ebk_font:EBKFontTypeNormal];
    self.textLabel.textColor = [UIColor ebkBlack];
    self.textLabel.highlightedTextColor = [UIColor ebkBlack];
    self.detailTextLabel.font = [UIFont ebk_font:EBKFontTypeNormal];
    self.detailTextLabel.textColor = [UIColor ebkDarkGray];
    self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
}

- (void)prepareForReuse
{
    [super prepareForReuse];

    self.displaysOverlay = NO;
    self.backgroundColor = [UIColor ebkWhite];
    self.detailTextLabel.text = @" ";
    self.textLabel.text = @"";
    self.accessoryView = nil;
}

#pragma mark - Display Error State in Cell

- (void)showErrorString:(NSString *)errorString
{
    if (errorString) {
        self.hasError = YES;
        self.displaysOverlay = YES;
        [self showOverlayWithMessage:errorString];
        self.backgroundColor = [UIColor colorWithRed:253.0f / 255.0f green:231.0f / 255.0f blue:192.0f / 255.0f alpha:1.0f];
    }
    else {
        self.hasError = NO;
        self.displaysOverlay = NO;
        [self hideOverlay];
        self.backgroundColor = [UIColor ebkWhite];
    }
}

- (void)showError:(NSError *)error
{
    [self showErrorString:error.localizedDescription];
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];

    if (self.displaysOverlay && self.errorPopoverView.superview == nil) { // Mainly a fix for iOS 5 where the cell does not have a superview early enough
        [self.errorPopoverView attachToView:self.superview];
    }

    [self.superview bringSubviewToFront:self.errorPopoverView];
}

- (void)showOverlayWithMessage:(NSString *)message
{
    if (!self.errorPopoverView) {
        self.errorPopoverView = [[EBKOverlayView alloc] initWithOrigin:[self popoverOrigin]];
        self.errorPopoverView.arrowPosition = OverlayArrowPositionTopLeft;
        self.errorPopoverView.userInteractionEnabled = NO;
        self.errorPopoverView.edgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        self.errorPopoverView.backgroundView = [[EBKTransparentInterceptorBackgroundView alloc] initWithFrame:self.frame];

        self.errorLabel = [[UILabel alloc] init];
        self.errorLabel.font = [UIFont ebk_font:EBKFontTypeNormal];
        [self.errorPopoverView addSubview:self.errorLabel];
    }

    self.errorLabel.text = message;
    self.errorLabel.textColor = [UIColor ebkBlack];
    [self.errorLabel sizeToFit];
    [self.errorPopoverView setNeedsLayout];
    [self.errorPopoverView setNeedsDisplay];

    [self.errorPopoverView attachToView:self.superview];
}

- (BOOL)isFirstResponder
{
    return false;
}

- (void)hideOverlay
{
    [self.errorPopoverView detach];
}

- (CGPoint)popoverOffset // Can be overwritten by subclasses to reallign popover
{
    return CGPointMake(0, 28);
}

- (CGPoint)popoverOrigin
{
    return CGPointMake(self.frame.origin.x + ERROR_POPOVER_MARGIN * 2 + [self popoverOffset].x + self.safeAreaInsets.left,
                       self.frame.origin.y + [self popoverOffset].y);
}

#pragma mark - View States

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.errorPopoverView.origin = [self popoverOrigin];
    self.errorPopoverView.backgroundView.frame = self.frame;

    if (self.detailLabelX > 0) {
        CGFloat width = self.frame.size.width - self.detailLabelX - 45;
        self.detailTextLabel.frame = CGRectMake(self.detailLabelX, self.detailTextLabel.frame.origin.y, width, self.detailTextLabel.frame.size.height);
    }
}

@end
