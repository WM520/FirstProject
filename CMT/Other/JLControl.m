//
//  JLControl.m
//  BigPrivateSchool
//
//  Created by 沈家林 on 15/9/29.
//  Copyright (c) 2015年 沈家林. All rights reserved.
//

#import "JLControl.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Extension.h"
//#define IOS7   [[UIDevice currentDevice]systemVersion].floatValue>=7.0

@implementation JLControl



+ (void)cancelWebCache
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])  {
        [storage deleteCookie:cookie];
    }
}
+ (NSString *)calculateCacheSize {
    NSString *cacheSizeStr;
    
    // 获取图片缓存大小的方法
    NSUInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
    if (cacheSize < 1024) {
        cacheSizeStr = [NSString stringWithFormat:@"%lu B", cacheSize];
    } else if (cacheSize >= 1024 && cacheSize < 1024 * 1024) {
        cacheSizeStr = [NSString stringWithFormat:@"%.2f KB", cacheSize / 1024.0];
    } else if (cacheSize >= 1024 * 1024 && cacheSize < 1024 * 1024 * 1024) {
        cacheSizeStr = [NSString stringWithFormat:@"%.2f MB", cacheSize / (1024.0 * 1024)];
    } else {
        cacheSizeStr = [NSString stringWithFormat:@"%.2f GB", cacheSize / (1024.0 * 1024 * 1024)];
    }
    
    return cacheSizeStr;
}
+ (BOOL)checkPhoneNumber:(NSString *)str
{
    NSString *regex = @"^(1)\\d{10}$";
    NSPredicate *phonenum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [phonenum evaluateWithObject:str];
}

+ (void)saveLocalData:(id)obj forKey:(NSString *)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeLocalData:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getLocalData:(NSString *)key
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}



+ (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0 , 0, newSize.width, newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}



+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}


+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize

{
    
    return [JLControl labelAutoCalculateRectWith:text Font:[UIFont systemFontOfSize:fontSize] MaxSize:maxSize];
    
}

+ (CGSize)labelAutoCalculateRectWith:(NSString*)text Font:(UIFont *)font MaxSize:(CGSize)maxSize

{
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    
    if (!font||!text) {
        return  CGSizeMake(0, 0);
    }
    NSDictionary* attributes =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    labelSize.height=ceil(labelSize.height);
    labelSize.width=ceil(labelSize.width);
    return labelSize;
    
}

+ (BOOL)isNumber:(NSString*)string{
    if (string.length>0) {
        NSScanner* scan = [NSScanner scannerWithString:string];
        int val;
        return[scan scanInt:&val] && [scan isAtEnd];
    }else{
        return NO;
    }
}
+ (BOOL)isNumberAndString:(NSString*)string{
    if (string.length>0) {
        for (NSInteger i=0; i<string.length; i++) {
            NSInteger a=[string characterAtIndex:i];
            if (!((a>='0'&&a<='9')||(a>='a'&&a<='z')||(a>='A'&&a<='Z'))) {
                return NO;
            }
        }
        return YES;
    }else{
        return NO;
    }

}

+ (BOOL)isContainChinese:(NSString*)string{
    if (string.length>0) {
        for (NSInteger i=0; i<string.length; i++) {
            NSInteger a=[string characterAtIndex:i];
            //汉字编码区间
            if (a>0x4e00&&a<0x9fff) {
                return YES;
            }
        }
        return NO;
    }else{
        return NO;
    }
}

/**
 *42:控件Label创建
 */
#pragma mark 控件Label创建
+(UILabel *)createLabelWithFrame:(CGRect)frame withText:(NSString *)text withIsLineBreak:(BOOL)isLineBreak{
    
    return [JLControl createLabelWithFrame:frame withText:text withFontSize:14 withTextColor:[UIColor grayColor] withTextAlignment:NSTextAlignmentLeft withIsLineBreak:isLineBreak];
}



+(UILabel *)createLabelWithFrame:(CGRect)frame withText:(NSString *)text{
    
    return [JLControl createLabelWithFrame:frame withText:text withFontSize:14];
}


+(UILabel *)createLabelWithFrame:(CGRect)frame withText:(NSString *)text withFontSize:(CGFloat)size{
    
    return [JLControl createLabelWithFrame:frame withText:text withFontSize:size withTextColor:[UIColor grayColor]];
}


+(UILabel *)createLabelWithFrame:(CGRect)frame withText:(NSString *)text withFontSize:(CGFloat)size withTextColor:(UIColor *)color{
    
    return [JLControl createLabelWithFrame:frame withText:text withFontSize:size withTextColor:color withTextAlignment:NSTextAlignmentLeft];
}

+(UILabel *)createLabelWithFrame:(CGRect)frame withText:(NSString *)text withFontSize:(CGFloat)size withTextColor:(UIColor *)color withTextAlignment:(NSTextAlignment)textAlignment{
    
    return [JLControl createLabelWithFrame:frame withText:text withFontSize:size withTextColor:color withTextAlignment:textAlignment withIsLineBreak:NO];
}

+(UILabel *)createLabelWithFrame:(CGRect )frame withText:(NSString *)text withFontSize:(CGFloat )size withTextColor:(UIColor *)color withTextAlignment:(NSTextAlignment)textAlignment withIsLineBreak:(BOOL)isLineBreak{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = color;
    label.textAlignment = textAlignment;
    
    if (isLineBreak) {
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return label;
}

/**
 *44:控件Button创建
 */
#pragma mark 控件Button创建
+(UIButton *)createButtonWithFrame:(CGRect)frame withTitle:(NSString *)title withTarget:(id)target action:(SEL)action{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    UIImage *image = [ UIImage imageNamed:@"Detail_btn_middle.png"];
    //图片水平方向以y=image.size.height/2.0  这条线copy图片 竖直方向以mage.size.width/2.0 这条线copy图片
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2.0 topCapHeight:image.size.height/2.0];
    
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
}


/**
 *46:控件UIImageView创建
 */
#pragma mark 控件UIImageView创建

+(UIImageView *)createImageViewWithFrame:(CGRect)frame withImageName:(NSString *)imageName{
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}



+ (UIBarButtonItem *)createItemWithTitle:(NSString *)title backgroundImage:(NSString *)imageName target:(id)target sel:(SEL)sel {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 30);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithResizeImageName:imageName] forState:UIControlStateNormal];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cateBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return cateBtn;
}


@end
