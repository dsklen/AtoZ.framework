//
//  THGeometricFunctions.m
//  Lumumba
//
//  Created by Benjamin Schüttler on 19.11.09.
//  Copyright 2011 Rogue Coding. All rights reserved.
//

#import "AZGeometricFunctions.h"
#import "AtoZ.h"
#import <Quartz/Quartz.h>


@implementation  NSObject (LayerTools)
-(CALayer*) selectionLayerForLayer:(CALayer*)layer {

	CALayer *aselectionLayer = [CALayer layer];
		//		selectionLayer.bounds = CGRectMake (0.0,0.0,width,height);
	aselectionLayer.borderWidth = 4.0;
	aselectionLayer.cornerRadius = layer.cornerRadius;
	aselectionLayer.borderColor= cgWHITE;

	CIFilter *filter = [CIFilter filterWithName:@"CIBloom"];
	[filter setDefaults];
	[filter setValue:[NSNumber numberWithFloat:5.0f] forKey:@"inputRadius"];
	[filter setName:@"pulseFilter"];
	[aselectionLayer setFilters:[NSArray arrayWithObject:filter]];

		// The selectionLayer shows a subtle pulse as it is displayed. This section of the code create the pulse animation setting the filters.pulsefilter.inputintensity to range from 0 to 2. This will happen every second, autoreverse, and repeat forever
	CABasicAnimation* pulseAnimation = [CABasicAnimation animation];
	pulseAnimation.keyPath = @"filters.pulseFilter.inputIntensity";
	pulseAnimation.fromValue = [NSNumber numberWithFloat: 0.0f];
	pulseAnimation.toValue = [NSNumber numberWithFloat: 2.0f];
	pulseAnimation.duration = 1.0;
	pulseAnimation.repeatCount = HUGE_VALF;
	pulseAnimation.autoreverses = YES;
	pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:
									 kCAMediaTimingFunctionEaseInEaseOut];
	[aselectionLayer addAnimation:pulseAnimation forKey:@"pulseAnimation"];
	NSArray *constraints = [NSArray arrayWithObjects: AZConst( kCAConstraintWidth,@"superlayer"), AZConst( kCAConstraintHeight,@"superlayer"), AZConst( kCAConstraintMidX,@"superlayer"), AZConst( kCAConstraintMidY,@"superlayer"),  nil];
	aselectionLayer.constraints = constraints;



		//		// set the first item as selected
		//		[self changeSelectedIndex:0];
		//
		//		// finally, the selection layer is added to the root layer
		//		[rootLayer addSublayer:self.selectionLayer];
	return aselectionLayer;
}
- (CAShapeLayer*) lassoLayerForLayer:(CALayer*)layer {

		//	NSLog(@"Clicked: %@", [[layer valueForKey:@"azfile"] propertiesPlease] );
	CAShapeLayer *shapeLayer = [CAShapeLayer layer];
		//	[shapeLayer setValue:layer forKey:@"mommy"];
	CGRect shapeRect = layer.bounds;
	[shapeLayer setBounds:shapeRect];
	CGFloat dynnamicStroke = .1*AZMaxDim(layer.bounds.size);
	CGFloat half = dynnamicStroke / 2;
		//	[shapeLayer setAutoresizingMask:kCALayerWidthSizable|kCALayerHeightSizable];
	shapeLayer.constraints = @[		AZConstScaleOff( kCAConstraintMinX,@"superlayer", 1, half), //2), 	AZConstScaleOff( kCAConstraintMaxX,@"superlayer", 1,2),
	AZConstScaleOff( kCAConstraintMinY,@"superlayer", 1,half), /*2),*/ 	AZConstScaleOff( kCAConstraintMaxY,@"superlayer", 1,half),
	AZConstScaleOff( kCAConstraintWidth,@"superlayer", 1,-dynnamicStroke), 	AZConstScaleOff( kCAConstraintHeight,@"superlayer", 1, - dynnamicStroke),
	AZConst( kCAConstraintMidX,@"superlayer"), 					AZConst( kCAConstraintMidY,@"superlayer") ];

	[shapeLayer setPosition:CGPointMake(.5,.5)];
	shapeRect.size.width -= dynnamicStroke;		shapeRect.size.height -= dynnamicStroke;

	shapeLayer.fillColor 	= cgCLEARCOLOR;
	shapeLayer.strokeColor 	= cgBLACK; [[[layer valueForKey:@"azfile"]valueForKey:@"color"]CGColor];
	shapeLayer.lineWidth	= dynnamicStroke;
	shapeLayer.lineJoin		= kCALineJoinRound;
	shapeLayer.lineDashPattern = @[ @(10), @(5)];
	shapeLayer.path = [[NSBezierPath bezierPathWithRoundedRect:NSRectFromCGRect(shapeRect) cornerRadius:layer.cornerRadius] quartzPath];
	shapeLayer.zPosition = 3300;
	CABasicAnimation *dashAnimation = [CABasicAnimation animationWithKeyPath:@"lineDashPhase"];
	[dashAnimation setValuesForKeysWithDictionary:@{ 	@"fromValue":@(0.0), 	@"toValue"	   :@(15.0),
	 @"duration" : @(0.75),	@"repeatCount" : @(10000) }];
	[shapeLayer addAnimation:dashAnimation forKey:@"linePhase"];
	[shapeLayer needsDisplay];
	return shapeLayer;
}

