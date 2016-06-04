//
//  ITNew.h
//  6-科技头条
//
//  Created by fengjun on 16/6/4.
//  Copyright © 2016年 fengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITNew : NSObject

@property (nonatomic, copy) NSString *description;

@property (nonatomic, assign) NSInteger channelId;

@property (nonatomic, copy) NSString *thumbnailUrls;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *newsId;

@property (nonatomic, copy) NSString *pubDate;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *recommendState;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *grabDate;

@property (nonatomic, assign) NSInteger hits;

@property (nonatomic, strong) NSArray<NSString *> *thumbnailUrlList;

/**
 * 添加的时间
 */
@property (nonatomic, copy) NSString *addtime;

@end
