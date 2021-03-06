//#import AtoZAutoBox
//- (void) openCardAtIndex:(NSUI)@index;
//+ (instancetype) instanceWithImage:(NSIMG*)img imageID:(NSS*)imgID andImageSubTitle:(NSS*) subT andPersonUID:(NSS*)pUID;

#import "AtoZUmbrella.h"

@protocol    AZDataSource <NSTableViewDataSource>
- (id)     contactAtIndex:(NSUI)i;
- (NSA*)	contactsInRange:(NSRange)r;
- (NSUI) numberOfContacts;
@end

@interface AtoZContact : BaseModel

@prop_RO	 BOOL   hasImage;
@property  BOOL   cached;
@prop_NC 	NSIMG * image;
@prop_RO 	  NSS * fullName;
@prop_NC 	  NSS * firstName,
                * lastName,
                * company,
                * tel;
@end

@interface AtoZContacts : AtoZSingleton <AZDataSource> - (id) find:(id)sender;
@end

@interface   AtoZContacts (Proxied)
+ (NSA*)	contactsInRange:(NSRange)r;
+ (NSA*)    contactImages;
+ (NSA*)         contacts;
@end

