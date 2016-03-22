//
//  DetailViewController.m
//  W3D1ScrollViewImageGalleries
//
//  Created by Karlo Pagtakhan on 03/21/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self setupScrollView];
  
  NSLog(@"viewDidLoad");
}

-(void) viewDidLayoutSubviews{
  NSLog(@"viewDidLayoutSubviews");
}

-(void)viewDidAppear:(BOOL)animated{
  //  [self.scrollView setZoomScale:0.1];
  //  [self setupConstraints];
  [self addElementsToScrollView];
  [self logValues];
  
  NSLog(@"viewDidAppear");
}
//MARK: Prepare ScrollView
-(void)setupScrollView{
  self.scrollView.delegate = self;
  self.scrollView.minimumZoomScale = 1.0;
  self.scrollView.maximumZoomScale = 10;
  [self.scrollView setZoomScale:1.0];
  
  
}
-(void)addElementsToScrollView{
  if (!self.image) {
    NSLog(@"No image");
  }
  
  self.imageView = [[UIImageView alloc] initWithImage:self.image];
  [self.scrollView addSubview:self.imageView];
  self.imageView.frame = self.scrollView.bounds;
  self.imageView.contentMode = UIViewContentModeScaleAspectFit;
  self.imageView.backgroundColor = [UIColor whiteColor];
}

//MARK: Scroll View delegates
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
  return self.imageView;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  //animate content offset. figure out center.
  [self logValues];
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
  [self centerScrollViewContents];
}
-(void)centerScrollViewContents{
  //Center only if the image doesn't cover entire scrollView
  if (CGRectGetMinY(self.scrollView.bounds) <= CGRectGetHeight(self.scrollView.bounds) ||
      CGRectGetMinX(self.scrollView.bounds) <= CGRectGetWidth(self.scrollView.bounds)){
    
    self.scrollView.bounds = CGRectMake(CGRectGetMinX(self.scrollView.bounds), (self.scrollView.contentSize.height - CGRectGetHeight(self.scrollView.bounds)) / 2, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
  }
}

-(void)logValues{
  NSLog(@"----------------------------------");
  NSLog(@"ScrollView Bounds: %@", NSStringFromCGRect(self.scrollView.bounds));
  NSLog(@"ScrollView Content Size: %@", NSStringFromCGSize(self.scrollView.contentSize));
  NSLog(@"ImageView Bounds: %@", NSStringFromCGRect(self.imageView.bounds));
  NSLog(@"ImageView Frame: %@", NSStringFromCGRect(self.imageView.frame));
  NSLog(@"Zoom scale: %.4f", self.scrollView.zoomScale);
  
}

//-(void)setupConstraints{
//
//  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
//                                                              attribute:NSLayoutAttributeTop
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:self.scrollView
//                                                              attribute:NSLayoutAttributeTop
//                                                             multiplier:1.0
//                                                               constant:0.0]];
//  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
//                                                              attribute:NSLayoutAttributeBottom
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:self.scrollView
//                                                              attribute:NSLayoutAttributeBottom
//                                                             multiplier:1.0
//                                                               constant:0.0]];
//  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
//                                                              attribute:NSLayoutAttributeLeft
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:self.scrollView
//                                                              attribute:NSLayoutAttributeLeft
//                                                             multiplier:1.0
//                                                               constant:0.0]];
//  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
//                                                              attribute:NSLayoutAttributeRight
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:self.scrollView
//                                                              attribute:NSLayoutAttributeRight
//                                                             multiplier:1.0
//                                                               constant:0.0]];
//
//
//}
@end
