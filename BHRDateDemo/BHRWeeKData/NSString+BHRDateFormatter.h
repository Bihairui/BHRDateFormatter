//
//  NSString+BHRDateFormatter.h
//  BHRDateDemo
//
//  Created by Daocaoren on 15/12/1.
//  Copyright © 2015年 Daocaoren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BHRDateFormatter)
/// 获取当前星期
- (NSString *)weekWithFormate:(NSString *) formate;
/// 根据距离时间长短判断显示内容
- (NSString *)transformWithFormate:(NSString *) formate;
@end
