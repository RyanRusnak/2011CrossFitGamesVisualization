//
//  DrawingClass.h
//  2011CrossfitViz
//
//  Created by Ryan Rusnak on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFitData.h"

@interface DrawingClass : UIView
@property (nonatomic, strong) NSMutableArray *xFitArray;
@property (readwrite) NSInteger eventType;

-(void) fillXFitArray:(NSMutableArray *) inXFit;
-(void) whichEvent:(NSInteger) num;
@end
