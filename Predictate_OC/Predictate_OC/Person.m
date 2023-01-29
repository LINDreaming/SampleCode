//
//  Person.m
//  Predictate_OC
//
//  Created by 林喜 on 2023/1/28.
//

#import "Person.h"

@implementation Person

- (NSArray *)personModelArray {
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSArray *names = @[@"nick",@"mat"];
    for (NSString *name in names) {
        Person *person = [[Person alloc]init];
        person.firstName = name;
        [mutableArray addObject:person];
    }
    return mutableArray;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@",self.firstName];
}

@end
