//
//  JDMatchResult.h
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 该对象是一个url是否匹配的结果对象，paramProperties字典包含了url上的匹配参数。
 */
@interface JDMatchResult : NSObject

/**
 If matched,value is YES.
 */
@property (nonatomic, assign, getter=isMatch) BOOL match;

/**
 如果匹配成功，url路径中的关键字对应的值将存储在该字典中.
 */
@property (nonatomic, strong) NSDictionary *paramProperties;

@end
