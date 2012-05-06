//
//  ViewController.m
//  2011CrossfitViz
//
//  Created by Ryan Rusnak on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//#define CELL_HEIGHT 20;
//#define CELL_RANK   15;

#import "ViewController.h"

@implementation ViewController
@synthesize pinchGesture;
@synthesize swipeLeftGesture;
@synthesize buttonEventOne;
@synthesize buttonEventTwo;
@synthesize buttonEventThree;
@synthesize buttonEventFour;
@synthesize buttonEventFive;
@synthesize buttonEventSix;
@synthesize buttonConstrain;
@synthesize overallButton;
@synthesize swipeGesture;
@synthesize titleText;
@synthesize workoutLabel;
@synthesize constrainIcon;
@synthesize canv;
@synthesize column;
@synthesize heightLabel;
@synthesize totalPointsLabel;
@synthesize weightLabel;

@synthesize xFitArray;
@synthesize eventNum;
@synthesize currentHeight;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.canv.xFitArray = [[NSMutableArray alloc]init];
	// Do any additional setup after loading the view, typically from a nib.
    xFitArray = [[NSMutableArray alloc] init];
    [buttonEventThree setEnabled:FALSE];
    
    overallButtonFrame = overallButton.frame;
    eventOneFrame = buttonEventOne.frame;
    eventTwoFrame = buttonEventTwo.frame;
    eventThreeFrame = buttonEventThree.frame;
    eventFourFrame = buttonEventFour.frame;
    eventFiveFrame = buttonEventFive.frame;
    eventSixFrame = buttonEventSix.frame;
    buttonConstrainFrame = buttonConstrain.frame;
    constrainIconFrame = constrainIcon.frame;
    weightLabelFrame = weightLabel.frame;
    totalPointsLabelFrame = totalPointsLabel.frame;
    
    [constrainIcon setHidden:YES];
    
    weightLabelFrame.origin = CGPointMake(weightLabelFrame.origin.x, weightLabelFrame.origin.y+20);
    weightLabel.frame = weightLabelFrame;
    totalPointsLabelFrame.origin = CGPointMake(totalPointsLabelFrame.origin.x+100, totalPointsLabelFrame.origin.y);
    totalPointsLabel.frame = totalPointsLabelFrame;
    
    currentHeight = 60;
    
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    //[self setCustomCanv:nil];
    [self setCanv:nil];
    [self setTitleText:nil];
    [self setSwipeGesture:nil];
    [self setOverallButton:nil];
    [self setButtonEventOne:nil];
    [self setButtonEventTwo:nil];
    [self setButtonEventThree:nil];
    [self setButtonEventFour:nil];
    [self setButtonEventFive:nil];
    [self setButtonEventSix:nil];
    [self setSwipeLeftGesture:nil];
    [self setWorkoutLabel:nil];
    [self setButtonConstrain:nil];
    [self setConstrainIcon:nil];
    [self setPinchGesture:nil];
    [self setHeightLabel:nil];
    [self setTotalPointsLabel:nil];
    [self setWeightLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return
    UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)showOverall:(id)sender {
    
    //NSMutableArray *xFitArray = [[NSMutableArray alloc] init];
    @try {
        eventNum = 0;
        workoutLabel.text = @"";
        titleText.text = @"Overall Points";
        [self.canv whichEvent:eventNum];
        [xFitArray removeAllObjects];
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:@"xfit2011SQL.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Cannot locate database file '%@'.", dbPath);
        }
        if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
        {
            NSLog(@"An error has occured.");
        }
        const char *sql = "SELECT ID, Name, weight, height, overall_points, gender FROM  xfit2011";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            XFitData *myXFitData = [[XFitData alloc] init];
            
            myXFitData.ident = sqlite3_column_int(sqlStatement, 0);
            myXFitData.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
            myXFitData.height = sqlite3_column_int(sqlStatement, 3);
            myXFitData.weight = sqlite3_column_int(sqlStatement, 2);
            myXFitData.event = sqlite3_column_int(sqlStatement, 4);
            myXFitData.gender = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,5)];
            [xFitArray addObject:myXFitData];
            //NSLog(@"Gender is:%@", myXFitData.gender);
        }
        [self.canv fillXFitArray:xFitArray];
        [self.view setNeedsDisplay];
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        //return xFitArray;
    } 
    
}