//- (CAShapeLayer*) lassoLayerForLayer:(CALayer*)layer {
//
//	NSLog(@"Clicked: %@", [[layer valueForKey:@"azfile"] propertiesPlease] );
//	CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//	[shapeLayer setValue:layer forKey:@"mommy"];
//		//	float total = 	( (2*contentLayer.bounds.size.width) + (2*contentLayer.bounds.size.height) - (( 8 - ((2 * pi) * contentLayer.cornerRadius))));
//	CGRect shapeRect = layer.bounds;
//
//	[shapeLayer setBounds:shapeRect];
//		//	[shapeLayer setAutoresizingMask:kCALayerWidthSizable|kCALayerHeightSizable];
//	NSArray *constraints = [NSArray arrayWithObjects:
//							AZConstScaleOff( kCAConstraintMinX,@"superlayer", 1,2),
//							AZConstScaleOff( kCAConstraintMaxX,@"superlayer", 1,2),
//							AZConstScaleOff( kCAConstraintMinY,@"superlayer", 1,2),
//							AZConstScaleOff( kCAConstraintMaxY,@"superlayer", 1,2),
//							AZConstScaleOff( kCAConstraintWidth,@"superlayer", 1,-4),
//							AZConstScaleOff( kCAConstraintHeight,@"superlayer", 1, -4),
//							AZConst( kCAConstraintMidX,@"superlayer"),
//							AZConst( kCAConstraintMidY,@"superlayer"),  nil];
//	shapeLayer.constraints = constraints;
//		//	[shapeLayer setPosition:CGPointMake(.5,.5)];
//	[shapeLayer setFillColor:cgCLEARCOLOR];
//	[shapeLayer setStrokeColor: [[[layer valueForKey:@"azfile"]valueForKey:@"color"]CGColor]];
//	[shapeLayer setLineWidth:4];
//	[shapeLayer setLineJoin:kCALineJoinRound];
//	[shapeLayer setLineDashPattern:@[ @(10), @(5)]];
//		//	 [NSArray arrayWithObjects:[NSNumber numberWithInt:10],
//		//	  [NSNumber numberWithInt:5],
//		//	  nil]];
//		// Setup the path
//	shapeRect.size.width -= 4;
//	shapeRect.size.height -= 4;
//	NSBezierPath *p = [NSBezierPath bezierPathWithRoundedRect:NSRectFromCGRect(shapeRect) cornerRadius:layer.cornerRadius];
//
//		//	CGMutablePathRef path = CGPathCreateMutable();
//		//	CGPathAddRect(path, NULL, shapeRect);
//		//	[shapeLayer setPath:path];
//		//	CGPathRelease(path);
//	[shapeLayer setPath:[p quartzPath]];
//	CABasicAnimation *dashAnimation = [CABasicAnimation animationWithKeyPath:@"lineDashPhase"];
//	[dashAnimation setFromValue:[NSNumber numberWithFloat:0.0f]];
//	[dashAnimation setToValue:[NSNumber numberWithFloat:15.0f]];
//	[dashAnimation setDuration:0.75f];
//	[dashAnimation setRepeatCount:10000];
//
//	[shapeLayer addAnimation:dashAnimation forKey:@"linePhase"];
//
//		//	float total = (((2* NSMaxX(contentLayer.frame)) + (2 * NSMaxY(box.frame)))/16);
//		//	CABasicAnimation *dashAnimation = [CABasicAnimation animationWithKeyPath:@"lineDashPhase"];
//		//	dashAnimation.fromValue 	= $float(0.0f);	dashAnimation.toValue 	= $float
//		//	(total);
//		//
//		//	dashAnimation.duration	= 3;				dashAnimation.repeatCount = 10000;
//		//	//	dashAnimation.beginTime = CACurrentMediaTime();// + 2;
//		//	[shapeLayer addAnimation:dashAnimation forKey:@"linePhase"];
//		//	shapeLayer.fillColor 		= cgRED;
//		//	shapeLayer.strokeColor		= cgBLACK;
//		//	shapeLayer.lineJoin			= kCALineJoinMiter;
//		//	shapeLayer.lineDashPattern 	= $array( $int(total/8), $int(total/8));
//		//
//		//	//			srelectedBox.shapeLayer.lineDashPattern 	= $array( $int(15), $int(45));
//		//	shapeLayer.lineWidth = 5;
//		//	[shapeLayer setPath:[[NSBezierPath bezierPathWithRoundedRect:contentLayer.bounds cornerRadius:contentLayer.cornerRadius ] quartzPath]];
// 	return shapeLayer;
//}
/*
- (void) redrawPath {
	CALayer *selected = [lassoLayer valueForKey:@"mommy"];
	CGRect shapeRect = selected.bounds;
	shapeRect.size.width -= 4;
	shapeRect.size.height -= 4;
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, NULL, shapeRect);
	[lassoLayer setPath:path];
	CGPathRelease(path);
}


*/
-(CATransform3D)makeTransformForAngle:(CGFloat)angle{ // from:(CATransform3D)start{

	CATransform3D transform;// = start;
							// the following two lines are the key to achieve the perspective effect
	CATransform3D persp = CATransform3DIdentity;
	persp.m34 = 1.0 / -500;

	transform = CATransform3DConcat(transform, persp);
	transform = CATransform3DRotate(transform,angle, 0.0, 1.0, 0.0);
	return transform;
}

