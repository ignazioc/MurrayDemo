#import <Foundation/Foundation.h>
#import <EBKUI/EBKUI-Swift.h>
#import "Global.h"

@implementation NSBundle (LocalBundle)
// This code is also on Global.swift
+(NSBundle *)EBKUIBundleForImages {
    NSBundle *currentBundle = [NSBundle bundleForClass:EBKBaseButton.class];
    NSURL *subBundleURL = [currentBundle URLForResource:@"Images" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:subBundleURL];
    return imageBundle;
}
@end
