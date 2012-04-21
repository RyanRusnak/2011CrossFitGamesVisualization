//
//  ViewController.h
//  2011CrossfitViz
//
//  Created by Ryan Rusnak on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XFitData.h"
#import "sqlite3.h"
#import <CoreGraphics/CoreGraphics.h>
#import "DrawingClass.h"

@interface ViewController : UIViewController{
    
    sqlite3 *db;

}

@property (nonatomic, strong) NSMutableArray *xFitArray;
- (IBAction)parseCSV:(id)sender;
- (IBAction)showEventOne:(id)sender;

@property (strong, nonatomic) IBOutlet DrawingClass *canv;


@end