- (IBAction)showEventOne:(id)sender {
    
    @try {
        eventNum = 1;
        titleText.text = @"Event One 2011";
        workoutLabel.text = @"10 minute AMRAP:\n 30 Double-unders\n 15 Power snatches";
        [self.canv whichEvent:eventNum];
        [xFitArray removeAllObjects];
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:@"xfit2011SQL.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Cannot locate database file '%@'.", dbPath);
        }
        if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
        {
            NSLog(@"An error has occured.");
        }
        const char *sql = "SELECT ID, Name, weight, height, score1, gender FROM  xfit2011";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            XFitData *myXFitData = [[XFitData alloc] init];
            
            myXFitData.ident = sqlite3_column_int(sqlStatement, 0);
            myXFitData.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
            myXFitData.height = sqlite3_column_int(sqlStatement, 3);
            myXFitData.weight = sqlite3_column_int(sqlStatement, 2);
            myXFitData.event = sqlite3_column_int(sqlStatement, 4);
            myXFitData.gender = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,5)];
            [xFitArray addObject:myXFitData];
        }
        [self.canv fillXFitArray:xFitArray];
        [self.view setNeedsDisplay];
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        //return xFitArray;
    } 
    
}

- (IBAction)showEventTwo:(id)sender {
    
    @try {
        eventNum = 2;
        titleText.text = @"Event Two 2011";
        workoutLabel.text = @"15 minute AMRAP:\n 9 Deadlifts (155lbs / 70kg)\n 12 Push-ups\n 15 Box jumps (24 inch)";
        [self.canv whichEvent:eventNum];
        [xFitArray removeAllObjects];
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:@"xfit2011SQL.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Cannot locate database file '%@'.", dbPath);
        }
        if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
        {
            NSLog(@"An error has occured.");
        }
        const char *sql = "SELECT ID, Name, weight, height, score2, gender FROM  xfit2011";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            XFitData *myXFitData = [[XFitData alloc] init];
            
            myXFitData.ident = sqlite3_column_int(sqlStatement, 0);
            myXFitData.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
            myXFitData.height = sqlite3_column_int(sqlStatement, 3);
            myXFitData.weight = sqlite3_column_int(sqlStatement, 2);
            myXFitData.event = sqlite3_column_int(sqlStatement, 4);
            myXFitData.gender = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,5)];
            [xFitArray addObject:myXFitData];
        }
        [self.canv fillXFitArray:xFitArray];
        [self.view setNeedsDisplay];
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        //return xFitArray;
    } 
}

- (IBAction)showEventThree:(id)sender {
    @try {
        eventNum = 3;
        titleText.text = @"Event Three 2011";
        workoutLabel.text = @"5 minute AMRAP:\n 165 pound Squat clean\n 165 pound Jerk";
        [self.canv whichEvent:eventNum];
        [xFitArray removeAllObjects];
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:@"xfit2011SQL.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Cannot locate database file.");
        }
        if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
        {
            NSLog(@"An error has occured.");
        }
        const char *sql = "SELECT ID, Name, weight, height, score3, gender FROM  xfit2011";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            XFitData *myXFitData = [[XFitData alloc] init];
            
            myXFitData.ident = sqlite3_column_int(sqlStatement, 0);
            myXFitData.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
            myXFitData.height = sqlite3_column_int(sqlStatement, 3);
            myXFitData.weight = sqlite3_column_int(sqlStatement, 2);
            myXFitData.event = sqlite3_column_int(sqlStatement, 4);
            myXFitData.gender = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,5)];
            [xFitArray addObject:myXFitData];
        }
        [self.canv fillXFitArray:xFitArray];
        [self.view setNeedsDisplay];
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        //return xFitArray;
    } 
}
- (IBAction)showEventFour:(id)sender {
    @try {
        eventNum = 4;
        titleText.text = @"Event Four 2011";
        workoutLabel.text = @"10 minute AMRAP:\n 60 Bar-facing burpees\n 120 pound Overhead squat 30 reps\n 10 Muscle-ups";
        [self.canv whichEvent:eventNum];
        [xFitArray removeAllObjects];
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:@"xfit2011SQL.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Cannot locate database file '%@'.", dbPath);
        }
        if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
        {
            NSLog(@"An error has occured.");
        }
        const char *sql = "SELECT ID, Name, weight, height, score4, gender FROM  xfit2011";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            XFitData *myXFitData = [[XFitData alloc] init];
            
            myXFitData.ident = sqlite3_column_int(sqlStatement, 0);
            myXFitData.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
            myXFitData.height = sqlite3_column_int(sqlStatement, 3);
            myXFitData.weight = sqlite3_column_int(sqlStatement, 2);
            myXFitData.event = sqlite3_column_int(sqlStatement, 4);
            myXFitData.gender = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,5)];
            [xFitArray addObject:myXFitData];
        }
        [self.canv fillXFitArray:xFitArray];
        [self.view setNeedsDisplay];
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        //return xFitArray;
    } 
}