- (CGPoint)_randomPointInRect:(CGRect)rect
{
	CGPoint point = CGPointZero;
	NSInteger max = rect.size.width;
	NSInteger min = 0;
	point.x = (random() % (max-min+1)) + min;

	max = rect.size.height;
	point.y = (random() % (max-min+1)) + min;

	return point;
}

@end


NSNumber *iNum(NSInteger i) {
  return [NSNumber numberWithInt:i];
}

NSNumber *uNum(NSUInteger ui) {
  return [NSNumber numberWithUnsignedInt:ui];
}

NSNumber *fNum(CGFloat f) {
  return [NSNumber numberWithFloat:f];
}

NSNumber *dNum(double d) {
  return @(d);
}

NSRange AZMakeRange(NSUInteger min, NSUInteger max) {
  NSUInteger loc = MIN(min, max);
  NSUInteger len = MAX(min, max) - loc;
  return NSMakeRange(loc, len);
}

NSRect nanRectCheck(NSRect rect) {
		rect.origin = nanPointCheck(rect.origin);
		rect.size 	= nanSizeCheck(rect.size);
		return rect;
}
NSSize nanSizeCheck(NSSize size) {
	size.width  = isinf(size.width)  ? 0 : size.width;
	size.height = isinf(size.height) ? 0 : size.height;
	return  size;
}
NSPoint nanPointCheck(NSPoint origin) {
	origin.x = isinf(origin.x) ? 0 : origin.x;
	origin.y = isinf(origin.y) ? 0 : origin.y;
	return origin;
}

//id nanCheck(NSValue* point) {
//	id behind;
//	if ( [point respondsToSelector:@selector(recttValue)] ) behind = (__bridge_transfer NSRect)nanRectCheck( [point rectValue]);
//		:   [point respondsToSelector:@selector(sizeValue)]  ? nanSizeCheck(  [point pointValue])
//		:   					 							   nanPointCheck( [point pointValue]);
//}
NSPoint AZPointOffset (NSPoint p, NSPoint size) {
	p.x += size.x;
	p.y += size.y;
	return p;
}
NSPoint AZPointOffsetY (NSPoint p, CGFloat distance) {
	p.y += distance;
	return p;
}
NSPoint AZPointOffsetX (NSPoint p, CGFloat distance) {
	p.x += distance;
	return p;
}


//
//CGSize AZAspectRatio(NSRect rect ){

// CGFloat aspectRatio = ( rect.width / rect.height );
//}
CGFloat AZPerimeter (NSRect rect) {
	return ( (2* rect.size.width) + (2 * rect.size.height) );
}

CGFloat AZPermineterWithRoundRadius (NSRect rect, CGFloat radius) {
	return  ( AZPerimeter(rect) - ( ( 8 - (   (2 * pi) * radius)   )));
}


NSRect AZScreenFrameUnderMenu() {
	return AZRectTrimmedOnTop( [[NSScreen mainScreen]frame], AZMenuBarThickness());
}
NSRect AZScreenFrame() {
	return [[NSScreen mainScreen]frame];
}

NSSize AZScreenSize() {
	return AZScreenFrame().size;
}

//
// 2D Functions
//


CGFloat AZMinDim(NSSize sz) {
	return MIN(sz.width, sz.height);
}



CGFloat AZMaxDim(NSSize sz) {
	return MAX(sz.width, sz.height);
}


CGFloat AZMaxEdge(NSRect r){
	return AZMaxDim(r.size);
}

CGFloat AZMinEdge(NSRect r){
	return AZMinDim(r.size);
}

CGFloat AZLengthOfPoint(NSPoint pt) {
  return sqrt(pt.x * pt.x + pt.y * pt.y);
  //return ABS(pt.x) + ABS(pt.y);
}

CGFloat AZAreaOfSize(NSSize size) {
  return size.width * size.height;
}

CGFloat AZAreaOfRect(NSRect rect) {
  return AZAreaOfSize(rect.size);
}
CGFloat AZPointDistance(CGPoint p1, CGPoint p2) {
	return sqrtf(powf(p1.x - p2.x, 2.) + powf(p1.y - p2.y, 2.));
}

CGFloat AZPointAngle(CGPoint p1, CGPoint p2) {
	return atan2f(p1.x - p2.x, p1.y - p2.y);
}

CGFloat AZDistanceFromPoint (NSPoint p1,NSPoint p2) {
	return distanceFromPoint(p1, p2);
}
CGFloat distanceFromPoint (NSPoint p1, NSPoint p2) {
	CGFloat temp;
	temp = pow(p1.x - p2.x, 2);
	temp += pow(p1.y - p2.y, 2);
	return (CGFloat)sqrt(temp);
}

NSPoint NSMakeRandomPointInRect(NSRect rect) {
    CGPoint point = CGPointZero;
    NSInteger max = rect.size.width;
    NSInteger min = 0;
    point.x = (random() % (max-min+1)) + min;

    max = rect.size.height;
    point.y = (random() % (max-min+1)) + min;

    return point;
}


//
// NSPoint result functions
//
NSPoint AZOriginFromMenubarWithX(CGFloat yOffset, CGFloat xOffset) {

	NSPoint topLeft = NSMakePoint(0,[[NSScreen mainScreen]frame].size.height);
	topLeft.x += xOffset;
	topLeft.y -= yOffset;
	topLeft.y -= 22;
	return topLeft;
}

NSPoint AZPointFromSize(NSSize size) {
  return NSMakePoint(size.width, size.height);
}

