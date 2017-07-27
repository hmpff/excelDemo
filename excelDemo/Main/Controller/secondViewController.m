//
//  secondViewController.m
//  excelDemo
//
//  Created by administrator on 17/7/27.
//  Copyright © 2017年 hmp. All rights reserved.
//
#import "secondViewController.h"
#import "systransInquirystockModel.h"

#import "TopCollectionViewCell.h"
#import "DetailTableViewCell.h"
#import "TitleTableViewCell.h"

#define topConllectionCellH 30

typedef enum : NSUInteger {
    TitleTableViewTag       =   1,
    DetailScrollViewTag     =   2,
    TopIconListViewTag      =   3,
    MidTableViewTag         =   4
} ScrollViewTag;

static NSString *titleTableViewCellID           =   @"titleTableViewCellID";
static NSString *topCollectionViewCellId        =   @"topCollectionViewCellId";
static NSString *detailCollectionViewCellId     =   @"detailCollectionViewCellId";


@interface secondViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource,UITextFieldDelegate>{
    
    NSInteger           _beforeScrollViewTag;
    NSInteger           _currentScrollViewTag;
    NSInteger           _detailInfoCount;
    UITableView         *_titleTableView;
    UITableView         *_detailTableView;
    UIScrollView        *_detailScrollView;
    UICollectionView    *_detailCollectionView;
    UICollectionView    *_topIconListView;
    NSMutableArray      <NSIndexPath *>*needLoadArr;
    
    
}

@property (nonatomic ,strong) NSMutableArray *excelArrays;
@property (nonatomic ,strong) NSMutableArray *systransInquirystockArrays;
@property (nonatomic ,strong) UITableView *detailTableView;
@property (nonatomic ,strong) UIView *leftTitleView;
@end


@implementation secondViewController

-(NSMutableArray*)systransInquirystockArrays{
    if (_systransInquirystockArrays == nil) {
        _systransInquirystockArrays = [NSMutableArray array];
    }
    return _systransInquirystockArrays;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"内存消耗大";
    
    [self DataInit];
    [self setUp];
    [SVProgressHUD showWithStatus:@"耐心等待"];
}
-(void)setUp{
    
    __weak typeof (self) weakSelf = self;
    //添加左边标题头部标题
    UIView *leftTitleView = [[UIView alloc]init];
    leftTitleView.backgroundColor = wareHouseBtnColor;
    
    [weakSelf.view addSubview:leftTitleView];
    [leftTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(0);
        make.top.equalTo(weakSelf.view);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(kAverageTableViewWidth);
    }];
    
    //添加物料编码标题
    UILabel *serielL = [[UILabel alloc]init];
    serielL.textColor = [UIColor blackColor];
    serielL.font = [UIFont systemFontOfSize:FONT(12)];
    serielL.text = @"物料编码";
    
    [leftTitleView addSubview:serielL];
    [serielL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftTitleView).with.offset(10);
        make.centerY.equalTo(leftTitleView);
    }];
    
    _leftTitleView = leftTitleView;
    [_leftTitleView setHidden:YES];
}
-(void)DataInit{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"excel" ofType:@"plist"];
    _excelArrays = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        NSArray *systransInquirystockArray = [systransInquirystockModel mj_objectArrayWithKeyValuesArray:_excelArrays];
        [self.systransInquirystockArrays removeAllObjects];
        for (systransInquirystockModel *item in systransInquirystockArray) {
            
            [self.systransInquirystockArrays addObject:item];
            
        }
        
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //回调或者说是通知主线程刷新，
            [_leftTitleView setHidden:NO];
            [self loadTitleTableView];
            [self loadTopIconListView];
            [self loadDetailView];
            
            [_titleTableView reloadData];
            [_detailTableView reloadData];
            [_detailCollectionView reloadData];
            
            [SVProgressHUD dismiss];
            
        });
        
    });
    
}
#pragma mark - 左侧标题页面&顶部页面

