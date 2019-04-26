//
//  EBKAvatarLabel.h
//  eBay Kleinanzeigen
//
//  Created by Calo, Ignazio on 14/10/2015.
//  Copyright © 2015 eBay Kleinanzeigen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBKAvatarView : UIView

@property (nonatomic) NSString *initials;
@property (nonatomic) BOOL useSquare;
@property (nonatomic) BOOL useImageOnly;
@property (nonatomic) UIImage *image;

- (void)setTextColor:(UIColor *)textColor;
- (void)usePlusSign;
- (void)setInitialsFromName:(NSString *)name;
@end
