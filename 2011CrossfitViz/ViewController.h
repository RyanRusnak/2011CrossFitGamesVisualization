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

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>{
    
    sqlite3 *db;

    CGRect overallButtonFrame;
    CGRect eventOneFrame;
    CGRect eventTwoFrame;
    CGRect eventThreeFrame;
    CGRect eventFourFrame;
    CGRect eventFiveFrame;
    CGRect eventSixFrame;
    CGRect buttonConstrainFrame;
    CGRect constrainIconFrame;
    CGRect weightLabelFrame;
    CGRect totalPointsLabelFrame;
    
    BOOL menuOpen;
}
@property (readwrite) NSInteger eventNum;
@property (nonatomic, strong) NSMutableArray *xFitArray;
@property (strong, nonatomic) IBOutlet DrawingClass *canv;
@property (readwrite) NSInteger currentHeight;

- (IBAction)showOverall:(id)sender;
- (IBAction)showEventOne:(id)sender;
- (IBAction)showEventTwo:(id)sender;
- (IBAction)showEventThree:(id)sender;
- (IBAction)showEventFour:(id)sender;
- (IBAction)showEventFive:(id)sender;
- (IBAction)showEventSix:(id)sender;
- (IBAction)constrainByHeight:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *overallButton;
@property (strong, nonatomic) IBOutlet UIButton *buttonEventOne;
@property (strong, nonatomic) IBOutlet UIButton *buttonEventTwo;
@property (strong, nonatomic) IBOutlet UIButton *buttonEventThree;
@property (strong, nonatomic) IBOutlet UIButton *buttonEventFour;
@property (strong, nonatomic) IBOutlet UIButton *buttonEventFive;
@property (strong, nonatomic) IBOutlet UIButton *buttonEventSix;
@property (strong, nonatomic) IBOutlet UIButton *buttonConstrain;

@property (strong, nonatomic) IBOutlet UILabel *titleText;
@property (strong, nonatomic) IBOutlet UILabel *workoutLabel;
@property (strong, nonatomic) IBOutlet UIImageView *constrainIcon;
@property (strong, nonatomic) NSString *column;
@property (strong, nonatomic) IBOutlet UILabel *heightLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalPointsLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;

- (IBAction)swipeClosedMenu:(UISwipeGestureRecognizer*)sender;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeftGesture;

- (IBAction)swipedMenu:(UISwipeGestureRecognizer*)sender;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGesture;

- (IBAction)userPinched:(UIPinchGestureRecognizer*)sender;
@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGesture;





@end