NSPoint AZAbsPoint(NSPoint point) {
  return NSMakePoint(ABS(point.x), ABS(point.y));
}

NSPoint AZFloorPoint(NSPoint point) {
  return NSMakePoint(floor(point.x), floor(point.y));
}

NSPoint AZCeilPoint(NSPoint point) {
  return NSMakePoint(ceil(point.x), ceil(point.y));
}

NSPoint AZRoundPoint(NSPoint point) {
  return NSMakePoint(round(point.x), round(point.y));
}

NSPoint AZNegatePoint(NSPoint point) {
  return NSMakePoint(-point.x, -point.y);
}

NSPoint AZInvertPoint(NSPoint point) {
  return NSMakePoint(1 / point.x, 1 / point.y);
}

NSPoint AZSwapPoint(NSPoint point) {
  return NSMakePoint(point.y, point.x);
}

NSPoint AZAddPoints(NSPoint one, NSPoint another) {
  return NSMakePoint(one.x + another.x, one.y + another.y);
}

NSPoint AZSubtractPoints(NSPoint origin, NSPoint subtrahend) {
  return NSMakePoint(origin.x - subtrahend.x, origin.y - subtrahend.y);
}

NSPoint AZSumPoints(NSUInteger count, NSPoint point, ...) {
  NSPoint re = point;
  
  va_list pts;
  va_start(pts, point);
  
  for (int i = 0; i < count; i++) {
    NSPoint pt = va_arg(pts, NSPoint);
    re.x += pt.x;
    re.y += pt.y;
  }
  
  va_end(pts);
  
  return re;
}

NSPoint AZMultiplyPoint(NSPoint point, CGFloat multiplier) {
  return NSMakePoint(point.x * multiplier, point.y * multiplier);
}

NSPoint AZMultiplyPointByPoint(NSPoint one, NSPoint another) {
  return NSMakePoint(one.x * another.x, one.y * another.y);
}

NSPoint AZMultiplyPointBySize(NSPoint one, NSSize size) {
  return NSMakePoint(one.x * size.width, one.y * size.height);
}

NSPoint AZRelativeToAbsolutePoint(NSPoint relative, NSRect bounds) {
  return NSMakePoint(relative.x * bounds.size.width  + bounds.origin.x,
                     relative.y * bounds.size.height + bounds.origin.y
                     );
}

NSPoint AZAbsoluteToRelativePoint(NSPoint absolute, NSRect bounds) {
  return NSMakePoint((absolute.x - bounds.origin.x) / bounds.size.width, 
                     (absolute.y - bounds.origin.y) / bounds.size.height
                     );
}

NSPoint AZDividePoint(NSPoint point, CGFloat divisor) {
  return NSMakePoint(point.x / divisor, point.y / divisor);
}

NSPoint AZDividePointByPoint(NSPoint point, NSPoint divisor) {
  return NSMakePoint(point.x / divisor.x, point.y / divisor.y);
}

NSPoint AZDividePointBySize(NSPoint point, NSSize divisor) {
  return NSMakePoint(point.x / divisor.width, point.y / divisor.height);
}


NSPoint AZMovePoint(NSPoint origin, NSPoint target, CGFloat p) {
  // delta = distance fom target to origin
  NSPoint delta = AZSubtractPoints(target, origin);
  // multiply that with the relative distance
  NSPoint way   = AZMultiplyPoint(delta, p);
  // add it to the origin to move along the way
  return AZAddPoints(origin, way);
}

NSPoint AZMovePointAbs(NSPoint origin, NSPoint target, CGFloat pixels) {
  // Distance from target to origin
  NSPoint delta = AZSubtractPoints(target, origin);
  // normalize that by x to recieve the x2y-ratio
  // but wait, if x is 0 already it can not be normalized
  if (delta.x == 0) {
    // in this case check whether y is empty too
    if (delta.y == 0) {
      // cannot move anywhere
      return origin;
    }
    return NSMakePoint(origin.x, 
                       origin.y + pixels * (delta.y > 0 ? 1.0 : -1.0));
  }
  // now, grab the normalized way
  CGFloat ratio = delta.y / delta.x;
  CGFloat x = pixels / sqrt(1.0 + ratio * ratio);
  if (delta.x < 0) x *= -1;
  NSPoint move = NSMakePoint(x, x * ratio);
  return AZAddPoints(origin, move);
}

NSPoint AZCenterOfRect(NSRect rect) {
  // simple math, just the center of the rect
  return NSMakePoint(rect.origin.x + rect.size.width  * 0.5, 
                     rect.origin.y + rect.size.height * 0.5);
}

NSPoint AZCenterOfSize(NSSize size) {
  return NSMakePoint(size.width  * 0.5, 
                     size.height * 0.5);
}

NSPoint AZEndOfRect(NSRect rect) {
  return NSMakePoint(rect.origin.x + rect.size.width,
                     rect.origin.y + rect.size.height);
}


/*
 *   +-------+
 *   |       |   
 *   |   a   |   +-------+
 *   |       |   |       |
 *   +-------+   |   b   |
 *               |       |
 *               +-------+
 */
NSPoint AZCenterDistanceOfRects(NSRect a, NSRect b) {
  return AZSubtractPoints(AZCenterOfRect(a),
                          AZCenterOfRect(b));
}

