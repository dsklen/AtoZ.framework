
//#import "TUIButton.h"

@interface TUIButtonContent : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSColor *titleColor;
@property (nonatomic, strong) NSColor *shadowColor;
@property (nonatomic, strong) NSImage *image;
@property (nonatomic, strong) NSImage *backgroundImage;
@property (nonatomic, strong) NSColor *backgroundColor;
@end

@implementation TUIButtonContent
@synthesize title = title;
@synthesize titleColor = titleColor;
@synthesize shadowColor = shadowColor;
@synthesize image = image;
@synthesize backgroundImage = backgroundImage;
@synthesize backgroundColor = backgroundColor;
@end


@implementation TUIButton (Content)

- (TUIButtonContent *)_contentForState:(TUIControlState)state
{
    // if the state mask has disabled in it, it should just appear disabled
    if ((state & TUIControlStateDisabled) == TUIControlStateDisabled) {
        state = TUIControlStateDisabled;
    }

	id key = @(state);
	TUIButtonContent *c = [_contentLookup objectForKey:key];

	if (c == nil && (state & TUIControlStateNotKey)) {
		// Try matching without the NotKey state.
		c = [_contentLookup objectForKey:@(state & ~TUIControlStateNotKey)];
	}

	if (c == nil) {
		c = TUIButtonContent.new;
		[_contentLookup setObject:c forKey:key];
	}

	return c;
}

- (void)setTitle:(NSString *)title forState:(TUIControlState)state
{
	[self stateWillChange];
	[[self _contentForState:state] setTitle:title];
	[self setNeedsDisplay];
	[self stateDidChange];
}

- (void)setTitleColor:(NSColor *)color forState:(TUIControlState)state
{
	[self stateWillChange];
	[[self _contentForState:state] setTitleColor:color];
	[self setNeedsDisplay];
	[self stateDidChange];
}

- (void)setTitleShadowColor:(NSColor *)color forState:(TUIControlState)state
{
	[self stateWillChange];
	[[self _contentForState:state] setShadowColor:color];
	[self setNeedsDisplay];
	[self stateDidChange];
}

- (void)setImage:(NSImage *)i forState:(TUIControlState)state
{
	[self stateWillChange];
	[[self _contentForState:state] setImage:i];
	[self setNeedsDisplay];
	[self stateDidChange];
}

- (void)setBackgroundImage:(NSImage *)i forState:(TUIControlState)state
{
	[self stateWillChange];
	[[self _contentForState:state] setBackgroundImage:i];
	[self setNeedsDisplay];
	[self stateDidChange];
}

- (void)setBackgroundColor:(NSColor *)color forState:(TUIControlState)state
{
	[self stateWillChange];
	[[self _contentForState:state] setBackgroundColor:color];
	[self setNeedsDisplay];
	[self stateDidChange];
}


- (NSString *)titleForState:(TUIControlState)state
{
	return [[self _contentForState:state] title];
}

- (NSColor *)titleColorForState:(TUIControlState)state
{
	return [[self _contentForState:state] titleColor];
}

- (NSColor *)titleShadowColorForState:(TUIControlState)state
{
	return [[self _contentForState:state] shadowColor];
}

- (NSImage *)imageForState:(TUIControlState)state
{
	return [[self _contentForState:state] image];
}

- (NSImage *)backgroundImageForState:(TUIControlState)state
{
	return [[self _contentForState:state] backgroundImage];
}

- (NSColor *)backgroundColorForState:(TUIControlState)state
{
	return [[self _contentForState:state] backgroundColor];
}

- (NSString *)currentTitle
{
	NSString *title = [self titleForState:self.state];
	if(title == nil) {
		title = [self titleForState:TUIControlStateNormal];
	}
	
	return title;
}

- (NSColor *)currentTitleColor
{
	NSColor *color = [self titleColorForState:self.state];
	if(color == nil) {
		color = [self titleColorForState:TUIControlStateNormal];
	}
	
	return color;
}

- (NSColor *)currentTitleShadowColor
{
	NSColor *color = [self titleShadowColorForState:self.state];
	if(color == nil) {
		color = [self titleShadowColorForState:TUIControlStateNormal];
	}
	
	return color;
}

- (NSImage *)currentImage
{
	NSImage *image = [self imageForState:self.state];
	if(image == nil) {
		image = [self imageForState:TUIControlStateNormal];
	}
	
	return image;
}

- (NSImage *)currentBackgroundImage
{
	NSImage *image = [self backgroundImageForState:self.state];
	if(image == nil) {
        image = [self backgroundImageForState:TUIControlStateSelected];
        if (image == nil || !self.selected) {
            image = [self backgroundImageForState:TUIControlStateNormal];
        }
	}
	
	return image;
}

@end
