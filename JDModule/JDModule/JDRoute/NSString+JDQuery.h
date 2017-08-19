//
//  NSString+JDQuery.h
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (JDQuery)

+ (NSString *)JDQueryStringWithParameters:(NSDictionary *)parameters;
- (NSDictionary *)JDParametersFromQueryString;
- (NSString *)JDStringByAddingPercentEscapesUsingEncoding:(NSStringEncoding)encoding;
- (NSString *)JDStringByReplacingPercentEscapesUsingEncoding:(NSStringEncoding)encoding;

@end