- (IBAction)showEventFive:(id)sender {
    @try {
        eventNum = 5;
        titleText.text = @"Event Five 2011";
        workoutLabel.text = @"20 minute AMRAP:\n 5 Power cleans (145lbs / 65kg)\n 10 Toes to bar\n 15 Wall balls (20lbs to 10' target) ";
        [self.canv whichEvent:eventNum];
        [xFitArray removeAllObjects];
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:@"xfit2011SQL.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Cannot locate database file '%@'.", dbPath);
        }
        if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
        {
            NSLog(@"An error has occured.");
        }
        const char *sql = "SELECT ID, Name, weight, height, score5, gender FROM  xfit2011";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            XFitData *myXFitData = [[XFitData alloc] init];
            
            myXFitData.ident = sqlite3_column_int(sqlStatement, 0);
            myXFitData.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
            myXFitData.height = sqlite3_column_int(sqlStatement, 3);
            myXFitData.weight = sqlite3_column_int(sqlStatement, 2);
            myXFitData.event = sqlite3_column_int(sqlStatement, 4);
            myXFitData.gender = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,5)];
            [xFitArray addObject:myXFitData];
        }
        [self.canv fillXFitArray:xFitArray];
        [self.view setNeedsDisplay];
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        //return xFitArray;
    } 
}

- (IBAction)showEventSix:(id)sender {
    @try {
        eventNum = 6;
        titleText.text = @"Event Six 2011";
        workoutLabel.text = @"7 minute AMRAP:\n 3 Barbell Thrusters\n 3 Chest to bar Pull-ups\n 6 Barbell Thrusters\n 6 Chest to bar Pull-ups\n 9 Barbell Thrusters\n 9 Chest to bar Pull-ups\n 12 Barbell Thrusters\n 12 Chest to bar Pull-ups\n 15 Barbell Thrusters\n 15 Chest to bar Pull-ups\n 18 Barbell Thrusters\n 18 Chest to bar Pull-ups\n 21 Barbell Thrusters\n 21 Chest to bar Pull-ups, etc";
        [self.canv whichEvent:eventNum];
        [xFitArray removeAllObjects];
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:@"xfit2011SQL.sqlite"];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            NSLog(@"Cannot locate database file '%@'.", dbPath);
        }
        if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
        {
            NSLog(@"An error has occured.");
        }
        const char *sql = "SELECT ID, Name, weight, height, score6, gender FROM  xfit2011";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            XFitData *myXFitData = [[XFitData alloc] init];
            
            myXFitData.ident = sqlite3_column_int(sqlStatement, 0);
            myXFitData.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
            myXFitData.height = sqlite3_column_int(sqlStatement, 3);
            myXFitData.weight = sqlite3_column_int(sqlStatement, 2);
            myXFitData.event = sqlite3_column_int(sqlStatement, 4);
            myXFitData.gender = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,5)];
            [xFitArray addObject:myXFitData];
        }
        [self.canv fillXFitArray:xFitArray];
        [self.view setNeedsDisplay];
        
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        //return xFitArray;
    } 
}

- (IBAction)constrainByHeight:(id)sender {
    
    if (constrainIcon.hidden == YES)
    {
    [constrainIcon setHidden:NO];
    [heightLabel setHidden:NO];
    }else
    {
        [constrainIcon setHidden:YES];
        [heightLabel setHidden:YES];
    }
}

