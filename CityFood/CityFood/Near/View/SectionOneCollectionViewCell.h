//
//  SectionOneCollectionViewCell.h
//  CityFood
//
//  Created by mac on 2019/3/1.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SectionOneCollectionViewCell : UICollectionViewCell
-(void)setFoodImageView:(NSString*) imagePath;
-(void)setName:(NSString*) nameStr withFont:(UIFont*) font withcolor:(UIColor*) color;
-(void)setIntroduce:(NSString*) str withFont:(UIFont*) font withColor:(UIColor*) color;
-(void)setLikeButton:(NSString*) selectImage withunselectImg:(NSString*) unselectImage;
-(void)setInstance:(NSString*) str withFont:(UIFont*) font withColor:(UIColor*) color;
@end

NS_ASSUME_NONNULL_END
