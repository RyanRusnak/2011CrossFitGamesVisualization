//
//  XFitData.h
//  2011CrossfitViz
//
//  Created by Ryan Rusnak on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFitData : NSObject{}

@property (nonatomic,assign) NSInteger ident;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,assign)CGFloat weight;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGFloat event;
@property (nonatomic,retain)NSString *gender;

@end
