//
//  NSDictionary+AtoZ.h
//  AtoZ
//
//  Created by Alex Gray on 9/19/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AtoZ.h"

@interface NSMutableDictionary (AtoZ)

- (void)setColor:(NSColor *)aColor forKey:(NSString *)aKey;
- (NSColor *)colorForKey:(NSString *)aKey;

@end

//http://appventure.me/2011/12/fast-nsdictionary-traversal-in-objective-c.html
//	supports retrieving individual NSArray entities during traversal. I.e.: ‘data.friends.data.0.name’ to access the first friends name
@interface NSDictionary (objectForKeyList)
- (id)objectForKeyList:(id)key, ...;
@end


//	syntax of path similar to Java: record.array[N].item
//	items are separated by . and array indices in []
//	example: a.b[N][M].c.d

@interface  NSMutableDictionary (GetObjectForKeyPath)
- (id)objectForKeyPath:(NSString *)inKeyPath;
-(void)setObject:(id)inValue forKeyPath:(NSString *)inKeyPath;
@end

@interface NSDictionary (AtoZ)

+ (NSDictionary*) dictionaryWithValue:(id)value forKeys:(NSA*)keys;
- (NSDictionary*) dictionaryWithValue:(id)value forKey:(id)key;
- (NSDictionary*) dictionaryWithoutKey:(id)key;
- (NSDictionary*) dictionaryWithKey:(id)newKey replacingKey:(id)oldKey;

- (void)enumerateEachKeyAndObjectUsingBlock:(void(^)(id key, id obj))block;

- (void)enumerateEachSortedKeyAndObjectUsingBlock:(void(^)(id key, id obj, NSUInteger idx))block;

@end
@interface NSDictionary (OFExtensions)
/// Enumerate each key and object in the dictioanry.

- (NSDictionary *)dictionaryWithObject:(id)anObj forKey:(NSString *)key;
//- (NSDictionary *)dictionaryByAddingObjectsFromDictionary:(NSDictionary *)otherDictionary;

- (id)anyObject;
- (NSString *)keyForObjectEqualTo:(id)anObj;

- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSString *)stringForKey:(NSString *)key;

- (NSArray *)stringArrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSArray *)stringArrayForKey:(NSString *)key;

	// ObjC methods to nil have undefined results for non-id values (though ints happen to currently work)
- (float)floatForKey:(NSString *)key defaultValue:(float)defaultValue;
- (float)floatForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key defaultValue:(double)defaultValue;
- (double)doubleForKey:(NSString *)key;

- (CGPoint)pointForKey:(NSString *)key defaultValue:(CGPoint)defaultValue;
- (CGPoint)pointForKey:(NSString *)key;
- (CGSize)sizeForKey:(NSString *)key defaultValue:(CGSize)defaultValue;
- (CGSize)sizeForKey:(NSString *)key;
- (CGRect)rectForKey:(NSString *)key defaultValue:(CGRect)defaultValue;
- (CGRect)rectForKey:(NSString *)key;

	// Returns YES iff the value is YES, Y, yes, y, or 1.
- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (BOOL)boolForKey:(NSString *)key;

	// Just to make life easier
- (int)intForKey:(NSString *)key defaultValue:(int)defaultValue;
- (int)intForKey:(NSString *)key;
- (unsigned int)unsignedIntForKey:(NSString *)key defaultValue:(unsigned int)defaultValue;
- (unsigned int)unsignedIntForKey:(NSString *)key;

- (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
- (NSInteger)integerForKey:(NSString *)key;

- (unsigned long long int)unsignedLongLongForKey:(NSString *)key defaultValue:(unsigned long long int)defaultValue;
- (unsigned long long int)unsignedLongLongForKey:(NSString *)key;
    // This seems more convenient than having to write your own if statement a zillion times
- (id)objectForKey:(NSString *)key defaultObject:(id)defaultObject;

- (NSMutableDictionary *)deepMutableCopy NS_RETURNS_RETAINED;

- (NSArray *)copyKeys;
- (NSMutableArray *)mutableCopyKeys;

- (NSSet *)copyKeySet;
- (NSMutableSet *)mutableCopyKeySet;

@end