NSPoint AZBorderDistanceOfRects(NSRect a, NSRect b) {
  // 
  // +------------ left
  // |
  // |     +------ right  
  // v     v
  // +-----+ <---- top
  // |     |
  // +-----+ <---- bottom
  //
  
  // distances, always from ones part to anothers counterpart
  // a zero x or y indicated that the rects overlap in that dimension
  NSPoint re = NSZeroPoint;
  
  NSPoint oa = a.origin;
  NSPoint ea = AZEndOfRect(a);
  
  NSPoint ob = b.origin;
  NSPoint eb = AZEndOfRect(b);
  
  // calculate the x and y separately

  // left / right check
  if (ea.x < ob.x) {
    // [a] [b] --- a left of b
    // positive re.x
    re.x = ob.x - ea.x;
  } else if (oa.x > eb.x) {
    // [b] [a] --- a right of b
    // negative re.x
    re.x = eb.x - oa.x;
  }
  
  // top / bottom check
  if (ea.y < ob.y) {
    // [a] --- a above b
    // [b]
    // positive re.y
    re.y = ob.y - ea.y;
  } else if (oa.y > eb.y) {
    // [b] --- a below b
    // [a]
    // negative re.y
    re.y = eb.y - oa.y;
  }
  
  return re;
}

NSPoint AZNormalizedDistanceOfRects(NSRect from, NSRect to) {
  NSSize mul = AZInvertSize(AZBlendSizes(from.size, to.size, 0.5));
  NSPoint re = AZCenterDistanceOfRects(to, from);
          re = AZMultiplyPointBySize(re, mul);

  return re;
}

NSPoint AZNormalizedDistanceToCenterOfRect(NSPoint point, NSRect rect) {
  NSPoint center = AZCenterOfRect(rect);
  NSPoint half   = AZMultiplyPoint(AZPointFromSize(rect.size), 0.5);
  NSPoint re     = AZSubtractPoints(point, center);
          re     = AZMultiplyPointByPoint(re, half);
  
  return re;
}

NSPoint AZPointDistanceToBorderOfRect(NSPoint point, NSRect rect) {
  NSPoint re = NSZeroPoint;
  
  NSPoint o = rect.origin;
  NSPoint e = AZEndOfRect(rect);
  
  if (point.x < o.x) {
    re.x = point.x - re.x;
  } else if (point.x > e.x) {
    re.x = e.x - point.x;
  }
  
  if (point.y < o.y) {
    re.y = point.y - re.y;
  } else if (point.y > e.y) {
    re.y = e.y - point.y;
  }

  return re;
}

//
// NSSize functions
//

NSRect AZRectFromDim(CGFloat dim) {
	return (NSRect){0,0,dim,dim};
}


NSSize AZSizeFromDimension(CGFloat dim) {
	return NSMakeSize(dim, dim);
}

NSSize AZSizeFromPoint(NSPoint point) {
  return NSMakeSize(point.x, point.y);
}



NSSize AZAbsSize(NSSize size) {
  return NSMakeSize(ABS(size.width), ABS(size.height));
}

NSSize AZAddSizes(NSSize one, NSSize another) {
  return NSMakeSize(one.width + another.width, 
                    one.height + another.height);
}

NSSize AZInvertSize(NSSize size) {
  return NSMakeSize(1 / size.width, 1 / size.height);
}

NSSize AZRatioOfSizes(NSSize inner, NSSize outer) {
  return NSMakeSize (inner.width / outer.width,
                    inner.height / outer.height);
}

NSSize AZMultiplySize( NSSize size, CGFloat multiplier) {
  return (NSSize) { size.width * multiplier, size.height * multiplier };
}

NSSize AZMultiplySizeBySize(NSSize size, NSSize another) {
  return NSMakeSize(size.width * another.width, 
                    size.height * another.height);
}

NSSize AZMultiplySizeByPoint(NSSize size, NSPoint point) {
  return NSMakeSize(size.width * point.x, 
                    size.height * point.y);
}

NSSize AZBlendSizes(NSSize one, NSSize another, CGFloat p) {
  NSSize way;
  way.width  = another.width - one.width;
  way.height = another.height - one.height;
  
  return NSMakeSize(one.width + p * way.width, 
                    one.height + p * way.height);
}

NSSize AZSizeMax(NSSize one, NSSize another) {
  return NSMakeSize(MAX(one.width, another.width),
                    MAX(one.height, another.height));
}

NSSize AZSizeMin(NSSize one, NSSize another) {
  return NSMakeSize(MIN(one.width, another.width),
                    MIN(one.height, another.height));
  
}

NSSize AZSizeBound(NSSize preferred, NSSize minSize, NSSize maxSize) {
  NSSize re = preferred;
  
  re.width  = MIN(MAX(re.width,  minSize.width),  maxSize.width);
  re.height = MIN(MAX(re.height, minSize.height), maxSize.height);
  
  return re;
}


//
// NSRect result functions
//


NSRect AZRectVerticallyOffsetBy(CGRect rect, CGFloat offset) {
	rect.origin.y += offset;
	return  rect;
}

NSRect AZRectHorizontallyOffsetBy(CGRect rect, CGFloat offset) {
	rect.origin.x += offset;
	return  rect;
}



NSRect AZFlipRectinRect(CGRect local, CGRect dest)
{
	NSPoint a = NSZeroPoint;
	a.x = dest.size.width - local.size.width;
	a.y = dest.size.height - local.size.height;
	return AZMakeRect(a,local.size);
}

