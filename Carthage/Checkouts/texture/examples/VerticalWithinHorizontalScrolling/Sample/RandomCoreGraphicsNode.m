//
//  RandomCoreGraphicsNode.m
//  Texture
//
//  Copyright (c) Facebook, Inc. and its affiliates.  All rights reserved.
//  Changes after 4/13/2017 are: Copyright (c) Pinterest, Inc.  All rights reserved.
//  Licensed under Apache 2.0: http://www.apache.org/licenses/LICENSE-2.0
//

#import "RandomCoreGraphicsNode.h"
#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>

@implementation RandomCoreGraphicsNode {
  ASTextNode *_indexPathTextNode;
}

+ (UIColor *)randomColor
{
  CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
  CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
  CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
  return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (void)drawRect:(CGRect)bounds withParameters:(id<NSObject>)parameters isCancelled:(NS_NOESCAPE asdisplaynode_iscancelled_block_t)isCancelledBlock isRasterizing:(BOOL)isRasterizing
{
  CGFloat locations[3];
  NSMutableArray *colors = [NSMutableArray arrayWithCapacity:3];
  [colors addObject:(id)[[RandomCoreGraphicsNode randomColor] CGColor]];
  locations[0] = 0.0;
  [colors addObject:(id)[[RandomCoreGraphicsNode randomColor] CGColor]];
  locations[1] = 1.0;
  [colors addObject:(id)[[RandomCoreGraphicsNode randomColor] CGColor]];
  locations[2] = ( arc4random() % 256 / 256.0 );

  
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locations);
  
  CGContextDrawLinearGradient(ctx, gradient, CGPointZero, CGPointMake(bounds.size.width, bounds.size.height), 0);
  
  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);
}

- (instancetype)initWithContent:(NSString *)content
{
  if (!(self = [super init])) {
    return nil;
  }
  
  _indexPathTextNode = [[ASTextNode alloc] init];
  _indexPathTextNode.attributedText = [[NSAttributedString alloc] initWithString:content attributes:nil];
  [self addSubnode:_indexPathTextNode];
  
  return self;
}

- (void)layout
{
  [super layout];
  
  _indexPathTextNode.frame = self.bounds;
}

#if 0
- (void)fetchData
{
  NSLog(@"fetchData - %@, %@", self, self.indexPath);
  [super fetchData];
}

- (void)clearFetchedData
{
  NSLog(@"clearFetchedData - %@, %@", self, self.indexPath);
  [super clearFetchedData];
}

- (void)visibilityDidChange:(BOOL)isVisible
{
  NSLog(@"visibilityDidChange:%d - %@, %@", isVisible, self, self.indexPath);
  [super visibilityDidChange:isVisible];
}
#endif

@end
