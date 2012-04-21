//
//  XFitData.m
//  2011CrossfitViz
//
//  Created by Ryan Rusnak on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XFitData.h"

@implementation XFitData 

@synthesize ident;
@synthesize name;
@synthesize weight;
@synthesize height;
@synthesize event;
@synthesize gender;

- (NSString*) description{
    return [NSString stringWithFormat:@"Object: %d, %@, %f, %f, %f", self.ident, self.name, self.weight, self.height, self.event, self.gender];
}

@end
