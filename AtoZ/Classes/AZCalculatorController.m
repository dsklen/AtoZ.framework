//
//  AZCalculatorController.m
//  AtoZ
//
//  Created by Alex Gray on 9/21/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import "AZCalculatorController.h"
#import "CalcModel.h"

@implementation AZCalculatorController @synthesize labelValue;

+ (instancetype) sharedCalc {

	static AZCalculatorController *_sharedCalc = nil;
	if(!_sharedCalc) _sharedCalc = [self.alloc initWithWindowNibName:self.nibName];
	return _sharedCalc;
}
	// Subclasses can override this to use a nib with a different name.
+ (NSString *)nibName{
	return @"Calculator";
}
//assert (g_inspector != nil); // or other error handling

//[g_inspector showWindow: self];
//}

//NSWindowController * windowController = [NSWindowController.alloc ;
//[windowController window];

	//- (void) pplicationDidFinishLaunching:(NSNotification *)aNotification {
//

- (id)init
{
	self = [super initWithWindowNibName: @"Calculator"];
	if (self) {
//		self.window = [NSWindow.alloc initWithWindowNibName: @"Calculator"];
		[self showWindow:self.window];
		self.calc = CalcModel.new;
	}
	return self;
}
//- (id)init {
//	calc = CalcModel.new;
//	return self;
//}

-(void)dealloc {
//	[calc release];
//	[super dealloc];
}

- (IBAction)add:(id)sender {
	[_calc operatorAction:addOperator];
}

//- (IBAction)calc = CalcModel.new;

-(IBAction)getValue:(id)sender {
	NSString *buttonValue = [sender title];
	[_calc numberInput:buttonValue];
	[self setLabel];
}

- (void) setLabel {
	labelValue = [NSString stringWithFormat:@"%ld", [_calc accumulatorValue]];
	[_label setStringValue:labelValue];
}

@end
