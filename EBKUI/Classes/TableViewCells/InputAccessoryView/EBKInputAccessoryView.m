//
//  EBKInputAccessoryView.m
//  eBay Kleinanzeigen
//
//  Created by Heimann, Paul on 18.09.12.
//  Copyright (c) 2012 eBay Kleinanzeigen. All rights reserved.
//

#import "EBKInputAccessoryView.h"
#import <EBKUI/EBKUI-Swift.h>

@interface EBKInputAccessoryView ()

@property (nonatomic, strong) UIBarButtonItem *doneItem;

@end

@implementation EBKInputAccessoryView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)];
    if (self) {
        self.backgroundColor = [UIColor ebkGreen];
        self.barTintColor = [UIColor ebkGreen];
        self.tintColor = [UIColor whiteColor];

        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        _doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed)];
        [_doneItem setTintColor:[UIColor ebkWhite]];
        self.items = @[ flexItem, _doneItem ];
    }

    return self;
}

- (void)donePressed
{
    if (self.doneButtonPressed) {
        self.doneButtonPressed();
    }
}

@end
