

//#import <Availability.h>
//#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED)
//#import <UIKit/UIKit.h>
//#define SM_USE_AV_AUDIO_PLAYER
//#else
//#if __MAC_OS_X_VERSION_MIN_REQUIRED > __MAC_10_6
//#define SM_USE_AV_AUDIO_PLAYER
//#endif
//#endif
//#ifdef SM_USE_AV_AUDIO_PLAYER
#define SM_USE_AV_AUDIO_PLAYER
#import <AVFoundation/AVFoundation.h>
#define SM_SOUND AVAudioPlayer
//#else
//#define SM_SOUND NSSound
//#endif

#import "AtoZUmbrella.h"

extern NSString *const SoundDidFinishPlayingNotification;

typedef void (^SoundCompletionHandler)(BOOL didFinish);

@interface Sound : NSObject

+ (INST)             randomSound;
+ (INST)              soundNamed:(NSS*)name;
+ (INST) soundWithContentsOfFile:(NSS*)path;
- (INST)  initWithContentsOfFile:(NSS*)path;
+ (INST)  soundWithContentsOfURL:(NSU*)url;
- (INST)   initWithContentsOfURL:(NSU*)url;

@property (RONLY,CP)                    NSS * name;
@property (RONLY)                       NSU * url;
@property (RONLY,getter = isPlaying)   BOOL   playing;
@property (NATOM,getter = isLooping)   BOOL   looping;
@property (NATOM,CP) SoundCompletionHandler   completionHandler;
@prop_NA                                CGF   baseVolume,
                                            volume;
- (void)   fadeTo:(CGF)volume
         duration:(NSTI)duration;
- (void)   fadeIn:(NSTI)duration;
- (void)  fadeOut:(NSTI)duration;
- (void)     play;
- (void)     stop;

@end
@interface SoundManager : BaseModel

@property (readonly, getter = isPlayingMusic) BOOL playingMusic;

@property (nonatomic) BOOL allowsBackgroundMusic;
@property (nonatomic)  CGF soundVolume, musicVolume;
@property (nonatomic) NSTI soundFadeDuration, musicFadeDuration;

+ (INST) sharedManager;

+ (NSA*) soundPaths;
+ (void) playRandomSound;

- (void) prepareToPlayWithSound:(id)soundOrName;
- (void) prepareToPlay;

- (void) playMusic:soundOrName looping:(BOOL)looping fadeIn:(BOOL)fadeIn;
- (void) playMusic:soundOrName looping:(BOOL)looping;
- (void) playMusic:soundOrName;

- (void) stopMusic:(BOOL)fadeOut;
- (void) stopMusic;

- (void) playSound:soundOrName looping:(BOOL)looping fadeIn:(BOOL)fadeIn;
- (void) playSound:soundOrName looping:(BOOL)looping;
- (void) playSound:soundOrName;

- (void) stopSound:soundOrName fadeOut:(BOOL)fadeOut;
- (void) stopSound:soundOrName;
- (void) stopAllSounds:(BOOL)fadeOut;
- (void) stopAllSounds;

@end

	//required for 32-bit Macs
//#ifdef __i386__
//{
//@private
//
//	Sound *currentMusic;
//	NSMutableArray *currentSounds;
//	BOOL allowsBackgroundMusic;
//	CGFloat soundVolume;
//	CGFloat musicVolume;
//	NSTimeInterval soundFadeDuration;
//	NSTimeInterval musicFadeDuration;
//}
//#endif
//	//required for 32-bit Macs
//#ifdef __i386__
//{
//@private
//
//	CGFloat baseVolume;
//	CGFloat startVolume;
//	CGFloat targetVolume;
//	NSTimeInterval fadeTime;
//	NSTimeInterval fadeStart;
//	NSTimer *timer;
//	Sound *selfReference;
//	NSURL *url;
//	SM_SOUND *sound;
//	SoundCompletionHandler completionHandler;
//}
//#endif