- (IBAction)swipeClosedMenu:(UISwipeGestureRecognizer*)sender {
    
    if (menuOpen == TRUE){
        CGPoint touch = [sender locationOfTouch:0 inView:self.canv];
        if(touch.x < 250){
        [buttonEventThree setEnabled:FALSE];
        [UIView animateWithDuration:0.4
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut
                         animations:^(void){
                             overallButtonFrame.origin = CGPointMake(overallButtonFrame.origin.x-150, overallButtonFrame.origin.y);
                             overallButton.frame = overallButtonFrame;
                             
                             eventOneFrame.origin = CGPointMake(eventOneFrame.origin.x-150, eventOneFrame.origin.y);
                             buttonEventOne.frame = eventOneFrame;
                             
                             eventTwoFrame.origin = CGPointMake(eventTwoFrame.origin.x-150, eventTwoFrame.origin.y);
                             buttonEventTwo.frame = eventTwoFrame;
                             
                             eventThreeFrame.origin = CGPointMake(eventThreeFrame.origin.x-128, eventThreeFrame.origin.y);
                             buttonEventThree.frame = eventThreeFrame;
                             
                             eventFourFrame.origin = CGPointMake(eventFourFrame.origin.x-150, eventFourFrame.origin.y);
                             buttonEventFour.frame = eventFourFrame;
                             
                             eventFiveFrame.origin = CGPointMake(eventFiveFrame.origin.x-150, eventFiveFrame.origin.y);
                             buttonEventFive.frame = eventFiveFrame;
                             
                             eventSixFrame.origin = CGPointMake(eventSixFrame.origin.x-150, eventSixFrame.origin.y);
                             buttonEventSix.frame = eventSixFrame;
                             
                             buttonConstrainFrame.origin = CGPointMake(buttonConstrainFrame.origin.x-150, buttonConstrainFrame.origin.y);
                             buttonConstrain.frame = buttonConstrainFrame;
                             
                             weightLabelFrame.origin = CGPointMake(weightLabelFrame.origin.x, weightLabelFrame.origin.y+20);
                             weightLabel.frame = weightLabelFrame;
                             totalPointsLabelFrame.origin = CGPointMake(totalPointsLabelFrame.origin.x+50, totalPointsLabelFrame.origin.y);
                             totalPointsLabel.frame = totalPointsLabelFrame;
                         }
                         completion:^(BOOL finished){
                         }];
    
    menuOpen = FALSE;
    }
}
}


