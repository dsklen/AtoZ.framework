//  THMatrix.h
//  Lumumba Framework
//  Created by Benjamin Schüttler on 28.09.09.
//  Copyright 2011 Rogue Coding. All rights reserved.

// A THMatrix is always mutable

#import "AtoZUmbrella.h"

@interface AZMatrix : NSObject {
	NSUI width, height;
	NSMA *data;
}

@property (NATOM,ASS) NSUI width, height;

- (id) objectAtX:(NSUInteger)x y:(NSUInteger)y;

@end
