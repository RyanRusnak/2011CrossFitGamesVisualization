//
//  Canvas.h
//  2011CrossfitViz
//
//  Created by Ryan Rusnak on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFitData.h"
#import <CoreGraphics/CoreGraphics.h>
#import "ViewController.h"

@interface CustomCanvas : UIView

@property (nonatomic, strong) NSMutableArray *xFitArray;
-(void) fillXFitArray:(NSMutableArray *) inXFit;
@end
