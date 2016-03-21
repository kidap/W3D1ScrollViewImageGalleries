//
//  ViewController.m
//  W3D1ScrollViewImageGalleries
//
//  Created by Karlo Pagtakhan on 03/21/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UIImageView *imageView3;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) NSMutableArray *imageViewArray;
@property (strong, nonatomic) UIPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  [self prepareView];
  [self addElementsToScrollView];
  [self addGestures];

}

-(void)viewDidAppear:(BOOL)animated{
  //bounds should be changed in viewDidAppear
  [self setupConstraints];
  
  //Show images
  for (UIImageView *imageView in self.imageViewArray) {
    imageView.alpha = 1;
  }
}
//MARK: Preparation
-(void)prepareView{
  self.imageArray = [[NSMutableArray alloc] init];
  self.imageViewArray = [[NSMutableArray alloc] init];
  
  [self setupScrollView];
}
-(void) setupScrollView{
  self.scrollView.delegate = self;
  self.scrollView.scrollEnabled = YES;
  self.scrollView.pagingEnabled = YES;
}
-(void)addElementsToScrollView{
  
  [self.imageArray addObject:[UIImage imageNamed:@"Lighthouse-in-Field"]];
  [self.imageArray addObject:[UIImage imageNamed:@"Lighthouse-night"]];
  [self.imageArray addObject:[UIImage imageNamed:@"Lighthouse"]];
  
  for (UIImage *image in self.imageArray) {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.userInteractionEnabled = YES;
    imageView.alpha = 0; //loop initially as invisible
    [self.scrollView addSubview:imageView];
    [self.imageViewArray addObject:imageView];
  }
  
  self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
  self.pageControl.pageIndicatorTintColor  = [UIColor grayColor];
  self.pageControl.currentPageIndicatorTintColor  = [UIColor blackColor];
  self.pageControl.numberOfPages = self.imageViewArray.count;
  self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.pageControl];
  
}
-(void)addGestures{
  for (UIImageView *imageView in self.imageViewArray) {
    UITapGestureRecognizer *tapToGoDetail = [[UITapGestureRecognizer alloc ] initWithTarget:self
                                                                                      action:@selector(goToDetailView:)];
    [imageView addGestureRecognizer:tapToGoDetail];
  }
  
  UITapGestureRecognizer *tapPageControl = [[UITapGestureRecognizer alloc ] initWithTarget:self
                                                                                    action:@selector(handlePageControlTaps:)];
  [self.pageControl addGestureRecognizer:tapPageControl];

}
-(void)goToDetailView:(UITapGestureRecognizer *)recognizer{
  [self performSegueWithIdentifier:@"goToDetailView" sender:recognizer.view];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if ([segue.identifier isEqualToString:@"goToDetailView"]) {
    DetailViewController *destinationVC = segue.destinationViewController;
    UIImageView *imageSelected = (UIImageView *)sender;
    destinationVC.image = imageSelected.image;
    
  }
  
}

//MARK: Constraints
-(void)setupConstraints{
  
  //Set up height and width
  for (UIImageView *imageView in self.imageViewArray) {
    [self setConstraintForItem:imageView
                     WithWidth:CGRectGetWidth(self.scrollView.bounds)
                    withHeight:CGRectGetHeight(self.scrollView.bounds)];
  }
  
  
  [self setConstraintForItem:self.pageControl
                   WithWidth:[self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages].width
                  withHeight:[self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages].height];
  
  
  //Set other constraints for images
  for (int ctr = 0; ctr < self.imageViewArray.count;ctr++) {
    UIImageView *imageView = self.imageViewArray[ctr];
    if (ctr == 0){
      [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.scrollView
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0
                                                                   constant:0.0 ]];
      
      [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.scrollView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:0.0 ]];
    } else if (ctr == self.imageViewArray.count - 1){
      [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.imageViewArray[ctr-1]
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1.0
                                                                   constant:0.0 ]];
      
      [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.scrollView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:0.0 ]];
      
      [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.scrollView
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1.0
                                                                   constant:0.0 ]];
    } else{
      [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.imageViewArray[ctr-1]
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1.0
                                                                   constant:0.0 ]];
      
      [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.scrollView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:0.0 ]];
    
    }
  }
  
  
  //Set other constraints for page control
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0.0 ]];
  
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeCenterX
                                                             multiplier:1.0
                                                               constant:0.0 ]];
}

//MARK: Scroll View delegates
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  self.pageControl.currentPage = (scrollView.bounds.origin.x / scrollView.bounds.size.width);
}

//MARK:Page control tap
-(void)handlePageControlTaps:(UITapGestureRecognizer *)recognizer{
  //Increment page control
  self.pageControl.currentPage += 1;
  
  //Adjust the bounds to display the next page
  self.scrollView.bounds = CGRectOffset(self.scrollView.bounds, self.scrollView.bounds.size.width, 0);
  
  //If already in the last page, go back to the first page.
  if (self.scrollView.bounds.origin.x >= self.scrollView.contentSize.width) {
    self.scrollView.bounds = CGRectMake(0, CGRectGetMinY(self.scrollView.bounds), CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
    self.pageControl.currentPage = 0;
  }
  
}

//MARK: Helper methods
-(void)setConstraintForItem:(id)item WithWidth:(CGFloat)width withHeight:(CGFloat)height{
  
  [item addConstraint:[NSLayoutConstraint constraintWithItem:item
                                                   attribute: NSLayoutAttributeWidth
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1.0
                                                    constant:width ]];
  
  [item addConstraint:[NSLayoutConstraint constraintWithItem:item
                                                   attribute: NSLayoutAttributeHeight
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1.0
                                                    constant:height ]];

}

@end
