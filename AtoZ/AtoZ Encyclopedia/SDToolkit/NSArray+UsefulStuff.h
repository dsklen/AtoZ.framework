//
//  NSArray+UsefulStuff.h
//  DeskLabels
//
//  Created by Steven Degutis on 7/7/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

@interface NSArray (UsefulStuff)

- (NSA*) reversedArray;

- (id) firstObject;

@end

@interface NSMutableArray (UsefulStuff)

- (void) moveObjectFromIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex;

@end
