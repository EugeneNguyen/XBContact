//
//  XBContact.h
//  Pods
//
//  Created by Binh Nguyen Xuan on 11/2/15.
//
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface XBContact : NSObject

+ (ABAddressBookRef)requestAuthentication:(ABAddressBookRequestAccessCompletionHandler)completion;
+ (NSArray *)allPureContact;

@end
