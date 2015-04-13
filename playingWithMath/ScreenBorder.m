//
//  ScreenBorder.m
//  playingWithMath
//
//  Created by Nelly Santoso on 4/9/15.
//  Copyright (c) 2015 Nelly Santoso. All rights reserved.
//

#import "ScreenBorder.h"

@implementation ScreenBorder


- (void)drawRect:(CGRect)rect {
    CGContextRef bodyContext = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(bodyContext);

    CGContextMoveToPoint(bodyContext, 10, 10);
    CGContextAddLineToPoint(bodyContext, 0, 100);
    CGContextClosePath(bodyContext);
    CGContextFillPath(bodyContext);
    CGContextRestoreGState(bodyContext);
    CGContextSetStrokeColorWithColor(bodyContext, [UIColor brownColor].CGColor);
    CGContextSetLineWidth(bodyContext, 8);
    CGContextStrokePath(bodyContext);
}


@end
