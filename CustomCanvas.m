//
//  Canvas.m
//  2011CrossfitViz
//
//  Created by Ryan Rusnak on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomCanvas.h"

@implementation CustomCanvas

@synthesize xFitArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        xFitArray = [[NSMutableArray alloc] init];
        // Initialization code
    }
    return self;
}

-(void) fillXFitArray:(NSMutableArray *) inXFit
{
    self.xFitArray = inXFit;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //XFitData *myXFitData = [[XFitData alloc]init];
    NSLog(@"Pre Drawing...");
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillPath(context);
    CGRect rectangle = CGRectMake(100,170,20,20);
    CGContextAddEllipseInRect(context, rectangle);
    
    for (XFitData *xfitdata in xFitArray){
        NSLog(@"Drawing...");
        CGRect rectangle = CGRectMake(xfitdata.weight,170,20,20);
        CGContextAddEllipseInRect(context, rectangle);
    }
}


@end
