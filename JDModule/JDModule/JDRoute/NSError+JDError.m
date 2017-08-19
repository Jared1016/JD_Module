//
//  NSError+JDError.m
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import "NSError+JDError.h"
NSString *constJDErrorDomain = @"com.jdroute.error";
@implementation NSError (JDError)

+ (NSError *)JDNotFoundError{
    return [self JDErrorWithCode:JDErrorNotFound msg:@"The passed URL does not match a registered route."];
}

+ (NSError *)JDTransitionError{
    return [self JDErrorWithCode:JDErrorHandlerTargetOrSourceViewControllerNotSpecified msg:@"TargetViewController or SourceViewController not correct"];
}

+ (NSError *)JDHandleBlockNoReturnRequest{
    return [self JDErrorWithCode:JDErrorBlockHandleNoReturnRequest msg:@"Block handle no turn JDRouteRequest object"];
}

+ (NSError *)JDMiddlewareRaiseErrorWithMsg:(NSString *)error{
    return [self JDErrorWithCode:JDErrorMiddlewareRaiseError msg:[NSString stringWithFormat:@"JDRouteMiddle raise a error:%@", error]];
}


+ (NSError *)JDErrorWithCode:(NSInteger)code msg:(NSString *)msg{
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(msg, nil)};
    return [NSError errorWithDomain:constJDErrorDomain code:code userInfo:userInfo];
}


@end
