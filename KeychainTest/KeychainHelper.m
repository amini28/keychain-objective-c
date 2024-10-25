//
//  KeychainHelper.m
//  KeychainTest
//
//  Created by Amini on 25/10/24.
//

#import "KeychainHelper.h"

@implementation KeychainHelper

+ (instancetype)shared {
    static KeychainHelper *sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (BOOL) saveObject:(NSString*)stringData forKey:(NSString*)key {
    NSData *data = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *query = @{
            (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
            (__bridge id)kSecAttrAccount: key,
            (__bridge id)kSecValueData: data,
            (__bridge id)kSecAttrAccessible: (__bridge id)kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        };
        
    // Delete any existing item
    SecItemDelete((__bridge CFDictionaryRef)query);
    
    // Add new item to Keychain
    return [self checkOSSStatus: SecItemAdd((__bridge CFDictionaryRef)query, NULL)];
}

- (NSString*) loadObjectForKey:(NSString*)key {
    NSDictionary *query = @{
           (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
           (__bridge id)kSecAttrAccount: key,
           (__bridge id)kSecReturnData: @YES,
           (__bridge id)kSecMatchLimit: (__bridge id)kSecMatchLimitOne
       };
       
       CFTypeRef dataTypeRef = NULL;
       OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &dataTypeRef);
       
       if (status == errSecSuccess) {
           NSData *data = (__bridge NSData *)dataTypeRef;
           if (data) {
               NSString *returnData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
               return returnData;
           }
           return nil;
       }
   return nil;
}
- (BOOL) deleteObjectForKey:(NSString*)key {
    NSDictionary *query = @{
            (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
            (__bridge id)kSecAttrAccount: key
        };
        
    return [self checkOSSStatus: SecItemDelete((__bridge CFDictionaryRef)query)];
}

- (BOOL) checkOSSStatus:(OSStatus) state {
    return state == noErr;
}


@end
