
#import "AtoZUmbrella.h"
//#import "AtoZMacroDefines.h"
//#import "AtoZTypes.h"

/** AZBlockView.h - USAGE

[[someView addSubview:
	[AZBlockView viewWithFrame:someView.bounds opaque:NO drawnUsingBlock: ^(AZBlockView *view, NSRect dirtyRect) {
		view.autoresizingMask = NSViewHeightSizable| NSViewWidthSizable;
		[RED set];
		[[NSBezierPath bezierPathWithRoundedRect:view.bounds xRadius:5 yRadius:5] fill];
	}]
]positioned:NSWindowBelow relativeTo:anotherView];

 Usage: @code

- (void) awakeFromNib {
 	block __typeof(self) blockSelf = self; 
 	[[self view] addSubview:[BNRBlockView viewWithFrame:contentRect opaque:NO drawnUsingBlock:^(BNRBlockView *view, NSRect dirtyRect) { 
 		[[blockSelf roundedRectFillColor] set]; 
		[[NSBezierPath bezierPathWithRoundedRect:[view bounds] xRadius:5 yRadius:5] fill]; 
 	}]];
}

*/
//typedef void(^ObjRectBlock) (id _self, NSR rect);

@interface BNRBlockView : NSView

@prop_CP RectBlock   rBlock;          //typedef void(^RectBlock) (NSR rect);

    // typedef void(^BlkViewRectBlock)     (BLKVIEW *v, NSRect r);

@prop_CP BlkViewRectBlock   drawBlock;               // typedef void(^BlkViewLayerBlock) (BLKVIEW *v, CALayer *l);
@prop_CP BlkViewLayerBlock   layerDelBlock;
@prop_CP ViewBlock   vBlock;

+ (INST) drawInView:(NSV*)v                            block:(RectBlock)blk;
+ (INST) vWF:(NSR)f b:(void(^)(id))blk; // alias for vwf:db
+ (INST) viewWithFrame:(NSR)f                      drawBlock:(BlkViewRectBlock)blk;
+ (INST) inView:(NSV*)v withFrame:(NSR)f           inContext:(BlkViewLayerBlock)blk;
+ (INST) viewWithFrame:(NSR)f opaque:(BOOL)o drawnUsingBlock:(BlkViewRectBlock)dBlk;

//@property BOOL   opaque;
@end

//+ (INST) inView:(NSV*)v                            withBlock:(BlkViewLayerDelegate)ctxBlk;

//@interface AZBlockWindow : NSWindow
//+ (AZBlockWindow *)windowWithFrame:(NSRect)frame drawnUsingBlock:(ObjRectBlock)dBlock;
//@property (CP) ObjRectBlock drawBlock;
//@end

/*! @note **** IN NSIMAGE + AZOTZ  ***
typedef void(^NSImageDrawer)(void);

@interface NSImage (AtoZDrawBlock)
+ (NSImage*)imageWithSize:(NSSZ)size drawnUsingBlock:(NSImageDrawer)drawBlock;
@end
*/

/*
//[BLKVIEW inView:win.contentView withFrame:win.contentRect inContext:^(BLKVIEW*v, CAL*l){ NSRectFillWithColor(l.bounds, GREEN); }];

@class BLKCELL;
#define DRAWCELLBLK ^(BLKCELL*cell,NSR cellFrame,NSV*controlView)
typedef void(^AZCellBlockDrawer)	(BLKCELL*cell, NSR cF, NSV*cV);
@interface BLKCELL : NSButtonCell
+ (instancetype) inView:(NSV*)v withBlock:(void(^)(BLKCELL*,NSR,NSV*))blk;
@property (NATOM, CP) AZCellBlockDrawer 			dBlock;
@end

@class AZBlockView;
// Declare the AZBlockViewDrawer block type:
typedef void(^AZBlockViewDrawer)(AZBlockView *view, NSRect dirtyRect);
@interface AZBlockView : NSView {
	AZBlockViewDrawer drawBlock;
	BOOL opaque;
}
+ (AZBlockView *)viewWithFrame:(NSRect)frame
						 opaque:(BOOL)opaque
				drawnUsingBlock:(AZBlockViewDrawer)drawBlock;
@property (NATOM, CP) AZBlockViewDrawer drawBlock;
@property (nonatomic, assign) BOOL opaque;
@end

#define BLKVIEWinVIEW(v,blk) [v addSubview:[BLKVIEW

*/