NSRect AZSquareFromLength(CGFloat length) {
	return  AZMakeRectFromSize(NSMakeSize(length,length));
}

NSRect AZZeroHeightBelowMenu() {
	NSRect e = AZScreenFrame();
	e.origin.y += (e.size.height - 22);
	e.size.height = 0;
	return e;
}


NSRect AZMenuBarFrame() {
	return AZUpperEdge( AZScreenFrame(), AZMenuBarThickness());
}

CGFloat AZMenuBarThickness () { return [[NSStatusBar systemStatusBar] thickness]; }

NSRect AZMenulessScreenRect() {
	NSRect e = AZScreenFrame();
	e.size.height -= 22;
	return e;
}


CGFloat AZHeightUnderMenu () {
	return ( [[NSScreen mainScreen]frame].size.height - [[NSStatusBar systemStatusBar] thickness] );
}


NSRect AZMakeRectMaxXUnderMenuBarY(CGFloat distance) {
	NSRect rect = [[NSScreen mainScreen]frame];
	rect.origin = NSMakePoint(0,rect.size.height - 22 - distance);
	rect.size.height = distance;
	return rect;
}



NSRect AZMakeRectFromPoint(NSPoint point) {
  return NSMakeRect(point.x, point.y, 0, 0);
}

NSRect AZMakeRectFromSize(NSSize size) {
  return NSMakeRect(0, 0, size.width, size.height);
}

NSRect AZMakeRect(NSPoint point, NSSize size) {
  return  nanRectCheck((NSRect){point.x,	point.y, size.width, size.height});
}

NSRect AZMakeSquare(NSPoint center, CGFloat radius) {
  return NSMakeRect(center.x - radius, 
                    center.y - radius, 
                    2 * radius, 
                    2 * radius);
}


NSRect AZMultiplyRectBySize(NSRect rect, NSSize size) {
  return NSMakeRect(rect.origin.x    * size.width,
                    rect.origin.y    * size.height,
                    rect.size.width  * size.width,
                    rect.size.height * size.height
                    );
}

NSRect AZRelativeToAbsoluteRect(NSRect relative, NSRect bounds) {
  return NSMakeRect(relative.origin.x    * bounds.size.width  + bounds.origin.x,
                    relative.origin.y    * bounds.size.height + bounds.origin.y,
                    relative.size.width  * bounds.size.width,
                    relative.size.height * bounds.size.height
                    );
}

NSRect AZAbsoluteToRelativeRect(NSRect a, NSRect b) {
  return NSMakeRect((a.origin.x - b.origin.x) / b.size.width,
                    (a.origin.y - b.origin.y) / b.size.height,
                    a.size.width  / b.size.width,
                    a.size.height / b.size.height
                    );
}


NSRect AZPositionRectOnRect(NSRect inner, NSRect outer, NSPoint position) {
  return NSMakeRect(outer.origin.x 
                    + (outer.size.width - inner.size.width) * position.x, 
                    outer.origin.y 
                    + (outer.size.height - inner.size.height) * position.y, 
                    inner.size.width, 
                    inner.size.height
                    );
}

NSRect AZCenterRectOnPoint(NSRect rect, NSPoint center) {
  return NSMakeRect(center.x - rect.size.width  / 2, 
                    center.y - rect.size.height / 2, 
                    rect.size.width, 
                    rect.size.height);
}

NSRect AZCenterRectOnRect(NSRect inner, NSRect outer) {
  return AZPositionRectOnRect(inner, outer, AZHalfPoint);
}

NSRect AZSquareAround(NSPoint center, CGFloat distance) {
  return NSMakeRect(center.x - distance, 
                    center.y - distance, 
                    2 * distance, 
                    2 * distance
                    );
}

NSRect AZBlendRects(NSRect from, NSRect to, CGFloat p) {
  NSRect re;

  CGFloat q = 1 - p;
  re.origin.x    = from.origin.x    * q + to.origin.x    * p;
  re.origin.y    = from.origin.y    * q + to.origin.y    * p;
  re.size.width  = from.size.width  * q + to.size.width  * p;
  re.size.height = from.size.height * q + to.size.height * p;

  return re;
}

NSRect AZRectTrimmedOnRight(NSRect rect, CGFloat width) {
	return (NSRect) {	rect.origin.x, 					rect.origin.y,
					  	rect.size.width - width,  		rect.size.height	};
}

NSRect AZRectTrimmedOnBottom(NSRect rect, CGFloat height) {
	return (NSRect) {	rect.origin.x, 					(rect.origin.y + height),
						rect.size.width,  				(rect.size.height - height)	};
}
NSRect AZRectTrimmedOnLeft(NSRect rect, CGFloat width) {
	return (NSRect) {	rect.origin.x + width, 					rect.origin.y,
						rect.size.width - width,  		rect.size.height	};
}
NSRect AZRectTrimmedOnTop(NSRect rect, CGFloat height) {
	return (NSRect) {	rect.origin.x, 					rect.origin.y,
						rect.size.width,  				(rect.size.height - height)	};
}


NSRect AZLeftEdge(NSRect rect, CGFloat width) {
  return NSMakeRect(rect.origin.x, 
                    rect.origin.y, 
                    width, 
                    rect.size.height);
}

NSRect AZRightEdge(NSRect rect, CGFloat width) {
  return NSMakeRect(rect.origin.x + rect.size.width - width, 
                    rect.origin.y, 
                    width, 
                    rect.size.height);
}

