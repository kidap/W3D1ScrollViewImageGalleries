//
//  ViewController.m
//  W3D1ScrollViewImageGalleries
//
//  Created by Karlo Pagtakhan on 03/21/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic)UIImageView *imageView1;
@property (strong, nonatomic)UIImageView *imageView2;
@property (strong, nonatomic)UIImageView *imageView3;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  [self setupScrollView];
  [self addElementsToScrollView];

}

-(void)viewDidAppear:(BOOL)animated{
  
  [self setupConstraints];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
//MARK: ScrollView
-(void) setupScrollView{
  self.scrollView.delegate = self;
  self.scrollView.scrollEnabled = YES;
  self.scrollView.pagingEnabled = YES;
  //self.scrollView.contentSize = CGSizeMake(1000, 1000);
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
  
  [self.scrollView addSubview:self.imageView1];
  [self.scrollView addSubview:self.imageView2];
  [self.scrollView addSubview:self.imageView3];
  
  
  
}
-(void)setupConstraints{
  
  [self setConstraintForItem:self.imageView1
                   WithWidth:CGRectGetWidth(self.scrollView.bounds)
                  withHeight:CGRectGetHeight(self.scrollView.bounds)];
  [self setConstraintForItem:self.imageView2
                   WithWidth:CGRectGetWidth(self.scrollView.bounds)
                  withHeight:CGRectGetHeight(self.scrollView.bounds)];
  [self setConstraintForItem:self.imageView3
                   WithWidth:CGRectGetWidth(self.scrollView.bounds)
                  withHeight:CGRectGetHeight(self.scrollView.bounds)];
  
  
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView1
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:1.0 ]];
  
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView1
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:1.0 ]];
  
  
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView2
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.imageView1
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:1.0 ]];
  
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView2
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:1.0 ]];
  
  
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView3
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.imageView2
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:1.0 ]];
  
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView3
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:1.0 ]];
  
  [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView3
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.scrollView
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:1.0 ]];
  
  
  NSLog(@"Image1:%@", NSStringFromCGRect(self.imageView1.bounds));
  NSLog(@"Image2:%@", NSStringFromCGRect(self.imageView2.bounds));
  NSLog(@"Image3:%@", NSStringFromCGRect(self.imageView3.bounds));
  NSLog(@"Content size:%@",NSStringFromCGSize(self.scrollView.bounds.size));
  

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  NSLog(@"trying to scroll");
}

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
