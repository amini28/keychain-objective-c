//
//  KeychainHelper.h
//  KeychainTest
//
//  Created by Amini on 25/10/24.
//

#import <Foundation/Foundation.h>
#import "Security/Security.h"

NS_ASSUME_NONNULL_BEGIN

@interface KeychainHelper : NSObject

+ (instancetype)shared;

- (BOOL) saveObject:(NSString*)stringData forKey:(NSString*)key;
- (id) loadObjectForKey:(NSString*)key;
- (BOOL) deleteObjectForKey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
