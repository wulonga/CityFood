//
//  UILabel+LeftTopAlign.m
//  CityFood
//
//  Created by mac on 2019/3/9.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import "UILabel+LeftTopAlign.h"

@implementation UILabel (LeftTopAlign)
-(void)textLeftTopAlign:(float)size{
    NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary *attributes=@{NSFontAttributeName:[UIFont systemFontOfSize:size],NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize = [self.text boundingRectWithSize:CGSizeMake(207, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    CGRect dateFrame =CGRectMake(2, 140, CGRectGetWidth(self.frame)-5, labelSize.height);
    self.frame = dateFrame;
}
@end
