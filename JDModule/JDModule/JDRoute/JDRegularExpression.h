//
//  JDRegularExpression.h
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDMatchResult.h"
/**
 这个对象是regularExpression,它可以匹配一个url与JDMatchResult对象并返回结果。
 */
@interface JDRegularExpression : NSRegularExpression

/**
 该方法返回一个JDMatchResult对象检查url字符串相匹配。
 */

- (JDMatchResult *)matchResultForString:(NSString *)string;

+ (JDRegularExpression *)expressionWithPattern:(NSString *)pattern;

@end
