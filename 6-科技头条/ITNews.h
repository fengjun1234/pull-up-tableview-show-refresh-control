//
//  ITNews.h
//  6-科技头条
//
//  Created by fengjun on 16/6/4.
//  Copyright © 2016年 fengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITNew.h"

@interface ITNews : UITableView
@property (nonatomic, strong) NSArray <ITNew *>* itNewsList;
@end
