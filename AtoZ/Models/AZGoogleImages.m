//
//  AZGoogleImages.m
//  AtoZ
//
//  Created by Alex Gray on 6/28/13.
//  Copyright (c) 2013 mrgray.com, inc. All rights reserved.
//

#import "AZGoogleImages.h"

@implementation AZGoogleQuery  
- (NSURL*) url {  return  $URL($(@"http://images.google.com/images?q=%@&safe=off&start=%ld", [self.query stringByReplacing:@" " with:@"+"].URLEncodedString , self.start)); }
-   (void) loadMoreURLs { AZLOGCMD; if (!_query) return;

		self.startTiming;	NSERR *e = nil; _urls = _urls ?: NSMA.new; NSUI startCt = _urls.count;
		AZHTMLParser 	*parser = [AZHTMLParser.alloc initWithContentsOfURL:self.url error:&e];
		if (e) return NSLog(@"error with URL request to google!"), nil;
		NSS* sentinel = @"imgres?imgurl=", *f2=@"<a href=\"/imgres?imgurl=", *f3=@"&amp;imgrefurl=";
		NSA *nodes = [parser.body findChildrenWithAttribute:@"id" matchingName:@"ires" allowPartial:FALSE];

		[self blockSelf:^(typeof(self) bSelf) {
			[nodes each:^(HTMLNode *node) {	NSA* them;
				if (them = [node findChildrenWithAttribute:@"href" matchingName:sentinel allowPartial:TRUE]);
					[them do:^(id obj) { 	[bSelf.urls addObject:[[[obj rawContents]stringByRemovingPrefix:f2] substringBefore:f3]];
				}];
			}];
		}];	self.start +=20;	if (_imageUrlsBlock && startCt != _urls.count) _imageUrlsBlock(_urls);
				self.stopTiming; self.elapsed.log;
}
@end

#define BASECOLLECTION ({ id c; if (!(c=[[self.class sharedInstance]defaultCollection])) c = NSMA.new; c; })
@implementation AZGoogleImages

//+ (void) initialize {  [self.sharedInstance setDefaultCollectionKey:@"savedSearches"]; }

//- (void) setUp { if (![self.class hasSharedInstance] || self != sharedI ){
//
//	  [self.class setSharedInstance:[self initWithContentsOfFile:[self.class saveFile]]]
//+ (instancetype) instanceWithContentsOfFile:(NSString *)path {
//	if ([self hasSharedInstance]) return [self sharedInstance]; else return [self in]
//}

+ (AZGoogleQuery*) searchGoogleImages:(NSS*)query withBlock:(void(^)(NSA*imageURLs))block {

	AZGoogleQuery *azq = [BASECOLLECTION objectWithValue:query forKey:@"query"] ?: AZGoogleQuery.new;
	azq.startTiming;
	azq.imageUrlsBlock = block;
	azq.query = query;
	azq.loadMoreURLs;
	[BASECOLLECTION containsObject:azq] ? nil : [BASECOLLECTION addObject:azq];
}
+ (NSA*) queries { return BASECOLLECTION; }
+ (NSA*) urlsForQuery:(NSS*)query {	AZGoogleQuery *q;
	return (q = [BASECOLLECTION objectWithValue:query forKey:@"query"])
				 ? q.urls
				 : ([(q = [self searchGoogleImages:query withBlock:nil]) urls].count)
				 ? q.urls
				 : nil;
}

@end