//
//  AZIndexedObjects.m
//  AtoZ
//
//  Created by Alex Gray on 7/7/13.
//  Copyright (c) 2013 mrgray.com, inc. All rights reserved.
//

#import "AZIndexedObjects.h"
#import "AtoZ.h"



@interface AZIndexedObjects ()
@property NSMD*map;
@end
#define IDX(_x_) @(_x_).stringValue

@implementation AZIndexedObjects

-   (id) init {  return self = super.init ? _map = NSMD.new, self : nil; }
-   (id) objectAtIndex:	(NSUI)idx {

  if ([_map.allKeys containsObject:IDX(idx)])
    return ((NUWeakReference*)_map[IDX(idx)]).ref;
  else return nil;
}
-  (NSI) indexOfObject:	(id)x {

	return (![_map.allValues containsObject:x]) ? NSNotFound : [[_map keyForObjectEqualTo:x]integerValue];
}
- (void) addObject:		(id)x {	_map[[_map.allKeys maxNumberInArray].stringValue] = x;	}
- (void) addObject:		(id)x 			  atIndex:(NSI)idx { _map[IDX(idx)] = x; 				}
- (void) setObject:		(id)x atIndexedSubscript:(NSI)idx { _map[IDX(idx)] = x; 				}
-   (id) objectAtIndexedSubscript:					 (NSI)idx { return _map[IDX(idx)];			}


@end
