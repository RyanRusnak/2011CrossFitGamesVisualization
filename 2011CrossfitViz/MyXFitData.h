//
//  MyXFitData.h
//  2011CrossfitViz
//
//  Created by Ryan Rusnak on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "XFitData.h"

@interface MyXFitData : NSObject{
    
    sqlite3 *db;
}

- (NSMutableArray *) getXFitData;

@end
