//
//  SLShareLocationView.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/16.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "SLShareLocationView.h"
#import "SLShareLocationViewModel.h"
#import "SLShareLocationUserCell.h"
#import "SLUserAnnotationView.h"
#import "SLUserAnnotation.h"
#import "SLLocationModel.h"
#import "SLShareLocationEmptyCell.h"

#define COORDINATE_SPAN_SCALE       5.6

static NSString * const kSLShareLocationUserCell = @"SLShareLocationUserCell";

static NSString * const kSLShareLocationEmptyCell = @"SLShareLocationEmptyCell";

@interface SLShareLocationView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MAMapViewDelegate>

@property (nonatomic, strong) SLShareLocationViewModel *viewModel;

@property (nonatomic, strong) UICollectionView *usersCollectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;



@property (strong, nonatomic) UIButton *bottomBtn;

@property (nonatomic, strong) SLUserAnnotation *userAnnotation;



@end

@implementation SLShareLocationView

#pragma mark - Life cycle
- (instancetype)initWithViewModel:(id<XYViewModelProtocol>)viewModel{
    self.viewModel = (SLShareLocationViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

#pragma mark - 约束
- (void)updateConstraints{
    WS(weakSelf);
    [self.usersCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(64);
        make.left.equalTo(weakSelf).offset(0);
        make.right.equalTo(weakSelf).offset(0);
        make.height.equalTo(@(80));
    }];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.usersCollectionView.mas_bottom);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).offset(-15);
        make.left.equalTo(weakSelf).offset(15);
        make.right.equalTo(weakSelf).offset(-15);
        make.height.equalTo(@(50));
    }];
    
    [super updateConstraints];
}

#pragma mark - Protocol
- (void)xy_setupViews{
    [self addSubview:self.usersCollectionView];
    [self addSubview:self.mapView];
    [self addSubview:self.bottomBtn];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)xy_bindViewModel {
    self.viewModel.clickBottomBtnSignal = [self.bottomBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
    
    [self onListenTimerActionSubject];
    
    [self bindWithRefreshUsersView];
    
    [self bindWithRefreshMapView];
    
    /*
#warning t
    @weakify(self);
    [[self.bottomBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        SLUserAnnotation *anno = [[SLUserAnnotation alloc] init];
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = 31.2296700000;
        coordinate.longitude = 121.4762000000;
        anno.coordinate = coordinate;
        anno.isOthers = YES;
        [self.mapView addAnnotation:anno];
    }];
     */
}

#pragma mark - 功能模块
- (void)bindWithRefreshUsersView{
    @weakify(self);
    [self.viewModel.refreshUsersViewSubject subscribeNext:^(id x) {
        @strongify(self);
        [self.usersCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }];
}

- (void)bindWithRefreshMapView{
    @weakify(self);
    [self.viewModel.refreshMapViewSubject subscribeNext:^(id x) {
        @strongify(self);
        NSMutableArray *others = @[].mutableCopy;
        [self.viewModel.users enumerateObjectsUsingBlock:^(SLLocationModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj.userId isEqualToString:self.viewModel.userID]) {
                [others addObject:obj];
            }
        }];
        [self addOtherUserAnnotationsWithModels:others];
        [self setMapViewRegionWithCenterCoordinate:_userAnnotation.coordinate arounds:others];
    }];
}


- (void)onListenTimerActionSubject{
    @weakify(self);
    [self.viewModel.timerActionSubject subscribeNext:^(id x) {
        @strongify(self);
        self.mapView.showsUserLocation = YES;
    }];
}



#pragma mark - MAMapViewDelegate
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if(updatingLocation){
        _mapView.showsUserLocation = NO;
        //添加用户大头针
        [self addUserAnnotationWithCoordinate:userLocation.coordinate];
        if (self.viewModel.bottomBtnState == SLBottomBtnStateSelected) {//显示用户位置，并发送用户地理位置
            SLLocationModel *model = [[SLLocationModel alloc] initWithUserId:self.viewModel.userID lat:userLocation.coordinate.latitude lng:userLocation.coordinate.longitude];
            [self.viewModel.locateSuccessSubject sendNext:model];
        }
    }
}


/**
 显示用户自己位置

 @param coordinate
 */
- (void)addUserAnnotationWithCoordinate:(CLLocationCoordinate2D )coordinate{
    if (_userAnnotation == nil) {
        _userAnnotation = [[SLUserAnnotation alloc] init];
    }else{
        //清除之前的
        NSArray *array = _mapView.annotations;
        for (SLUserAnnotation *annotation in array) {
            if (annotation == _userAnnotation) {
                [_mapView removeAnnotation:annotation];
            }
        }
    }
    
    _userAnnotation.isOthers = NO;
    _userAnnotation.coordinate = coordinate;
    [_mapView addAnnotation:_userAnnotation];
}

