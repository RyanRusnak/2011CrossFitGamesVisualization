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
@synthesize canv;

@synthesize xFitArray;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.canv.xFitArray = [[NSMutableArray alloc]init];
	// Do any additional setup after loading the view, typically from a nib.
    xFitArray = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
    //[self setCustomCanv:nil];
    [self setCanv:nil];
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

- (IBAction)parseCSV:(id)sender {
    
    //NSMutableArray *xFitArray = [[NSMutableArray alloc] init];
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
@end
