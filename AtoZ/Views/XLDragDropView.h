//
//  XLDragDropView.h
//  XLDragDrop
//
//  Created by Richard Wei on 11-11-21.
//  Copyright (c) 2011 Xinranmsn Labs. All rights reserved.
//

@import AppKit;

@protocol DragDropViewDelegate;

@interface XLDragDropView : NSView <NSDraggingDestination> {
	NSString *_normalBackgroundImageName, *_highlightedBackgroundImageName, *_acceptedBackgroundImageName;
	NSImage *_normalBackgroundImage, *_highlightedBackgroundImage, *_acceptedBackgroundImage, *_currentBackgroundImage;
	NSString *_filePath;
	NSArray *_desiredSuffixes;
	BOOL _isFileReady;
}

@property (nonatomic, unsafe_unretained) IBOutlet id <DragDropViewDelegate> delegate;
@property (nonatomic) NSString *normalBackgroundImageName, *highlightedBackgroundImageName, *acceptedBackgroundImageName;
@property (readonly) NSString *filePath;
@property (nonatomic) NSArray *desiredSuffixes;
@property (readonly) BOOL isFileReady;

- (id)initWithFrame:(NSRect)frameRect normalBackgroundImageName:(NSString *)imageName;

@end

@protocol DragDropViewDelegate

@optional
- (void)dragDropViewWillDraw:(XLDragDropView *)dragDropView;
- (void)dragDropView:(XLDragDropView *)dragDropView didAcceptDroppedFile:(NSString *)filePath;
- (void)dragDropView:(XLDragDropView *)dragDropView didRefuseDroppedFile:(NSString *)filePath;

@end
