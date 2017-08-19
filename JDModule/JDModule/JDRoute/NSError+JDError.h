//
//  NSError+JDError.h
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, JDError) {
    
    /** The passed URL does not match a registered route. */
    JDErrorNotFound = 45150,
    
    /** The matched route handler does not specify a target view controller. */
    JDErrorHandlerTargetOrSourceViewControllerNotSpecified = 45151,
    JDErrorBlockHandleNoReturnRequest = 45152,
    JDErrorMiddlewareRaiseError = 45153
};
@interface NSError (JDError)

+ (NSError *)JDNotFoundError;
+ (NSError *)JDTransitionError;
+ (NSError *)JDHandleBlockNoReturnRequest;
+ (NSError *)JDMiddlewareRaiseErrorWithMsg:(NSString *)error;

@end