NSRect AZLowerEdge(NSRect rect, CGFloat height) {
  return NSMakeRect(rect.origin.x, 
                    rect.origin.y, 
                    rect.size.width, 
                    height);
}

NSRect AZUpperEdge(NSRect rect, CGFloat height) {
  return NSMakeRect(rect.origin.x, 
                    rect.origin.y + rect.size.height - height, 
                    rect.size.width, 
                    height);
}

//
// Comparison Methods
//

BOOL AZIsPointLeftOfRect(NSPoint point, NSRect rect) {
  return AZPointDistanceToBorderOfRect(point, rect).x < 0;
}

BOOL AZIsPointRightOfRect(NSPoint point, NSRect rect) {
  return AZPointDistanceToBorderOfRect(point, rect).x > 0;
}

BOOL AZIsPointAboveRect(NSPoint point, NSRect rect) {
  return AZPointDistanceToBorderOfRect(point, rect).y < 0;
}

BOOL AZIsPointBelowRect(NSPoint point, NSRect rect) {
  return AZPointDistanceToBorderOfRect(point, rect).y > 0;
}

BOOL AZIsRectLeftOfRect(NSRect rect, NSRect compare) {
  return AZNormalizedDistanceOfRects(rect, compare).x <= -1;
}

BOOL AZIsRectRightOfRect(NSRect rect, NSRect compare) {
  return AZNormalizedDistanceOfRects(rect, compare).x >= 1;
}

BOOL AZIsRectAboveRect(NSRect rect, NSRect compare) {
  return AZNormalizedDistanceOfRects(rect, compare).y <= -1;
}

BOOL AZIsRectBelowRect(NSRect rect, NSRect compare) {
  return AZNormalizedDistanceOfRects(rect, compare).y >= 1;
}

//
// EOF
//

#import "math.h"

//BTFloatRange BTMakeFloatRange(float value,float location,float length){
//    BTFloatRange fRange;
//    fRange.value=value;
//    fRange.location=location;
//    fRange.length=length;
//    return fRange;
//}
//float BTFloatRangeMod(BTFloatRange range){
//    return fmod(range.value-range.location,range.length)+range.location;
//}
//
//float BTFloatRangeUnit(BTFloatRange range){
//    return (range.value-range.location)/range.length;
//}

NSPoint offsetPoint(NSPoint fromPoint, NSPoint toPoint){
    return NSMakePoint(toPoint.x-fromPoint.x,toPoint.y-fromPoint.y);
}
/*
int oppositeQuadrant(int quadrant){
    quadrant=quadrant+2;
    quadrant%=4;
    if (!quadrant)quadrant=4;
    return quadrant;
}
*/
NSPoint rectOffset(NSRect innerRect,NSRect outerRect, NSInteger quadrant){
    if (quadrant)
        return NSMakePoint((quadrant == 3 || quadrant == 2) ? NSMaxX(outerRect)-NSMaxX(innerRect) : NSMinX(outerRect)-NSMinX(innerRect),
                           (quadrant == 4 || quadrant == 3) ? NSMaxY(outerRect)-NSMaxY(innerRect) : NSMinY(outerRect)-NSMinY(innerRect));
    return NSMakePoint(NSMidX(outerRect)-NSMidX(innerRect),NSMidY(outerRect)-NSMidY(innerRect)); //Center Rects
}
/*
NSRect alignRectInRect(NSRect innerRect,NSRect outerRect,int quadrant){
    NSPoint offset=rectOffset(innerRect,outerRect,quadrant);
    return NSOffsetRect(innerRect,offset.x,offset.y);
}




NSRect rectZoom(NSRect rect,float zoom,int quadrant){
    NSSize newSize=NSMakeSize(NSWidth(rect)*zoom,NSHeight(rect)*zoom);
    NSRect newRect=rect;
    newRect.size=newSize;
    return newRect;
}
*/

NSRect sizeRectInRect(NSRect innerRect,NSRect outerRect,bool expand){
    float proportion=NSWidth(innerRect)/NSHeight(innerRect);
    NSRect xRect=NSMakeRect(0,0,outerRect.size.width,outerRect.size.width/proportion);
    NSRect yRect=NSMakeRect(0,0,outerRect.size.height*proportion,outerRect.size.height);
    NSRect newRect;
    if (expand) newRect = NSUnionRect(xRect,yRect);
    else newRect = NSIntersectionRect(xRect,yRect);
    return newRect;
}

NSRect fitRectInRect(NSRect innerRect,NSRect outerRect,bool expand){
    return centerRectInRect(sizeRectInRect(innerRect,outerRect,expand),outerRect);
}
/*
NSRect rectWithProportion(NSRect innerRect,float proportion,bool expand){
    NSRect xRect=NSMakeRect(0,0,innerRect.size.width,innerRect.size.width/proportion);
    NSRect yRect=NSMakeRect(0,0,innerRect.size.height*proportion,innerRect.size.height);
    NSRect newRect;
    if (expand) newRect = NSUnionRect(xRect,yRect);
    else newRect = NSIntersectionRect(xRect,yRect);
    return newRect;
}
*/
NSRect centerRectInRect(NSRect rect, NSRect mainRect){
    return NSOffsetRect(rect,NSMidX(mainRect)-NSMidX(rect),NSMidY(mainRect)-NSMidY(rect));
}

