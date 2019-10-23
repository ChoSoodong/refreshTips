






#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDNoticeHUD : UIView


/**
 下拉刷新,显示新数据的条数

 @param text 显示内容
 @param controller 父控制器
 */
+(void)showText:(NSString *)text AtController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