- (void)loadTitleTableView {
    _titleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topConllectionCellH, kAverageTableViewWidth, kScreenHeight-kTopCarIconListViewHeight) style:UITableViewStylePlain];
    _titleTableView.tag         = TitleTableViewTag;
    _titleTableView.rowHeight   = rowHight;
    _titleTableView.delegate    = self;
    _titleTableView.dataSource  = self;
    _titleTableView.showsVerticalScrollIndicator = false;
    
    [self.view addSubview:_titleTableView];
}


#pragma mark - 右侧详情页面

- (void)loadDetailView {
    _detailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kAverageTableViewWidth, topConllectionCellH, kAverageTableViewWidth*2, kScreenHeight)];
    _detailScrollView.tag           =   DetailScrollViewTag;
    _detailScrollView.bounces       =   false;
    _detailScrollView.delegate      =   self;
    _detailScrollView.showsVerticalScrollIndicator      =  false;
    _detailScrollView.showsHorizontalScrollIndicator    =  false;
    _detailScrollView.contentSize   =   CGSizeMake(7*kAverageTableViewWidth, self.systransInquirystockArrays.count*rowHight);
    _detailScrollView.backgroundColor = [UIColor grayColor];
    
    
    _detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kAverageTableViewWidth*7, self.systransInquirystockArrays.count*rowHight) style:UITableViewStylePlain];
    _detailTableView.dataSource = self;
    _detailTableView.delegate = self;
    _detailTableView.tag = MidTableViewTag;
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_detailScrollView];
    
    [_detailScrollView addSubview:_detailTableView];
}
/**
 
 判断拖动的view的tag进行联动
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_currentScrollViewTag == TitleTableViewTag) {
        CGFloat offSetX = _beforeScrollViewTag == TopIconListViewTag ? _topIconListView.contentOffset.x : _detailScrollView.contentOffset.x;
        _detailScrollView.contentOffset = CGPointMake(offSetX, _titleTableView.contentOffset.y);
        _topIconListView.contentOffset = CGPointMake(offSetX, 0);
        return;
    }
    if (_currentScrollViewTag == DetailScrollViewTag) {
        _titleTableView.contentOffset = CGPointMake(0, _detailScrollView.contentOffset.y);
        _topIconListView.contentOffset = CGPointMake(_detailScrollView.contentOffset.x, 0);
        return;
    }
    if (_currentScrollViewTag == TopIconListViewTag) {
        CGFloat offSetY = _beforeScrollViewTag == TitleTableViewTag ? _titleTableView.contentOffset.y : _detailScrollView.contentOffset.y;
        _detailScrollView.contentOffset = CGPointMake(_topIconListView.contentOffset.x, offSetY);
        _titleTableView.contentOffset = CGPointMake(0, _detailScrollView.contentOffset.y);
        return;
    }
}

#pragma mark - 左侧标题页面

- (void)loadTopIconListView {
    UICollectionViewFlowLayout *topViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    topViewFlowLayout.itemSize = CGSizeMake(kAverageTableViewWidth*7, kTopCarIconListViewHeight);
    topViewFlowLayout.minimumLineSpacing        = 0;
    topViewFlowLayout.minimumInteritemSpacing   = 0;
    topViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _topIconListView = [[UICollectionView alloc] initWithFrame:CGRectMake(kAverageTableViewWidth, 0, kAverageTableViewWidth*2, 30) collectionViewLayout:topViewFlowLayout];
    _topIconListView.tag                 = TopIconListViewTag;
    _topIconListView.bounces             = false;
    _topIconListView.delegate            = self;
    _topIconListView.dataSource          = self;
    _topIconListView.backgroundColor     = [UIColor whiteColor];
    _topIconListView.showsHorizontalScrollIndicator = false;
    
    [_topIconListView registerNib:[UINib nibWithNibName:@"TopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:topCollectionViewCellId];
    
    [self.view addSubview:_topIconListView];
    UIView *coverView = [[UIView alloc]init];
    coverView.frame = CGRectMake(kAverageTableViewWidth, 0, kAverageTableViewWidth*2, topConllectionCellH);
    coverView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:coverView];
}


#pragma mark - CollectionView Datesoure

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TopCollectionViewCell *topCell = [collectionView dequeueReusableCellWithReuseIdentifier:topCollectionViewCellId forIndexPath:indexPath ];
    topCell.userInteractionEnabled = NO;
    return topCell;
}

#pragma mark - CollectionView Delegate
//按需加载 - 如果目标行与当前行相差超过指定行数，只在目标滚动范围的前后指定3行加载。
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSIndexPath *ip = [_titleTableView indexPathForRowAtPoint:CGPointMake(0, targetContentOffset->y)];
    NSIndexPath *cip = [[_titleTableView indexPathsForVisibleRows] firstObject];
    NSInteger skipCount = 1;    // 这里我为了方便演示写的1
    if (labs(cip.row-ip.row)>skipCount) {
        //        此方法可以获取将要显示的组
        //        visibleSections = [NSSet setWithArray:[[_titleTableView indexPathsForVisibleRows] valueForKey:@"section"]];
        NSArray *temp = [_titleTableView indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y, _titleTableView.frame.size.width, _titleTableView.frame.size.height)];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:temp];
        if (velocity.y<0) {      // 上滑
            NSIndexPath *indexPath = [temp lastObject];
            if (indexPath.row+3<numberOfRows*numberOfSections) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+3 inSection:indexPath.section]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+2 inSection:indexPath.section]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section]];
            }
        } else {                 // 下滑
            NSIndexPath *indexPath = [temp firstObject];
            if (indexPath.row>3) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-3 inSection:indexPath.section]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-2 inSection:indexPath.section]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section]];
            }
        }
        [needLoadArr addObjectsFromArray:arr];
    }
    
}

#pragma mark - Table View Dalegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return heightForHeaderInSection;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 记录上一个拖动的view来保证再次滑动是有惯性效果
    _beforeScrollViewTag    =   _currentScrollViewTag;
    _currentScrollViewTag   =   scrollView.tag;
    [needLoadArr removeAllObjects];
    // 取到当前界面上能显示的indexPaths，判断是否有隐藏
    NSArray <NSIndexPath *>*indexpaths = [_titleTableView indexPathsForVisibleRows];
    UITableViewCell *firstCell  =   [_titleTableView cellForRowAtIndexPath:indexpaths.firstObject];
    UITableViewCell *lastCell   =   [_titleTableView cellForRowAtIndexPath:indexpaths.lastObject];
    //  在当前可见的区域中，第一个cell或者最后一个cell是隐藏状态，那么重新加载可见区域内的cell
    if (firstCell.isHidden == true || lastCell.isHidden == true) {
        [_titleTableView reloadRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationNone];
    }
}


#pragma mark - GestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([tableView isEqual:_detailTableView]){
        return self.systransInquirystockArrays.count;
    }else{
        return self.systransInquirystockArrays.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_detailTableView]){
        static NSString *detailCollectionViewCellId = @"detailCollectionViewCellId";
        DetailTableViewCell *detailTablecell = [tableView dequeueReusableCellWithIdentifier:detailCollectionViewCellId];
        if (detailTablecell == nil) {
            detailTablecell = [[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCollectionViewCellId];
        }
        systransInquirystockModel *systransInquirystockItem = self.systransInquirystockArrays[indexPath.row];
        detailTablecell.Item = systransInquirystockItem;
        detailTablecell.selectionStyle = UITableViewCellSelectionStyleNone;
        return detailTablecell;
        
    }else{
        TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:titleTableViewCellID];
        if (cell == nil) {
            cell =[[TitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleTableViewCellID];
        }
        
        systransInquirystockModel *systransInquirystockItem = self.systransInquirystockArrays[indexPath.row];
        cell.Item = systransInquirystockItem;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


@end
