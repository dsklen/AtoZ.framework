
#import "AtoZUmbrella.h"


@interface NSColorList (AtoZ) <Random, ClassKeyGet, KeyGet> // [((id)NSCL.class)[@"csscolors"] -> csscolors

@prop_RO NSA * colors;  @prop_RO NSC * randomColor; @prop_RO  NSS*html;

+ (NSA*) availableColorListNames;
+ (NSA*) frameworkColorLists;

+ (INST) colorListInFrameworkWithFileName:(NSS*)fName;
+ (INST)            colorListWithFileName:(NSS*)fName         inBundle:(NSB*)b;
+ (INST)            colorListWithFileName:(NSS*)fName inBundleForClass:(Class)k;
+ (INST)              colorListWithColors:(NSA*)cs            andNames:(NSA*)ns
                                                                 named:(NSS*)n;

+ (NSA*) namedColors;
+ (NSD*) namedColorDictionary;
@end

@interface NSColor (AIColorAdditions)

#pragma mark -  Comparison
- (BOOL)equalToRGBColor:(id)arg1;

#pragma mark -  DarknessAndContrast
- contrastingColor;
- colorWithInvertedLuminance;
- darkenAndAdjustSaturationBy:(double)arg1;
- darkenBy:(double)arg1;

@prop_RO BOOL colorIsMedium, colorIsDark;

#pragma mark -  AIColorAdditions_HLS
- (id)adjustHue:(double)arg1 saturation:(double)arg2 brightness:(double)arg3;

#pragma mark -  AIColorAdditions_RepresentingColors

@prop_RO NSS* hexString, *stringRepresentation;

#pragma mark - AIColorAdditions_RepresentingColors

+ (NSC*)representedByString:(NSS*)_self withAlpha:(CGF)aa;
+ (NSC*) representedByString:(NSS*)_self;

#pragma mark - AIColorAdditions_RandomColor
+ (INST) randomColorWithAlpha;
+ (INST) randomColor;

#pragma mark - ObjectColor
+ representedColorForObject:(id)arg1 withValidColors:(id)arg2;

#pragma mark - ColorspaceEquality

- (BOOL)isEqualToColor:(id)arg1 colorSpace:(id)arg2;

#pragma mark - CSSRGB
+ (INST) colorWithCSSRGB:(id)arg1;

@end
