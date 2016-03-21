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
  [self addElementsToScrollView];
}
-(void)viewDidAppear:(BOOL)animated{
  [self setupConstraints];
}

-(void)setupScrollView{
  self.scrollView.delegate = self;
  self.scrollView.minimumZoomScale = 0.4;
  self.scrollView.maximumZoomScale = 10;
  
}
-(void)addElementsToScrollView{
  if (!self.image) {
    self.image = [UIImage imageNamed:@"Lighthouse"];
  }
  
  self.imageView = [[UIImageView alloc] initWithImage:self.image];
  [self.scrollView addSubview:self.imageView];
  
  
}
-(void)setupConstraints{
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0.0]];
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0.0]];
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:0.0]];
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0.0]];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
  return self.imageView;
}

@end
