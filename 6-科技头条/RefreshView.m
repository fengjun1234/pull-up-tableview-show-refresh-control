//
//  RefreshView.m
//  6-科技头条
//
//  Created by fengjun on 16/6/4.
//  Copyright © 2016年 fengjun. All rights reserved.
//

#import "RefreshView.h"

@implementation RefreshView

+ (instancetype)refreshView{
    
    UINib * nib = [UINib nibWithNibName:@"RefreshView" bundle:nil];
    
    return  [nib instantiateWithOwner:nil options:0].lastObject;
}

@end
