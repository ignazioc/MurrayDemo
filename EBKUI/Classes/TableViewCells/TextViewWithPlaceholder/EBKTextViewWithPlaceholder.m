//
//  EBKTextViewWithPlaceholder.m
//  eBay Kleinanzeigen
//
//  Created by Mark Armstrong on 8/28/12.
//  Copyright (c) 2012 eBay Kleinanzeigen. All rights reserved.
//

#import "EBKTextViewWithPlaceholder.h"

#define kPlaceholderTextColor UIColor.grayColor
#define kMarginLeft 5 // This appears to be the default value for UITextView margins although it doesn't appear to be accesible and could potentially change
#define kMarginTop 8  // This appears to be the default value for UITextView margins although it doesn't appear to be accesible and could potentially change

@interface EBKTextViewWithPlaceholder ()

@property (nonatomic, assign) BOOL setupComplete;
@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation EBKTextViewWithPlaceholder

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupTextViewWithPlaceholder];
    }
    return self;
}

- (void)setupTextViewWithPlaceholder
{
    if (!self.setupComplete) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:nil];
        self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.placeholderLabel.font = self.font;
        self.placeholderLabel.textColor = kPlaceholderTextColor;
        self.placeholderLabel.backgroundColor = [UIColor clearColor];
        self.placeholderLabel.alpha = 0.65;
        self.placeholderLabel.numberOfLines = 0;

        self.backgroundColor = [UIColor clearColor];

        self.setupComplete = YES;
    }
    self.placeholderLabel.frame = CGRectMake(kMarginLeft, kMarginTop, 0, 0);
    [self textChanged];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if (self.text.length < 1) {
        [self showPlaceholder];
    }
    else if (self.placeholderLabel.superview) {
        [self hidePlaceholder];
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    [self setNeedsLayout];
    [self textChanged];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect rect = CGRectMake(self.placeholderLabel.frame.origin.x, self.placeholderLabel.frame.origin.y, 0, 0);
    CGSize size = CGSizeMake(self.frame.size.width - self.placeholderLabel.frame.origin.x, self.frame.size.height - self.placeholderLabel.frame.origin.y);
    rect.size = [self.placeholderLabel sizeThatFits:size];
    self.placeholderLabel.frame = rect;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
}

- (void)textChanged
{
    if (self.text.length < 1) {
        [self showPlaceholder];
    }
    else if (self.placeholderLabel.superview) {
        [self hidePlaceholder];
    }
}

- (void)showPlaceholder
{
    if (!self.placeholderLabel.superview) {
        [self.textInputView addSubview:self.placeholderLabel];
        [self sendSubviewToBack:self.placeholderLabel];
    }
    self.placeholderLabel.hidden = NO;
}

- (void)hidePlaceholder
{
    if (self.placeholderLabel.superview) {
        [self.placeholderLabel removeFromSuperview];
    }
    self.placeholderLabel.hidden = YES;
}

- (BOOL)isPlaceholderHidden
{
    return self.placeholderLabel.hidden;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
