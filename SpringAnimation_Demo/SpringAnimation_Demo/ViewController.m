//
//  ViewController.m
//  Text_JellyAnimation
//
//  Created by 毛韶谦 on 2017/1/11.
//  Copyright © 2017年 毛韶谦. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *jellyView;

@end

@implementation ViewController

- (UIView *)jellyView {
    
    if (!_jellyView) {
        
        _jellyView = [[UIView alloc] init];
        _jellyView.backgroundColor = [UIColor redColor];
        _jellyView.frame = CGRectMake(100, 100, 100, 100);
        
        _jellyView.layer.cornerRadius = 50;
        _jellyView.layer.masksToBounds = YES;
        [self.view addSubview:_jellyView];
    }
    return _jellyView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.jellyView.layer.masksToBounds = YES;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touches = %@ \n \n event = %@",touches ,event);
    //获取触摸的所以对象；
    UITouch *touch = [touches anyObject];
    //获取点击的点；
    CGPoint point = [touch locationInView:self.view];
    
    //CASpringAnimation 弹簧动画
    [self springAnimationTextAction:point];
}

#pragma mark -----代码测试部分--------

#pragma mark iOS9 CASpringAnimation 弹簧动画

- (void)springAnimationTextAction:(CGPoint)point {
    
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"bounds"];
    
    //路径计算模式 （@"position"）
    if ([springAnimation.keyPath isEqualToString:@"position"]) {
        
        springAnimation.fromValue = [NSValue valueWithCGPoint:self.jellyView.layer.position];
        springAnimation.toValue = [NSValue valueWithCGPoint:point];
    }else if ([springAnimation.keyPath isEqualToString:@"position.x"]) {
        
        springAnimation.fromValue = @(self.jellyView.layer.position.x);
        springAnimation.toValue = @(point.x);
    }else if ([springAnimation.keyPath isEqualToString:@"position.y"]) {
        
        springAnimation.fromValue = @(self.jellyView.layer.position.y);
        springAnimation.toValue = @(point.y);
    }else if ([springAnimation.keyPath isEqualToString:@"bounds"]) {
        
        //        CGFloat width = arc4random()%1000*0.1f+20.0f;
        //        CGFloat height = arc4random()%30*0.1f;
        springAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(point.x, point.y, 60, 60)];
        springAnimation.toValue = [NSValue valueWithCGRect:self.jellyView.frame];
    }
    
    
    //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大 Defaults to one
    springAnimation.mass = 5;
    //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快 Defaults to 100
    springAnimation.stiffness = 100;
    //阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快 Defaults to 10
    springAnimation.damping = 10;
    //初始速率，动画视图的初始速度大小 Defaults to zero
    //速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    springAnimation.initialVelocity = 10;
    //估算时间 返回弹簧动画到停止时的估算时间，根据当前的动画参数估算
    NSLog(@"====%f",springAnimation.settlingDuration);
    springAnimation.duration = springAnimation.settlingDuration;
    
    // removedOnCompletion 默认为YES 为YES时，动画结束后，恢复到原来状态
    springAnimation.removedOnCompletion = NO;
    //    springAnimation.fillMode = kCAFillModeBoth;
    
    [self.jellyView.layer addAnimation:springAnimation forKey:@"springAnimation"];
    
    
    
#pragma  CASpringAnimation 弹簧动画 的相关属性
    /* The mass of the object attached to the end of the spring. Must be greater
     than 0. Defaults to one. */
    
    //    @property CGFloat mass;
    
    /* The spring stiffness coefficient. Must be greater than 0.
     * Defaults to 100. */
    
    //    @property CGFloat stiffness;
    
    /* The damping coefficient. Must be greater than or equal to 0.
     * Defaults to 10. */
    
    //    @property CGFloat damping;
    
    /* The initial velocity of the object attached to the spring. Defaults
     * to zero, which represents an unmoving object. Negative values
     * represent the object moving away from the spring attachment point,
     * positive values represent the object moving towards the spring
     * attachment point. */
    
    //    @property CGFloat initialVelocity;
    
    /* Returns the estimated duration required for the spring system to be
     * considered at rest. The duration is evaluated for the current animation
     * parameters. */
    
    //    @property(readonly) CFTimeInterval settlingDuration;
    
    
}

























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