- (IBAction)swipedMenu:(UISwipeGestureRecognizer*)sender {
    
    if(menuOpen == FALSE){
        CGPoint touch = [sender locationOfTouch:0 inView:self.canv];
        if(touch.x < 250){
        [buttonEventThree setEnabled:TRUE];
        [UIView animateWithDuration:0.4
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut
                         animations:^(void){
                             overallButtonFrame.origin = CGPointMake(overallButtonFrame.origin.x+150, overallButtonFrame.origin.y);
                             overallButton.frame = overallButtonFrame;
                             
                             eventOneFrame.origin = CGPointMake(eventOneFrame.origin.x+150, eventOneFrame.origin.y);
                             buttonEventOne.frame = eventOneFrame;
                             
                             eventTwoFrame.origin = CGPointMake(eventTwoFrame.origin.x+150, eventTwoFrame.origin.y);
                             buttonEventTwo.frame = eventTwoFrame;
                             
                             eventThreeFrame.origin = CGPointMake(eventThreeFrame.origin.x+128, eventThreeFrame.origin.y);
                             buttonEventThree.frame = eventThreeFrame;
                             
                             eventFourFrame.origin = CGPointMake(eventFourFrame.origin.x+150, eventFourFrame.origin.y);
                             buttonEventFour.frame = eventFourFrame;
                             
                             eventFiveFrame.origin = CGPointMake(eventFiveFrame.origin.x+150, eventFiveFrame.origin.y);
                             buttonEventFive.frame = eventFiveFrame;
                             
                             eventSixFrame.origin = CGPointMake(eventSixFrame.origin.x+150, eventSixFrame.origin.y);
                             buttonEventSix.frame = eventSixFrame;
                             
                             buttonConstrainFrame.origin = CGPointMake(buttonConstrainFrame.origin.x+150, buttonConstrainFrame.origin.y);
                             buttonConstrain.frame = buttonConstrainFrame;
                             
                             weightLabelFrame.origin = CGPointMake(weightLabelFrame.origin.x, weightLabelFrame.origin.y-20);
                             weightLabel.frame = weightLabelFrame;
                             totalPointsLabelFrame.origin = CGPointMake(totalPointsLabelFrame.origin.x-50, totalPointsLabelFrame.origin.y);
                             totalPointsLabel.frame = totalPointsLabelFrame;
                         }
                         completion:^(BOOL finished){
                         }];
    
    menuOpen = TRUE;
    }
    }
}
- (IBAction)userPinched:(UIPinchGestureRecognizer*)sender {
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        currentHeight *= sender.scale;
        if (currentHeight > 81) currentHeight = 81;
        else if (currentHeight < 54) currentHeight = 54;
        NSLog(@"Pinch Ended!");
    }
    else if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Pinch started!");
    }
    
    
    if (constrainIcon.hidden == NO){
        CGPoint touch = [sender locationOfTouch:0 inView:self.canv];
        if(touch.x > 900){
            
            int realheight = currentHeight*sender.scale;
//            currentHeight*=sender.scale;
            
            //CGFloat scale = [(UIPinchGestureRecognizer *)sender scale];
//            int heightConstraint = 80 *(sender.scale/1.5);
//            if (heightConstraint < 54 || heightConstraint > 81){
//                
//                return;
//            }

            
//            if (sender.scale < 0.8 || sender.scale > 1.4) {
//                return;
//            }  
//            if (sender.scale > 1.4) {
//                sender.scale = 1.4;
//                return;
//            }
            if (realheight < 54 || realheight > 81){
                NSLog(@"realheight is %d, scale is %f, currenHeight %d\n",realheight, sender.scale, currentHeight);
                return;
            }
            
            NSLog(@"scale is %f",sender.scale);
            NSString *resultString = [[NSString alloc] initWithFormat:@"%d'",realheight];
//            NSString *resultString = [[NSString alloc] initWithFormat:@"%d'",heightConstraint];
            heightLabel.text = resultString;
            
            CGAffineTransform stretch = CGAffineTransformMakeScale(1, sender.scale);
            [constrainIcon setTransform:stretch];
            
            
            NSString *eventColumn;
            
            if (eventNum== 0){
                eventColumn = @"overall_points";
            }else if(eventNum == 1){
                eventColumn = @"score1";
            }else if(eventNum == 2){
                eventColumn = @"score2";
            }else if(eventNum == 3){
                eventColumn = @"score3";
            }else if(eventNum == 4){
                eventColumn = @"score4";
            }else if(eventNum == 5){
                eventColumn = @"score5";
            }else if(eventNum == 6){
                eventColumn = @"score6";
            }
            
            @try {
                [xFitArray removeAllObjects];
                NSFileManager *fileMgr = [NSFileManager defaultManager];
                NSString *dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:@"xfit2011SQL.sqlite"];
                BOOL success = [fileMgr fileExistsAtPath:dbPath];
                if(!success)
                {
                    NSLog(@"Cannot locate database file '%@'.", dbPath);
                }
                if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
                {
                    NSLog(@"An error has occured, %s", sqlite3_errmsg(db));
                    // NSLog(@"Event column:%@ and height: %d",eventColumn, heightConstraint);
                }
                const char *sql =[[NSString stringWithFormat:@"SELECT ID, Name, weight, height, %@, gender FROM  xfit2011 WHERE height = %d",eventColumn,realheight] UTF8String];
//
//                const char *sql =[[NSString stringWithFormat:@"SELECT ID, Name, weight, height, %@, gender FROM  xfit2011 WHERE height = %d",eventColumn,heightConstraint] UTF8String];

                
                
                sqlite3_stmt *sqlStatement;
                if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
                {
                    NSLog(@"Problem with prepare statement");
                }
                
                while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                    XFitData *myXFitData = [[XFitData alloc] init];
                    
                    myXFitData.ident = sqlite3_column_int(sqlStatement, 0);
                    myXFitData.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
                    myXFitData.height = sqlite3_column_int(sqlStatement, 3);
                    myXFitData.weight = sqlite3_column_int(sqlStatement, 2);
                    myXFitData.event = sqlite3_column_int(sqlStatement, 4);
                    myXFitData.gender = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,5)];
                    [xFitArray addObject:myXFitData];
                }
                sqlite3_finalize(sqlStatement);
                sqlite3_close(db);
                [self.canv fillXFitArray:xFitArray];
                [self.view setNeedsDisplay];
                
            }
            @catch (NSException *exception) {
                NSLog(@"An exception occured: %@", [exception reason]);
            }
            @finally {
                //sqlite3_close(db);
            } 
        }
    }
}
@end
