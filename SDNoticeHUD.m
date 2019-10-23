





#import "SDNoticeHUD.h"

#define KScreenW [UIScreen mainScreen].bounds.size.width
//状态栏高度
#define KStatusBarH [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏高度
#define KNavH (44 + KStatusBarH)
//颜色
#define KColorRGB(r,g,b) [UIColor colorWithRed:(r/ 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1.0]

@interface SDNoticeHUD()

/** 文字 */
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation SDNoticeHUD

-(instancetype)initWithText:(NSString *)text{
    if (self = [super init]) {
        
        self.alpha = 0;
        self.backgroundColor = KColorRGB(238, 157, 71);
        
        //文字字体
        UIFont *textFont = [UIFont systemFontOfSize:14];
        
        //计算文字的尺寸
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(KScreenW*0.8, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : textFont} context:nil].size;
        
        CGFloat viewW = textSize.width + 30;
        CGFloat viewH = textSize.height + 10;
        CGFloat viewX = (KScreenW - viewW) * 0.5;
        CGFloat viewY = KNavH-viewH;
        self.frame = CGRectMake(viewX, viewY, viewW, viewH);
        
        self.layer.cornerRadius = self.frame.size.height *0.5;
        self.layer.masksToBounds = YES;
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = textFont;
        _textLabel.text = text;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        [self addSubview:_textLabel];
        

    }
    return self;
}

+(void)showText:(NSString *)text AtController:(UIViewController *)controller{
    
    //先删除
    for (UIView *view in controller.navigationController.view.subviews) {
        if ([view isKindOfClass:[SDNoticeHUD class]]) {
            [view removeFromSuperview];
        }
    }
    
    //再创建
    SDNoticeHUD *hud = [[SDNoticeHUD alloc] initWithText:text];
    [controller.navigationController.view insertSubview:hud belowSubview:controller.navigationController.navigationBar];
 
    //显示
    [UIView animateWithDuration:0.25 animations:^{
        
        hud.alpha = 1;
        hud.frame = CGRectMake(hud.frame.origin.x, KNavH+20, hud.frame.size.width, hud.frame.size.height);
    
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [hud hide];
        });
        
    }];
    
    
    
}

-(void)hide{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, KNavH-self.frame.size.height, self.frame.size.width, self.frame.size.height);
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
