//
//  EBKAvatarLabel.m
//  eBay Kleinanzeigen
//
//  Created by Calo, Ignazio on 14/10/2015.
//  Copyright © 2015 eBay Kleinanzeigen. All rights reserved.
//

#import "EBKAvatarView.h"
#import "Global.h"
#import <EBKUI/EBKUI-Swift.h>

@interface EBKAvatarView ()

@property (nonatomic) UIView *backgroundView;
@property (nonatomic) UILabel *label;
@property (nonatomic) UIImageView *avatarImageView;
@property (nonatomic, readonly) CGRect insetFrame;

@end

@implementation EBKAvatarView

- (void)setInitials:(NSString *)initials
{
    if (!initials) {
        return;
    }
    NSRange stringRange = {0, MIN([initials length], 2)};
    NSString *subString = [initials substringWithRange:stringRange];

    _initials = subString.uppercaseString;
    self.label.text = subString.uppercaseString;
    self.accessibilityLabel = subString.uppercaseString;
    self.avatarImageView.hidden = self.initials.length != 0 ? YES : NO;

    [self setNeedsLayout];
}

- (void)setInitialsFromName:(NSString *)name {

    [self setInitials:[InitialsExtractor calculateInitialsFromName:name]];
}

- (void)usePlusSign
{
    NSBundle *imageBundle = [NSBundle EBKUIBundleForImages];

    if (self.frame.size.width > 80) {
        self.image = [UIImage imageNamed:@"plus_sign_L" inBundle:imageBundle compatibleWithTraitCollection:nil];
    }
    else if (self.frame.size.width > 40) {
        self.image = [UIImage imageNamed:@"plus_sign_M" inBundle:imageBundle compatibleWithTraitCollection:nil];
    }
    else {
        self.image = [UIImage imageNamed:@"plus_sign_S" inBundle:imageBundle compatibleWithTraitCollection:nil];
    }

    self.initials = @"";
}
- (void)setTextColor:(UIColor *)textColor
{
    self.label.textColor = textColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.backgroundView.backgroundColor = backgroundColor;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.avatarImageView.image = image;
    self.avatarImageView.hidden = NO;
}

- (void)setUseSquare:(BOOL)useSquare
{
    _useSquare = useSquare;
    if (useSquare) {
        self.backgroundView.layer.cornerRadius = 0;
        self.avatarImageView.layer.cornerRadius = 0;
    }
    else {
        self.backgroundView.layer.cornerRadius = CGRectGetWidth(self.frame) / 2.0f;
        self.avatarImageView.layer.cornerRadius = CGRectGetWidth(self.frame) / 2.0f;
    }
}

- (void)setUseImageOnly:(BOOL)useImageOnly
{
    _useImageOnly = useImageOnly;
    if (_useImageOnly) {
        [self setUseSquare:YES];
    }

    self.label.hidden = useImageOnly;
    self.backgroundView.hidden = useImageOnly;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure
{
    _initials = @"";

    self.backgroundColor = [UIColor clearColor];
    _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    _backgroundView.backgroundColor = [UIColor ebkDarkGray];
    [self addSubview:_backgroundView];

    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    _label.adjustsFontSizeToFitWidth = YES;
    _label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    _label.numberOfLines = 1;
    _label.text = _initials;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor ebkWhite];
    [self addSubview:_label];

    _avatarImageView = [[UIImageView alloc] initWithFrame:self.insetFrame];
    _avatarImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_avatarImageView];
}

- (void)setContentMode:(UIViewContentMode)contentMode
{
    self.avatarImageView.contentMode = contentMode;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat radiusLength = CGRectGetWidth(self.frame) / 2.0f;
    CGFloat innerSquareRectLength = CGRectGetWidth(self.frame) / 2.0f * sqrt(2);

    self.backgroundView.frame = self.bounds;
    self.backgroundView.layer.cornerRadius = radiusLength;

    CGFloat x = (self.frame.size.width / 2.0f) - (innerSquareRectLength / 2.0f);
    CGFloat y = (self.frame.size.height / 2.0f) - (innerSquareRectLength / 2.0f);
    self.label.frame = CGRectIntegral(CGRectMake(x, y, innerSquareRectLength, innerSquareRectLength));

    if (self.useImageOnly) {
        self.avatarImageView.frame = self.backgroundView.frame;
    }
    else {
        self.avatarImageView.frame = self.label.frame;
    }

    [self updateLabelFont];
}

- (CGRect)insetFrame
{
    CGFloat padding = floorf(CGRectGetWidth(self.bounds) * 0.2f);
    return CGRectInset(self.bounds, padding, padding);
}

- (void)updateLabelFont
{
    if (!self.label.text.length) {
        return;
    }

    CGFloat pointsPerPixel = self.label.font.lineHeight / self.label.font.pointSize;
    CGFloat pointSize = self.label.frame.size.height * pointsPerPixel;
    CGFloat fontSize = self.label.text.length == 1 ? floorf(pointSize / 1.5) : floorf(pointSize / self.label.text.length);
    self.label.font = [UIFont systemFontOfSize:fontSize];
}

@end
