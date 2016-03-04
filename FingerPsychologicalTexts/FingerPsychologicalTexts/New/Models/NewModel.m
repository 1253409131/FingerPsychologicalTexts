//
//  NewModel.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//
/*
@property (nonatomic, copy) NSString *image;//图片
@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *viewnum;//测试人数
@property (nonatomic, copy) NSString *commentnum;//评论人数
@property (nonatomic, copy) NSString *content;//内容
@property (nonatomic, copy) NSString *category_id;/
 */
#import "NewModel.h"

@implementation NewModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.image = dict[@"cover"];
        self.title = dict[@"title"];
        self.viewnum = dict[@"viewnum"];
        self.commentnum = dict[@"commentnum"];
        self.content = dict[@"content"];
        self.category_id = dict[@"category_id"];
    }
    
    return self;
}
@end
