//
//  MyXFitData.m
//  2011CrossfitViz
//
//  Created by Ryan Rusnak on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyXFitData.h"


@implementation MyXFitData

- (NSMutableArray *) getXFitData{
    NSMutableArray *xFitArray = [[NSMutableArray alloc] init];
    @try {
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
        const char *sql = "SELECT id, name, weight, height FROM  xfit2011";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
        }
        
        //
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            NSLog(@"Success!");
            XFitData *myXFitData = [[XFitData alloc]init];
            myXFitData.ident = sqlite3_column_int(sqlStatement, 0);
            myXFitData.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
            myXFitData.weight= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)];
            myXFitData.weight= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)];
            [xFitArray addObject:myXFitData];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally {
        return xFitArray;
    } 
    
    
}

@end
