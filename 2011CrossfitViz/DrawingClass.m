//
//  DrawingClass.m
//  2011CrossfitViz
//
//  Created by Ryan Rusnak on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrawingClass.h"

@implementation DrawingClass
@synthesize xFitArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [xFitArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetAlpha(context, .5);
        
        CGRect r = CGRectMake((((XFitData *)obj).weight*5)-320,-1*(((XFitData *)obj).event/100)+720,5,5);
        
        if ([((XFitData *)obj).gender isEqualToString:@"M"]){
            CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
            CGContextFillPath(context);
        } else{
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            CGContextFillPath(context);
        }
        CGContextAddEllipseInRect(context, r);
        
    }];
    
    
    
//    for (XFitData *xfitdata in xFitArray){
//        
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGContextSetAlpha(context, .5);
//        
//        CGRect r = CGRectMake((xfitdata.weight*5)-320,-1*(xfitdata.event/100)+720,5,5);
//        
//        if ([xfitdata.gender isEqualToString:@"M"]){
//            CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
//            CGContextFillPath(context);
//        } else{
//            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
//            CGContextFillPath(context);
//        }
//       CGContextAddEllipseInRect(context, r);
//
//    }
}



-(void) fillXFitArray:(NSMutableArray *) inXFit
{
    self.xFitArray = inXFit;
}

@end
