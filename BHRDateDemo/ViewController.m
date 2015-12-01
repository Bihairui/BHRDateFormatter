//
//  ViewController.m
//  BHRDateDemo
//
//  Created by Daocaoren on 15/12/1.
//  Copyright © 2015年 Daocaoren. All rights reserved.
//

#import "ViewController.h"
#import "NSString+BHRDateFormatter.h"
@interface timeCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *outputDateLabel;
@property (nonatomic, weak) IBOutlet UILabel *inputDateLabel;
@end
@implementation timeCell
@end



@interface ViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *headerTimeLabel;
@property (weak, nonatomic) IBOutlet UITableView *mytableView;

@property (strong, nonatomic) NSString *todayStr;
@property (nonatomic, strong) NSMutableArray *dates;
@property (nonatomic, strong) NSMutableArray *outPutdates;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mytableView.dataSource = self;
    self.mytableView.rowHeight = 50;
    [self dateToday];
    
}
- (void)dateToday{
    NSDate * dateToday = [[NSDate alloc]init];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    NSString * nowStr = [dateFormatter stringFromDate:dateToday];
    self.todayStr = nowStr;
    self.headerTimeLabel.text = [NSString stringWithFormat:@"现在是 %@",self.todayStr];
    
    NSString * oneYearAgo = [dateFormatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:-60 *60 * 24 * 365]];
    [self.dates addObject:oneYearAgo];
    
    NSString * halfYearAgo = [dateFormatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:-60 *60 * 24 * 182]];
    [self.dates addObject:halfYearAgo];

    NSString * aWeekAgo = [dateFormatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:-60 *60 * 24 * 7]];
    [self.dates addObject:aWeekAgo];

    NSString * aDayAgo = [dateFormatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:-60 *60 * 24]];
    [self.dates addObject:aDayAgo];

    NSString * anHoureAgo = [dateFormatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:-60 *60 * 1]];
    [self.dates addObject:anHoureAgo];

    NSString * halfHoureAgo = [dateFormatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:-60 *30]];
    [self.dates addObject:halfHoureAgo];
    
    //////////////////////////////////////
    [self.dates addObject:self.todayStr];
    //////////////////////////////////////
    
    NSString * halfHoureLatter = [dateFormatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:60 *30]];
    [self.dates addObject:halfHoureLatter];
    
    NSString * anHoureLatter = [dateFormatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:60 *60 * 1.1]];
    [self.dates addObject:anHoureLatter];
    
    NSString * aDayLatter = [dateFormatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:60 *60 * 24]];
    [self.dates addObject:aDayLatter];
    
    NSString * aWeekLatter = [dateFormatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:60 *60 * 24 * 7]];
    [self.dates addObject:aWeekLatter];
    
    NSString * halfYearLatter = [dateFormatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:60 *60 * 24 * 182]];
    [self.dates addObject:halfYearLatter];
    
    NSString * oneYearLatter = [dateFormatter stringFromDate:[[NSDate date] dateByAddingTimeInterval:60 *60 * 24 * 365]];
    [self.dates addObject:oneYearLatter];
    
    [self changeDate];
    
}
-(NSMutableArray *)dates{
    if (!_dates) {
        _dates = [NSMutableArray array];
    }
    return _dates;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)changeDate{
    self.outPutdates = [NSMutableArray array];
    for (NSString * dateStr in self.dates) {
        [self.outPutdates addObject:[dateStr transformWithFormate:@"YYYY/MM/dd HH:mm"]];
    }
}

# pragma mark - UITableView.dataSource & UITbaleViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dates.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    timeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timeCell"];
    cell.inputDateLabel.text = [self.dates[indexPath.row] substringFromIndex:2];
    cell.outputDateLabel.text = self.outPutdates[indexPath.row];
    cell.userInteractionEnabled = NO;
    return cell;
}





@end
