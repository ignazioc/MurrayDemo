//
//  EBKFormTextInputTableViewCell.m
//  eBay Kleinanzeigen
//
//  Created by Heimann, Paul on 18.09.12.
//  Copyright (c) 2012 eBay Kleinanzeigen. All rights reserved.
//

#import "EBKFormTextInputTableViewCell.h"
#import "EBKInputAccessoryView.h"

@implementation EBKFormTextInputTableViewCell

@synthesize accessoryBar = _accessoryBar; // Readonly

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupFormTextInputTableViewCell];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupFormTextInputTableViewCell];
}

- (void)setupFormTextInputTableViewCell
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Custom getters

- (EBKInputAccessoryView *)accessoryBar
{
    if (_accessoryBar == nil) {
        _accessoryBar = [[EBKInputAccessoryView alloc] init];

        __weak __typeof__(self) weakSelf = self;
        self.accessoryBar.doneButtonPressed = ^() {
            __typeof__(self) strongSelf = weakSelf;
            [strongSelf.textInputField resignFirstResponder];
        };
    }

    return _accessoryBar;
}

- (NSString *)text
{
    if ([self.textInputField respondsToSelector:@selector(text)]) {
        return [(id)self.textInputField text];
    }
    return nil;
}

@end