- (void)addOtherUserAnnotationsWithModels:(NSMutableArray <SLLocationModel *>*)models{
    NSArray *array = _mapView.annotations;
    for (SLUserAnnotation *annotation in array) {
        if (annotation.isOthers) {
            [_mapView removeAnnotation:annotation];
        }
    }
    
    [models enumerateObjectsUsingBlock:^(SLLocationModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SLUserAnnotation *annotation = [[SLUserAnnotation alloc] init];
        annotation.isOthers = YES;
        annotation.coordinate = CLLocationCoordinate2DMake(obj.lat, obj.lng);
        [_mapView addAnnotation:annotation];
    }];
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"error:%@",error.description);
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        static NSString *AnnotationUserViewID = @"UserAnn2";
        SLUserAnnotationView *annotationView = (SLUserAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationUserViewID];
        
        if (annotationView == nil)
        {
            annotationView = [[SLUserAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationUserViewID];
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, -5);
            annotationView.bgView.image = [UIImage imageNamed:@"yjxd_gcs_u"];
        }
        
        return annotationView;
    }else if ([annotation isKindOfClass:[SLUserAnnotation class]]){
        SLUserAnnotation *theAnno = (SLUserAnnotation *)annotation;
        static NSString *AnnotationViewID = @"UserAnn";
        SLUserAnnotationView *annotationView = (SLUserAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        
        if (annotationView == nil)
        {
            annotationView = [[SLUserAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, -5);
            annotationView.bgView.image = theAnno.isOthers?[UIImage imageNamed:@"yjxd_gcs"]:[UIImage imageNamed:@"yjxd_gcs_u"];
        }
        
        return annotationView;
    }else{
        return nil;
    }
}


/**
 设置地图以用户位置为中心，周围最远点为半径

 @param centerCoordinate 中心点
 @param aroundCoordinates 附近的点
  */
- (void)setMapViewRegionWithCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate arounds:(NSMutableArray <SLLocationModel *>*)arounds{
    if (!centerCoordinate.latitude || !centerCoordinate.longitude || !arounds.count) {
        return;
    }
    
    //求最大距离
    __block CLLocationDistance maxDistance = 0;
    __block CLLocationDegrees theLatitudeDelta;
    __block CLLocationDegrees theLongitudeDelta;
    
    [arounds enumerateObjectsUsingBlock:^(SLLocationModel * _Nonnull around, NSUInteger idx, BOOL * _Nonnull stop) {
        CLLocationCoordinate2D aroundCoordinate;
        aroundCoordinate.latitude = around.lat;
        aroundCoordinate.longitude = around.lng;
        CLLocationDegrees latitudeDelta = fabs(centerCoordinate.latitude - aroundCoordinate.latitude);
        CLLocationDegrees longitudeDelta = fabs(centerCoordinate.longitude - aroundCoordinate.longitude);
        CLLocationDistance distance = sqrt(pow(latitudeDelta, 2) + pow(longitudeDelta, 2));
        if (distance > maxDistance) {
            maxDistance = distance;
            theLatitudeDelta = latitudeDelta;
            theLongitudeDelta = longitudeDelta;
        }
    }];
    
    MACoordinateSpan span = MACoordinateSpanMake(theLatitudeDelta * 2 * COORDINATE_SPAN_SCALE, theLongitudeDelta * 2 * COORDINATE_SPAN_SCALE);//以用户为中心点，工程师与用户的距离为半径画一个圆，地图显示的区域比这个圆稍稍大一点，所以是2 * 1.9
    MACoordinateRegion region = MACoordinateRegionMake(centerCoordinate, span);
    [_mapView setRegion:region animated:YES];
    [_mapView regionThatFits:region];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewModel.users.count?:1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.viewModel.users.count) {
        SLShareLocationUserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSLShareLocationUserCell forIndexPath:indexPath];
        cell.model = self.viewModel.users[indexPath.row];
        return cell;
    }else{
        SLShareLocationEmptyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSLShareLocationEmptyCell forIndexPath:indexPath];
        return cell;
    }
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.viewModel.users.count) {
        return CGSizeMake(100, 80);
    }else{
        return CGSizeMake(ScreenW, 50);
    }
}

#pragma mark - Lazy load
- (UICollectionView *)usersCollectionView{
    if (_usersCollectionView == nil) {
        _usersCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _usersCollectionView.backgroundColor = [UIColor whiteColor];
        [_usersCollectionView registerNib:[UINib nibWithNibName:kSLShareLocationUserCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kSLShareLocationUserCell];
        [_usersCollectionView registerNib:[UINib nibWithNibName:kSLShareLocationUserCell bundle:nil] forCellWithReuseIdentifier:kSLShareLocationUserCell];
        [_usersCollectionView registerNib:[UINib nibWithNibName:kSLShareLocationEmptyCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kSLShareLocationEmptyCell];
        _usersCollectionView.showsHorizontalScrollIndicator = NO;
        _usersCollectionView.showsVerticalScrollIndicator = NO;
        _usersCollectionView.delegate = self;
        _usersCollectionView.dataSource = self;
    }
    return _usersCollectionView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout =[[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 10;
    }
    return _flowLayout;
}

- (MAMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] init];
        _mapView.distanceFilter = 15.0;//设定定位的最小更新距离
        [_mapView setZoomLevel:12];
        _mapView.showsCompass = NO;
        _mapView.showsScale = NO;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        _mapView.delegate = self;
    }
    return _mapView;
}

- (UIButton *)bottomBtn{
    if (_bottomBtn == nil) {
        _bottomBtn = [[UIButton alloc] init];
        [_bottomBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn_login"] forState:UIControlStateNormal];
        [_bottomBtn setTitle:@"共享实时位置" forState:UIControlStateNormal];
    }
    return _bottomBtn;
}

@end
