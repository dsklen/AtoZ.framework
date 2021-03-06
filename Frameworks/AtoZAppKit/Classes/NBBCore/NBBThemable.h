
/* Neon Boom Box - In-car entertainment front-end
 * Copyright (C) 2012 Brad Allred
 */

@import AppKit;

@class NBBTheme;
@protocol NBBThemable <NSObject>

@property(readonly) NBBTheme* theme;

-   (id) initWithTheme:(NBBTheme*) theme;
- (BOOL) applyTheme:   (NBBTheme*) theme;
@end