NSRect constrainRectToRect(NSRect innerRect, NSRect outerRect){
    NSPoint offset=NSZeroPoint;
    if (NSMaxX(innerRect) > NSMaxX(outerRect))
        offset.x+= NSMaxX(outerRect) - NSMaxX(innerRect);
    if (NSMaxY(innerRect) > NSMaxY(outerRect))
        offset.y+= NSMaxY(outerRect) - NSMaxY(innerRect);
    if (NSMinX(innerRect) < NSMinX(outerRect))
        offset.x+= NSMinX(outerRect) - NSMinX(innerRect);
    if (NSMinY(innerRect) < NSMinY(outerRect))
        offset.y+= NSMinY(outerRect) - NSMinY(innerRect);
    return NSOffsetRect(innerRect,offset.x,offset.y);
}
/*
NSRect expelRectFromRect(NSRect innerRect, NSRect outerRect,float peek){
    NSPoint offset=NSZeroPoint;
    
    float leftDistance=NSMaxX(innerRect) - NSMinX(outerRect);
    float rightDistance=NSMaxX(outerRect)-NSMinX(innerRect);
    float topDistance=NSMaxY(outerRect)-NSMinY(innerRect);
    float bottomDistance=NSMaxY(innerRect) - NSMinY(outerRect);
    float minDistance=MIN(MIN(MIN(leftDistance,rightDistance),topDistance),bottomDistance);
    
    if (minDistance==leftDistance)
        offset.x-=leftDistance-peek;
    else if (minDistance==rightDistance)
        offset.x+=rightDistance-peek;
    else if (minDistance==topDistance)
        offset.y+=topDistance-peek;
    else if (minDistance==bottomDistance)
        offset.y-=bottomDistance-peek;
    
    return NSOffsetRect(innerRect,offset.x,offset.y);
}

NSRect expelRectFromRectOnEdge(NSRect innerRect, NSRect outerRect,NSRectEdge edge,float peek){
    NSPoint offset=NSZeroPoint;
    
    switch(edge){
        case NSMaxXEdge:
            
            offset.x+=NSMaxX(outerRect)-NSMinX(innerRect)-peek;
            break;
        case NSMinXEdge:
            offset.x-=NSMaxX(innerRect) - NSMinX(outerRect) - peek;
            break;
        case NSMaxYEdge:
            offset.y+=NSMaxY(outerRect)-NSMinY(innerRect)-peek;
            break;
        case NSMinYEdge:
            offset.y-=NSMaxY(innerRect) - NSMinY(outerRect)-peek;
            break;
    }

    return NSOffsetRect(innerRect,offset.x,offset.y);
}
*/
NSRectEdge touchingEdgeForRectInRect(NSRect innerRect, NSRect outerRect){
    
    if (NSMaxX(innerRect)>=NSMaxX(outerRect)) return NSMaxXEdge;
    else if (NSMinX(innerRect)<=NSMinX(outerRect)) return NSMinXEdge;
    else if (NSMaxY(innerRect)>=NSMaxY(outerRect)) return NSMaxYEdge;
    else if (NSMinY(innerRect)<=NSMinY(outerRect)) return NSMinYEdge;
    return -1;
}



NSRect rectFromSize(NSSize size){
    return NSMakeRect(0,0,size.width,size.height);
}

float distanceFromOrigin(NSPoint point){
    return hypot(point.x, point.y);
}
/*
int closestCorner(NSRect innerRect,NSRect outerRect){
    float bestDistance=-1;
    int closestCorner=0;
    int i;
    for(i=0;i<5;i++){
        float distance = distanceFromOrigin(rectOffset(innerRect,outerRect,i));
        if (distance < bestDistance || bestDistance<0){
            bestDistance=distance;
            closestCorner=i;
        }
    }
    return closestCorner;
}



NSRect blendRects(NSRect start, NSRect end,float b){
    
    return NSMakeRect(  round(NSMinX(start)*(1-b) + NSMinX(end)*b),
                        round(NSMinY(start)*(1-b) + NSMinY(end)*b),
                        round(NSWidth(start)*(1-b) + NSWidth(end)*b),
                        round(NSHeight(start)*(1-b) + NSHeight(end)*b));
}
*/
void logRect(NSRect rect){
//QSLog(@"(%f,%f) (%fx%f)",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
}


CGPoint randomPointInRect(CGRect rect) {

CGPoint point = CGPointZero;
NSInteger max = rect.size.width;
NSInteger min = 0;
point.x = (random() % (max-min+1)) + min;

max = rect.size.height;
point.y = (random() % (max-min+1)) + min;

return point;
}




AZWindowPosition AZPositionOfRect(NSRect rect) {

	if ( AZDistanceFromPoint( rect.origin, NSZeroPoint ) == 0 )
	return NSMaxX( rect ) == ScreenWidess() ? AZPositionBottom : AZPositionBottomLeft;
	else if (NSMinY(rect)==0)
		return AZPositionRight;
	else return AZPositionTop;
}

NSSize AZDirectionsOffScreenWithPosition(NSRect rect, AZWindowPosition position )
{
	CGFloat deltaX = position == AZPositionLeft 	?  -NSMaxX(rect)
	: position == AZPositionRight 	? 	NSMaxX(rect)	: 0;
	CGFloat deltaY = position == AZPositionTop 		?  NSMaxY(rect)
	: position == AZPositionBottom 	? -NSMaxY(rect)		: 0;

	return (NSSize){deltaX,deltaY};
}

