//
//  UIViewController+JDRoute.m
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import "UIViewController+JDRoute.h"
#import <objc/runtime.h>

@implementation UIViewController (JDRoute)

- (JDRouteRequest *)jd_request{
    JDRouteRequest *dict = objc_getAssociatedObject(self, @"jd_request");
    return dict;
}

- (void)setJd_request:(JDRouteRequest *)jd_request{
    objc_setAssociatedObject(self, @"jd_request", jd_request, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load{
    [self exchangeMethodWithClass:[self class] originalSelector:sel_getUid("viewDidDisappear:") swizzledSelector:@selector(jd_viewDidDisappearSwzzled:)];
}

-(void)jd_viewDidDisappearSwzzled:(BOOL)animated{
    NSLog(@"jd_viewDidDisappearSwzzled");
    if (self.jd_request != nil && self.jd_request.isConsumed == NO) {
        [self.jd_request defaultFinishTargetCallBack];
    }
    self.jd_request = nil;
    [self jd_viewDidDisappearSwzzled:animated];
}


+(void)exchangeMethodWithClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    /*
     如果这个类没有实现 originalSelector ，但其父类实现了，那 class_getInstanceMethod 会返回父类的方法。这样 method_exchangeImplementations 替换的是父类的那个方法，这当然不是你想要的。所以我们先尝试添加 orginalSelector ，如果已经存在，再用 method_exchangeImplementations 把原方法的实现跟新的方法实现给交换掉。
     */
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

@end
