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
@property (readwrite) NSInteger eventNum;
@property (nonatomic, strong) NSMutableArray *xFitArray;
@property (strong, nonatomic) IBOutlet DrawingClass *canv;

- (IBAction)showOverall:(id)sender;
- (IBAction)showEventOne:(id)sender;
- (IBAction)showEventTwo:(id)sender;
- (IBAction)showEventThree:(id)sender;
- (IBAction)showEventFour:(id)sender;
- (IBAction)showEventFive:(id)sender;
- (IBAction)showEventSix:(id)sender;

@end
