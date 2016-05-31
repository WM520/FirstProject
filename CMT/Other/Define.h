//
//  Define.h
//  FavoriteLimit
//
//  Created by 沈家林 on 15/11/30.
//  Copyright (c) 2015年 沈家林. All rights reserved.
//
//注意：宏定义要勤打括号

#pragma mark 配置相关
#define KLEFTNAVBAR (@"left_navbar_item")
#define KRIGHTNACBAR (@"right_navbar_item")
#define KWS(weakSelf) __weak typeof(self) weakSelf =self
// 一般情况下把key定义成宏定义
#define KUMKEY @"5616741767e58e7aef001d54"


#pragma mark 颜色相关
#define KCOLORP(r,g,b,p) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:p*1.0]
#define KCOLOR(r,g,b) KCOLORP(r,g,b,1.0)
#define KTITLEVIEWCOL KCOLOR(40,146,226)
#define KLINECOLOR KCOLOR(158,158,159)
#define kColor [UIColor colorWithRed:0/255.0 green:117/255.0 blue:196/255.0 alpha:1]
#define KBackColor [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]
#define kdpBtnColor [UIColor colorWithRed:13/255.0 green:129/255.0 blue:250/255.0 alpha:1]
#define KSELECTED [UIColor colorWithRed:24/255.0 green:34/255.0 blue:50/255.0 alpha:1.0]


#pragma mark 屏幕尺寸相关
#define KSCREENWIDTH  ([UIScreen mainScreen].bounds.size.width)
#define KSCREENHEIGHT ([UIScreen mainScreen].bounds.size.height)
#define KRATE KSCREENWIDTH/320.0
#define kMargin 10.0f
#define KWidth_Scale    [UIScreen mainScreen].bounds.size.width/375.0f
#define kFont(size) [UIFont systemFontOfSize:size]

#pragma mark 请求的网址
//注意：1、每个网址都需要打注释 2、在开发中一般有两类网址，一种是测试环境下的网址，一种是开发中的网址，上线前一定要换好

// 1.首页头部

// 广告条url
#define AD_URL @"http://api.nanyibang.com/theme?type=2"
// 分栏
#define KHOMEHEADER @"http://api.nanyibang.com/theme?type=3"
// 活动精选
#define KHUODONGURL @"http://api.nanyibang.com/theme?type=4"

#define KHOMEITEM @"http://api.nanyibang.com/campaign?age=19&campaignId=0&campaignType=jingxuan&ios_version=9&page=1&version=1.3.5"
#define KDETAILURL @"http://api.nanyibang.com/items?age=19&height=170&ios_version=9&item_id=%ld&skin_type=2&style=1&version=1.3.5&weight=89"
#define KSOURCEURL @"http://api.nanyibang.com/score-comment?ios_version=9&item_id=%ld&version=1.3.5"
#define KYONUNGURL @"http://api.nanyibang.com/campaign?age=15&campaignId=0&campaignType=jingxuan&ios_version=9&page=1&version=1.3.5"
#define KOLDURL @"http://api.nanyibang.com/campaign?age=24&campaignId=0&campaignType=jingxuan&ios_version=9&page=1&version=1.3.5"
#define KNEWURL @"http://www.nanyibang.com/campaign/all_new.php?ids=%ld"
// dayily
#define KDayilyUrl @"http://api.nanyibang.com/daily-classify?daily_count=6&ios_version=9&version=1.3.5"
#define KDayilyDetailUrl @"http://api.nanyibang.com/daily-items?ios_version=9&kind_id=%ld&page=%ld&selectType=default&version=1.3.5"

#define KDayWearUrl @"http://api.nanyibang.com/match-today?administrativeArea=%E4%B8%8A%E6%B5%B7%E5%B8%82&country=%E4%B8%AD%E5%9B%BD&ios_version=9&locality=%E4%B8%8A%E6%B5%B7%E5%B8%82&version=1.3.5"

// 3.搭配
#define KCOLUMNSURL @"http://api.nanyibang.com/match-classify?ios_version=9&version=1.3.5"

#define KITEMURL @"http://api.nanyibang.com/match-list?ios_version=9&page=%ld&version=1.3.5/"
//搭配分类
#define DAPEI_CATEGORY @"http://api.nanyibang.com/match-classify"
//
#define KGROUPDETAIL @"http://api.nanyibang.com/match-detail?collocation_id=%ld&ios_version=9&version=1.3.5"
// 4.发现
#define KJingPinXiaoJie1 @"http://api.nanyibang.com/campaign?campaignId=2&campaignType=9.9&page=%ld&system_name=android&versionCode=190"

#define KJingPinXiaoJie2 @"http://api.nanyibang.com/campaign?campaignId=2&campaignType=19.9&page=%ld&system_name=android&versionCode=190"

#define KJingPinXiaoJie3 @"http://api.nanyibang.com/campaign?campaignId=2&campaignType=29.9&page=%ld&system_name=android&versionCode=190"

#define KChaoPinZhuanQu @"http://api.nanyibang.com/campaign?campaignId=6&campaignType=chaopin&page=%ld&system_name=android&versionCode=190"

#define KQingLvKongJian @"http://api.nanyibang.com/campaign?campaignId=7&campaignType=qinglv&page=%ld&system_name=android&versionCode=190"

#define KChuanYiXueTang @"http://api.nanyibang.com/dress-school?campaignType=chaopin&page=%ld&system_name=android&versionCode=190"

#define KHaoKanMe @"http://api.nanyibang.com/haokanme?page=%ld&public=true&system_name=android&versionCode=192"

#define KDRESSURL @"http://www.nanyibang.com/school/school.php?id=%ld"
