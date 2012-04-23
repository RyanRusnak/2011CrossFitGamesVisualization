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

@synthesize xFitArray;
@synthesize eventNum;

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
    
    overallButtonFrame = overallButton.frame;
    eventOneFrame = buttonEventOne.frame;
    eventTwoFrame = buttonEventTwo.frame;
    eventThreeFrame = buttonEventThree.frame;
    eventFourFrame = buttonEventFour.frame;
    eventFiveFrame = buttonEventFive.frame;
    eventSixFrame = buttonEventSix.frame;
    buttonConstrainFrame = buttonConstrain.frame;
    constrainIconFrame = constrainIcon.frame;
    
    [constrainIcon setHidden:YES];
    
//    overallButtonFrame.origin.x -= 30;
//    eventOneFrame.origin.x -= 30;
//    eventTwoFrame.origin.x -= 30;
//    eventThreeFrame.origin.x -= 20;
//    eventFourFrame.origin.x -= 30;
//    eventFiveFrame.origin.x -= 30;
//    eventSixFrame.origin.x -= 30;
    
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
    return YES;
}

- (IBAction)showOverall:(id)sender {
    
    //NSMutableArray *xFitArray = [[NSMutableArray alloc] init];
    @try {
        eventNum = 0;
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
        workoutLabel.text = @"10 minute AMRAP: 30 Double-unders 15 Power snatches";
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
        workoutLabel.text = @"15 minute AMRAP: 9 Deadlifts (155lbs / 70kg) 12 Push-ups 15 Box jumps (24 inch)";
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
        workoutLabel.text = @"5 minute AMRAP: 165 pound Squat clean 165 pound Jerk";
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
        workoutLabel.text = @"10 minute AMRAP: 60 Bar-facing burpees120 pound Overhead squat, 30 reps10 Muscle-ups";
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
        workoutLabel.text = @"20 minute AMRAP: 5 Power cleans (145lbs / 65kg) 10 Toes to bar 15 Wall balls (20lbs to 10' target) ";
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
        workoutLabel.text = @"7 minute AMRAP: 3 Barbell Thrusters 3 Chest to bar Pull-ups 6 Barbell Thrusters 6 Chest to bar Pull-ups 9 Barbell Thrusters 9 Chest to bar Pull-ups 12 Barbell Thrusters 12 Chest to bar Pull-ups 15 Barbell Thrusters 15 Chest to bar Pull-ups 18 Barbell Thrusters 18 Chest to bar Pull-ups 21 Barbell Thrusters 21 Chest to bar Pull-ups... This is a timed workout. If you complete the round of 21, go on to 24. If you complete 24, go on to 27, etc. ";
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
    }else
    {
        [constrainIcon setHidden:YES];
    }
}

- (IBAction)swipeClosedMenu:(UISwipeGestureRecognizer*)sender {
    
    if (menuOpen == TRUE){
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
    menuOpen = FALSE;
    }
}


- (IBAction)swipedMenu:(UISwipeGestureRecognizer*)sender {
    
    if(menuOpen == FALSE){
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
    menuOpen = TRUE;
    }
}
- (IBAction)userPinched:(UIPinchGestureRecognizer*)sender {
    
    int heightConstraint = 67;
    
    CGFloat scale = [(UIPinchGestureRecognizer *)sender scale];
    if (heightConstraint > 54 || heightConstraint < 81){
            heightConstraint = heightConstraint *(sender.scale / 1.5);
    }
    
    NSString *resultString = [[NSString alloc] initWithFormat:
                              @"Pinch - scale = %f, Height:%d",
                              scale, heightConstraint];
    titleText.text = resultString;
    
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
            NSLog(@"An error has occured.");
           // NSLog(@"Event column:%@ and height: %d",eventColumn, heightConstraint);
        }
        const char *sql =[[NSString stringWithFormat:@"SELECT ID, Name, weight, height, %@, gender FROM  xfit2011 WHERE height = %d",eventColumn,heightConstraint] UTF8String];
    
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
@end
