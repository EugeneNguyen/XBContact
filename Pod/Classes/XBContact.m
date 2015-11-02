//
//  XBContact.m
//  Pods
//
//  Created by Binh Nguyen Xuan on 11/2/15.
//
//

#import "XBContact.h"

@implementation XBContact

#pragma mark - Static method

+ (ABAddressBookRef)requestAuthentication:(ABAddressBookRequestAccessCompletionHandler)completion
{
    ABAddressBookRef addressBook =  ABAddressBookCreateWithOptions(NULL, NULL);
    if (!addressBook)
    {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    }
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    switch (status)
    {
        case kABAuthorizationStatusNotDetermined:
            ABAddressBookRequestAccessWithCompletion(addressBook, completion);
            break;
        case kABAuthorizationStatusRestricted:
            completion(NO, nil);
            break;
        case kABAuthorizationStatusDenied:
            completion(NO, nil);
            break;
        case kABAuthorizationStatusAuthorized:
            completion(YES, nil);
            break;
            
        default:
            break;
    }
    return addressBook;
}

+ (NSArray *)allPureContact
{
    NSMutableArray* contactList = [NSMutableArray array];
    
    CFErrorRef *error = nil;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFMutableArrayRef peopleMutable = CFArrayCreateMutableCopy(kCFAllocatorDefault,
                                                               CFArrayGetCount(people),
                                                               people);
    
    CFArraySortValues(peopleMutable,
                      CFRangeMake(0, CFArrayGetCount(peopleMutable)),
                      (CFComparatorFunction) ABPersonComparePeopleByName,
                      kABPersonSortByFirstName);
    
    CFRelease(people);
    for (CFIndex i = 0; i <CFArrayGetCount(peopleMutable); i++)
    {
        ABRecordRef record = CFArrayGetValueAtIndex(peopleMutable, i);
        [contactList addObject:(__bridge id _Nonnull)(record)];
        
        CFRelease(record);
    }
    return contactList;
}

@end
