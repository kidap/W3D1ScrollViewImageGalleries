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
@property (strong, nonatomic)UIImageView *imageView1;
@property (strong, nonatomic)UIImageView *imageView2;
@property (strong, nonatomic)UIImageView *imageView3;
@property (strong, nonatomic)UIPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  [self setupScrollView];
  [self addElementsToScrollView];
  [self addGestures];

}

-(void)viewDidAppear:(BOOL)animated{
  //bounds should be changed in viewDidAppear
  [self setupConstraints];
  
  self.imageView1.alpha = 1;
  self.imageView2.alpha = 1;
  self.imageView3.alpha = 1;
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

//MARK: Preparation
-(void) setupScrollView{
  self.scrollView.delegate = self;
  self.scrollView.scrollEnabled = YES;
  self.scrollView.pagingEnabled = YES;
}
-(void)addElementsToScrollView{
  UIImage *image1 = [UIImage imageNamed:@"Lighthouse-in-Field"];
  UIImage *image2 = [UIImage imageNamed:@"Lighthouse-night"];
  UIImage *image3 = [UIImage imageNamed:@"Lighthouse"];
  
  self.imageView1 = [[UIImageView alloc] initWithImage:image1];
  self.imageView2 = [[UIImageView alloc] initWithImage:image2];
  self.imageView3 = [[UIImageView alloc] initWithImage:image3];
  
  self.imageView1.contentMode = UIViewContentModeScaleAspectFit;
  self.imageView2.contentMode = UIViewContentModeScaleAspectFit;
  self.imageView3.contentMode = UIViewContentModeScaleAspectFit;
  
  self.imageView1.translatesAutoresizingMaskIntoConstraints = NO;
  self.imageView2.translatesAutoresizingMaskIntoConstraints = NO;
  self.imageView3.translatesAutoresizingMaskIntoConstraints = NO;
  
  self.imageView1.userInteractionEnabled = YES;
  self.imageView2.userInteractionEnabled = YES;
  self.imageView3.userInteractionEnabled = YES;
  
  self.imageView1.alpha = 0;
  self.imageView2.alpha = 0;
  self.imageView3.alpha = 0;
  
  
  self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
  self.pageControl.pageIndicatorTintColor  = [UIColor grayColor];
  self.pageControl.currentPageIndicatorTintColor  = [UIColor blackColor];
  self.pageControl.numberOfPages = 3;
  self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
//  [self.pageControl addTarget:self
//                         action:@selector(handlePageControlTaps)
//               forControlEvents:UIControlEventTouchDown];
  
  
  [self.scrollView addSubview:self.imageView1];
  [self.scrollView addSubview:self.imageView2];
  [self.scrollView addSubview:self.imageView3];
  [self.view addSubview:self.pageControl];
  
}
-(void)addGestures{
  UITapGestureRecognizer *tapToGoDetail1 = [[UITapGestureRecognizer alloc ] initWithTarget:self
                                                                                    action:@selector(goToDetailView:)];
  [self.imageView1 addGestureRecognizer:tapToGoDetail1];
  
  UITapGestureRecognizer *tapToGoDetail2 = [[UITapGestureRecognizer alloc ] initWithTarget:self
                                                                                    action:@selector(goToDetailView:)];
  [self.imageView2 addGestureRecognizer:tapToGoDetail2];
  
  UITapGestureRecognizer *tapToGoDetail3 = [[UITapGestureRecognizer alloc ] initWithTarget:self
                                                                                    action:@selector(goToDetailView:)];
  [self.imageView3 addGestureRecognizer:tapToGoDetail3];
  
  
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
  [self setConstraintForItem:self.imageView1
                   WithWidth:CGRectGetWidth(self.scrollView.bounds)
                  withHeight:CGRectGetHeight(self.scrollView.bounds)];
  [self setConstraintForItem:self.imageView2
                   WithWidth:CGRectGetWidth(self.scrollView.bounds)
                  withHeight:CGRectGetHeight(self.scrollView.bounds)];
  [self setConstraintForItem:self.imageView3
                   WithWidth:CGRectGetWidth(self.scrollView.bounds)
                  withHeight:CGRectGetHeight(self.scrollView.bounds)];
  
  
  [self setConstraintForItem:self.pageControl
                   WithWidth:[self.pageControl sizeForNumberOfPages:3].width
                  withHeight:[self.pageControl sizeForNumberOfPages:3].height];
  
  
  //Set other constraints
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView1
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:0.0 ]];
  
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView1
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0.0 ]];
  
  
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView2
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.imageView1
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0.0 ]];
  
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView2
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0.0 ]];
  
  
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView3
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.imageView2
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0.0 ]];
  
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView3
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0.0 ]];
  
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView3
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0.0 ]];
  
  
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
  NSLog(@"Page control tapped");
  
  //Increment page control
  self.pageControl.currentPage += 1;

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
