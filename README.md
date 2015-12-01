# BHRDateFormatter
输入时间，根据距离今天的长短，输出  昨天、今天 或者明天，还是周几，或者几月几号


###使用场景

一般在UITableViewCell中显示时间，例如订单时间

- 一小时以内，显示 `“XX分钟之前”`   `“XX分钟之后”`

- 一天以内   显示 `“今天 xx:xx”`

- 一天以外	
	
	- 相隔一天  `“昨天 xx:xx”  "后天 xx:xx"`
	- 不止一天  `“xx月xx日”`

- 一年以外  显示 `“xxxx年xx月xx日”`


###使用说明

```
#import "NSString+BHRDateFormatter.h"
---------
NSString *nowDate = @"2015/01/01 10:10";
NSString *inputDate = @"2015/01/02 09:10";

NSSting *outputDateStr = [inputDate transformWithFormate:@"YYYY/MM/dd HH:mm"];
NSLog(@"%@",outputDateStr)
---------
输出结果：明天 09:10
```

