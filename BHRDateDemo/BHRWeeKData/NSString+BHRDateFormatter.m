//
//  NSString+BHRDateFormatter.m
//  BHRDateDemo
//
//  Created by Daocaoren on 15/12/1.
//  Copyright © 2015年 Daocaoren. All rights reserved.
//

#import "NSString+BHRDateFormatter.h"

@implementation NSString (BHRDateFormatter)

/**
 /// 和当前时间比较
 ///   1）1分钟以内 显示        :    刚刚
 ///   2）1小时以内 显示        :    X分钟前
 ///   3）今天或者昨天 显示      :    今天 09:30   昨天 09:30
 ///   4) 今年显示              :   09月12日
 ///   5) 大于本年      显示    :    2013/09/09
 **/




+ (NSString *)weekFormateDate:(NSString *)dateString withFormate:(NSString *) formate{
    
    @try {
        
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formate];
        
        NSDate * nowDate = [NSDate date];
        NSTimeInterval secondsPerDay = 24 * 60 * 60;
        NSDate *tomorrow, *yesterday;
        
        tomorrow = [nowDate dateByAddingTimeInterval: secondsPerDay];
        yesterday = [nowDate dateByAddingTimeInterval: -secondsPerDay];
        
        
        /////  将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        /////  取当前时间和转换时间两个日期对象的时间间隔
        /////  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        
        //// 再然后，把间隔的秒数折算成天数和小时数：
        
        NSString *dateStr = dateString;
        
        // 计算星期
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        unsigned int unitFlags = NSWeekdayCalendarUnit;
        NSDateComponents *comps = [gregorian components:unitFlags fromDate:needFormatDate];
        int week = [comps weekday]; //日期转换为一周的第几天，默认第一天周日
        NSString * weekdate = [[NSString alloc]init];
        switch (week) {
            case 1:
                weekdate =  @"日";
                break;
            case 2:
                weekdate = @"一";
                break;
            case 3:
                weekdate = @"二";
                break;
            case 4:
                weekdate = @"三";
                break;
            case 5:
                weekdate = @"四";
                break;
            case 6:
                weekdate = @"五";
                break;
            case 7:
                weekdate = @"六";
                break;
            default:
                break;
        }
        
        [dateFormatter setDateFormat:@"YYYY/MM/dd"];
        NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
        
        NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
        NSString *tomorrow_yMd = [dateFormatter stringFromDate:tomorrow];
        NSString *yesterday_yMd = [dateFormatter stringFromDate:yesterday];
        
        if ([need_yMd isEqualToString:now_yMd]) {
            [dateFormatter setDateFormat:@"HH:mm"];
            dateStr = [NSString stringWithFormat:@"今天(星期%@) %@",weekdate,[dateFormatter stringFromDate:needFormatDate]];
        }else if ([need_yMd isEqualToString:tomorrow_yMd]){
            [dateFormatter setDateFormat:@"HH:mm"];
            dateStr = [NSString stringWithFormat:@"明天(星期%@) %@",weekdate,[dateFormatter stringFromDate:needFormatDate]];
            
        }else if([need_yMd isEqualToString:yesterday_yMd]){
            [dateFormatter setDateFormat:@"HH:mm"];
            dateStr = [NSString stringWithFormat:@"昨天(星期%@) %@",weekdate,[dateFormatter stringFromDate:needFormatDate]];
        }else{
            return dateStr;
        }
        
        return dateStr;
    }
    
    @catch (NSException *exception) {
        return @"";
    }
    
}

- (NSString *)weekWithFormate:(NSString *) formate{
    NSString * weekStr = [NSString weekFormateDate:self withFormate:formate];
    return weekStr;
}


- (NSString *)transformWithFormate:(NSString *) formate{
    NSString * dateStr = [NSString formateDate:self withFormate:formate];
    return dateStr;
}


+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate
{
    
    @try {
        
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formate];
        
        NSDate * nowDate = [NSDate date];
        NSTimeInterval secondsPerDay = 24 * 60 * 60;
        NSDate *tomorrow, *yesterday;
        tomorrow = [nowDate dateByAddingTimeInterval: secondsPerDay];
        yesterday = [nowDate dateByAddingTimeInterval: -secondsPerDay];
        
        
        
        /////  将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        /////  取当前时间和转换时间两个日期对象的时间间隔
        /////  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        
        //// 再然后，把间隔的秒数折算成天数和小时数：
        
        NSString *dateStr = @"";
        
        if (time<=0 && time>= -60) {  //// 1分钟以内的
            dateStr = @"即将";
        }else if(time <= -60 && time >= -60*60  ){  ////  一个小时以内的
            
            int mins = -time/60;
            dateStr = [NSString stringWithFormat:@"%d分钟后",mins];
            
        }else if(time <= -60*60 && time >= - 60*60*24){   //// 在两天内的
            
            [dateFormatter setDateFormat:@"YYYY/MM/dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }else{
                ////  昨天
                dateStr = [NSString stringWithFormat:@"明天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }
            
        }else if(time <= - 60*60*24){
            
            NSDateFormatter * dateFormatteradd = [[NSDateFormatter alloc]init];
            [dateFormatteradd setDateFormat:@"YYYY/MM/dd"];
            NSString * need_yMd = [dateFormatteradd stringFromDate:needFormatDate];
            NSString *tomorrow_yMd = [dateFormatteradd stringFromDate:tomorrow];
            
            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([need_yMd isEqualToString:tomorrow_yMd]) {
                [dateFormatter setDateFormat:@"HH:mm"];
                dateStr = [NSString stringWithFormat:@"明天 %@",[dateFormatter stringFromDate:needFormatDate]];
                
            }else if ([yearStr isEqualToString:nowYear]) {
                ////  在同一年
                [dateFormatter setDateFormat:@"MM月dd日"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }else{
                [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
                
            }
            
            
        }else if (time>=0 && time<=60) {  //// 1分钟以内的
            dateStr = @"刚刚";
        }else if(time>=60 && time<=60*60){  ////  一个小时以内的
            
            int mins = time/60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
            
        }else if(time>=60*60 &&time<=60*60*24){   //// 在两天内的
            
            [dateFormatter setDateFormat:@"YYYY/MM/dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }else{
                ////  昨天
                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }
        }else {
            
            
            NSDateFormatter * dateFormatteradd = [[NSDateFormatter alloc]init];
            [dateFormatteradd setDateFormat:@"YYYY/MM/dd"];
            NSString * need_yMd = [dateFormatteradd stringFromDate:needFormatDate];
            NSString *yesterday_yMd = [dateFormatteradd stringFromDate:yesterday];
            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([need_yMd isEqualToString:yesterday_yMd]) {
                [dateFormatter setDateFormat:@"HH:mm"];
                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
                
            }else if ([yearStr isEqualToString:nowYear]) {
                ////  在同一年
                [dateFormatter setDateFormat:@"MM月dd日"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }else{
                [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
        
        return dateStr;
    }
    
    @catch (NSException *exception) {
        return @"";
    }
    
    
}
@end
