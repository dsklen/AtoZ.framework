//
//  BGHUDPopUpButtonCell.h
//  BGHUDAppKit
//
//  Created by BinaryGod on 5/31/08.
//


@import AppKit;
#import "BGThemeManager.h"

@interface BGHUDPopUpButtonCell : NSPopUpButtonCell {

	NSString *themeKey;
}

@property (strong) NSString *themeKey;

- (void)drawArrowsInRect:(NSRect) frame;

@end
