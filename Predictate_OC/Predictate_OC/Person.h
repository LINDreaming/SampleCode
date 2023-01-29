//
//  Person.h
//  Predictate_OC
//
//  Created by 林喜 on 2023/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property(nonatomic,copy)NSString  * deparetMent;
@property(nonatomic,copy)NSString  * firstName;

- (NSArray *)personModelArray;

@end

NS_ASSUME_NONNULL_END
