//
//  Predicate.m
//  Predictate_OC
//
//  Created by 林喜 on 2023/1/28.
//

#import "Predicate.h"
#import "Person.h"

@implementation Predicate

- (void)predecateEntry {
    /*
     [self predicateWithName];
     [self predicateWithBetween];
     [self evaluationAPredicate];
     [self predicateWithArrays];
     [self predicateWithKeyPaths];
     [self predicateWithNullValue];
     */
    [self predicateWithRegularExpressions];
}
- (void)predicateWithName {
    NSString *attributeName = @"firstName";
    NSString *atrributeValue = @"Adam";
    // the %K subtitution for a KeyPath, %@ subtitution for a value
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K like %@",attributeName,atrributeValue];
    
}

- (void)predicateWithBetween {
    NSPredicate *betweenPredicate = [NSPredicate predicateWithFormat:@"attributeName BETWEEN %@",@[@1,@10]];
    NSDictionary *dictionary = @{@"attributeName":@5};
    BOOL between = [betweenPredicate evaluateWithObject:dictionary];
    if (between) {
        NSLog(@"between");
    }
}

- (void)evaluationAPredicate {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF IN %@",@[@"Stig",@"Shaffiq",@"Chris"]];
    BOOL result = [predicate evaluateWithObject:@"Shaffiq"];
    // object must support key-value coding
    if (result) {
        NSLog(@"evaluate predicate success");
    }
}

// predicate with Arrays

- (void)predicateWithArrays {
    NSMutableArray *names = [@[@"Nick",@"Ben",@"Adam",@"Melissa"] mutableCopy];
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] 'b'"];
    NSArray *beginWithB = [names filteredArrayUsingPredicate:bPredicate];
    NSLog(@"beginWithB:%@",beginWithB);
    
    NSPredicate *ePredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] 'e'"];
    NSArray *containsE = [names filteredArrayUsingPredicate:ePredicate];
    NSLog(@"contains e:%@",containsE);
    
}

// using Predicates with Key-Paths

- (void)predicateWithKeyPaths {
    NSString *firstName = @"nick";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstName like %@",firstName];
    NSArray *array = [[[Person alloc]init] personModelArray];
    NSArray *matArray =  [array filteredArrayUsingPredicate:predicate];
    NSLog(@"matArray:%@",matArray);
}

- (void)predicateWithNullValue {
    NSString *firstName = @"Ben";
//    NSArray *array = @[@{@"lastName":@"Turner"}];
//    @{@"firstName":@"Ben",@"lastName":@"Ballard",@"birthday":[NSDate dateWithString:@"1972-03-24 10:45:32 +0600"]};
    NSArray *array = @[ @{@"lastName":@"Turner"},
                        @{ @"firstName" : @"Ben",
                           @"lastName"  : @"Ballard",
                           @"birthday"  : [NSDate dateWithString:@"1972-03-24 10:45:32 +0600"] } ];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstName like %@",firstName];
    NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
    NSLog(@"filtered Array:%@",filteredArray);
    
    // using greater than method
    NSDate *referenceDate = [NSDate dateWithTimeIntervalSince1970:0];
    predicate = [NSPredicate predicateWithFormat:@"birthday > %@",referenceDate];
    filteredArray = [array filteredArrayUsingPredicate:predicate];
    NSLog(@"filtered2 Array:%@",filteredArray);
    
   //  test for null value
    predicate = [NSPredicate predicateWithFormat:@"(firstName == %@) || (firstName = nil)",firstName];
    filteredArray = [array filteredArrayUsingPredicate:predicate];
    NSLog(@"filtered3 Array:%@",filteredArray);
    // test null result ok
    predicate = [NSPredicate predicateWithFormat:@"firstName = nil"];
    BOOL ok = [predicate evaluateWithObject:[NSDictionary dictionary]];
    // 打印的格式控制符号https://blog.csdn.net/liangliang2727/article/details/40652557
    NSLog(@"ok 1:%hhd",ok);
    ok = [predicate evaluateWithObject:[NSDictionary dictionaryWithObject:[NSNull null] forKey:@"firstName"]];
    NSLog(@"ok 2:%hhd",ok);
}

- (void)predicateWithRegularExpressions {
    NSArray *array = @[@"TATACCATGGGCCATCATCATCATCATCATCATCATCATCATCACAG",
                       @"CGGGATCCCTATCAAGGCACCTCTTCG", @"CATGCCATGGATACCAACGAGTCCGAAC",
                       @"CAT", @"CATCATCATGTCT", @"DOG"];
    
    /*
     正则表达式的处理，《linux 命令行与shell脚本编程大全》 428 页， 20章
     ^:脱字符，表示在行首页
     $:美元符，定义行尾锚点
     .:匹配任意单个字符
     []:定义一个字符组，[ch],其中的字符c和h是或的逻辑，c或者h
     [^]:表示过滤字符组中没有的字符
     [0-9]:-用来表示数据区间，区间也适用于字母如[a-z]; 也可以表示不连续的区间[a-ch-m];
     特殊字符组:如匹配任意字母字符，匹配任意字母数字字符，空格或者制表符，0-9，a-z, 任意可打印的字符，标答符号，大写的A-Z;
     *:a*,符号后面放*表示该符号出现一次或者多次；
    // 扩展正则表达式，ERE
     ？: 类似于*,b[ae]?t -> bt, 匹配前面的字符出现0次或者一次；
     +: 类似于*,匹配一次或者多次，至少出现一次；
     {m,n}: 至少出现m次，最多出现n次；
     ｜: 使用逻辑或的关系处理两种匹配模式
     (): 正则表达式的分组
     
*/
    //'.*(CAT){3,}(?!CA).*'
    NSPredicate *catPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES '.*(CAT){3,}(?!CA).*'"];
    NSArray *filteredArray = [array filteredArrayUsingPredicate:catPredicate];
    NSLog(@"filetered Array :%@",filteredArray);
    
    // ICU的正则表达方式
    NSArray *isbnTestArray = @[@"123456789X", @"987654321x", @"1234567890", @"12345X", @"1234567890X"];
    NSPredicate *isbnPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES '\\\\d{10}|\\\\d{9}[Xx]'"];
    NSArray *isbnArray = [isbnTestArray filteredArrayUsingPredicate:isbnPredicate];
    NSLog(@"filetered Array :%@",isbnArray);

    
}




@end
    
    
    
