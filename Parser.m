//
//  Parser.m
//  2011CrossfitViz
//
//  Created by Ryan Rusnak on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Parser.h"

@implementation Parser

-(void)parseCSV{

NSString *dataStr = [NSString stringWithContentsOfFile:@"xfit2011.csv" encoding:NSUTF8StringEncoding error:nil];
NSArray *csvArray = [dataStr componentsSeparatedByString: @","];
}

@end
