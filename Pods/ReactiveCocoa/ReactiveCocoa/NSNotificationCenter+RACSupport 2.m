//
//  NSNotificationCenter+RACSupport.m
//  ReactiveCocoa
//
//  Created by Josh Abernathy on 5/10/12.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "NSNotificationCenter+RACSupport.h"
#import "RACEXTScope.h"
#import "RACSignal.h"
#import "RACSubscriber.h"
#import "RACDisposable.h"

@implementation NSNotificationCenter (RACSupport)

- (RACSignal *)rac_addObserverForName:(NSString *)notificationName object:(id)object {
/**
 @unsafeify() 就是 __unsafe_unretained 在RAC中的宏，但是这种用法即使在RAC源码中出现的都极少，不过 __unsafe_unretained 对比 __weak 来说在性能会比较好。
 */
	@unsafeify(object);
	return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        /** .........*/
		@strongify(object);
		id observer = [self addObserverForName:notificationName object:object queue:nil usingBlock:^(NSNotification *note) {
			[subscriber sendNext:note];
		}];

		return [RACDisposable disposableWithBlock:^{
			[self removeObserver:observer];
		}];
	}] setNameWithFormat:@"-rac_addObserverForName: %@ object: <%@: %p>", notificationName, [object class], object];
}

@end
