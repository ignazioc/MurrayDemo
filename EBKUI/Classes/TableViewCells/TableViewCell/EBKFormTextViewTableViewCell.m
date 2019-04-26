//
//  EBKFormTextViewTableViewCell.m
//  eBay Kleinanzeigen
//
//  Created by Mark Armstrong on 8/30/12.
//  Copyright (c) 2012 eBay Kleinanzeigen. All rights reserved.
//

#import "EBKFormTextViewTableViewCell.h"
#import "EBKInputAccessoryView.h"
#import <EBKUI/EBKUI-Swift.h>

#define kFormTextViewTableCellDefaultPaddingTop 0.0
#define kFormTextViewTableCellDefaultPaddingLeft 11.0 // The textView itself adds 6 automatically

@implementation EBKFormTextViewTableViewCell

@dynamic textInputField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self formTextViewTableCellSetup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self formTextViewTableCellSetup];
}

- (void)formTextViewTableCellSetup
{
    if (!self.textInputField) {
        self.textInputField = [[EBKTextViewWithPlaceholder alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.textInputField];
    }

    self.textInputField.font = [UIFont ebk_font:EBKFontTypeNormal];
    self.textInputField.textColor = [UIColor ebkBlack];
    self.textInputField.delegate = self;
    self.textInputField.inputAccessoryView = self.accessoryBar;
    self.textViewInsets = UIEdgeInsetsMake(kFormTextViewTableCellDefaultPaddingTop, kFormTextViewTableCellDefaultPaddingLeft,
                                           kFormTextViewTableCellDefaultPaddingTop, kFormTextViewTableCellDefaultPaddingLeft);
}

#pragma mark - Enabling / Disabling

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    self.textInputField.editable = NO;
    if (enabled) {
        self.textInputField.textColor = [UIColor ebkBlack];
    }
    else {
        self.textInputField.textColor = [UIColor ebkDarkGray];
    }
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect textViewFrame;
    textViewFrame.origin = CGPointMake(self.textViewInsets.left, self.textViewInsets.top);
    textViewFrame.size.width = self.contentView.bounds.size.width - (self.textViewInsets.left + self.textViewInsets.right);
    textViewFrame.size.height = self.contentView.bounds.size.height - (self.textViewInsets.top + self.textViewInsets.bottom);
    self.textInputField.frame = textViewFrame;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.editingDidEndBlock) {
        self.editingDidEndBlock(self.textInputField.text);
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.textDidChangeBlock) {
        self.textDidChangeBlock(self.textInputField.text);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *newString = [self.textInputField.text stringByReplacingCharactersInRange:range withString:text];
    if (self.textShouldChangeBlock) {
        return self.textShouldChangeBlock(newString);
    }
    return YES;
}

- (CGPoint)popoverOffset
{
    return CGPointMake(0, 25);
}

- (BOOL)isFirstResponder
{
    return self.textInputField.isFirstResponder;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint touchLocation = [touch locationInView:self];
    if ([self pointInside:touchLocation withEvent:event]) {
        [self.textInputField becomeFirstResponder];
    }
}

#pragma mark - Accessibility

- (BOOL)isAccessibilityElement
{
    return NO;
}

- (NSInteger)accessibilityElementCount
{
    return 1;
}

- (id)accessibilityElementAtIndex:(NSInteger)index
{
    if (index == 0) {
        return self.textInputField;
    }
    return nil;
}

- (NSInteger)indexOfAccessibilityElement:(id)element
{
    if (element == self.textInputField) {
        return 0;
    }
    return NSNotFound;
}

@end
