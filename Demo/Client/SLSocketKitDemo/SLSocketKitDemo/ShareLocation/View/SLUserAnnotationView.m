//
//  SLUserAnnotationView.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/16.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "SLUserAnnotationView.h"

#define kWidth  35.f
#define kHeight 51.f
#define kPortraitX      2.5f
#define kPortraitY      2.f
#define kPortraitWH  30.f

@interface SLUserAnnotationView ()

@end

@implementation SLUserAnnotationView

#pragma mark - Override

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        self.backgroundColor = [UIColor clearColor];
        
        self.bgView = [[UIImageView alloc] init];
        self.bgView.frame = self.bounds;
        [self addSubview:self.bgView];
        
        /* Create portrait image view and add to view hierarchy. */
        self.portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kPortraitX, kPortraitY, kPortraitWH, kPortraitWH)];
        self.portraitImageView.image = [UIImage imageNamed:@"moRengTouXiang"];
        self.portraitImageView.contentMode = UIViewContentModeScaleToFill;
        self.portraitImageView.layer.masksToBounds = YES;
        self.portraitImageView.layer.cornerRadius = kPortraitWH / 2;
        [self addSubview:self.portraitImageView];
    }
    
    return self;
}

@end
