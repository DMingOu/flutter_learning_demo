import 'package:flutter/material.dart';
 
/// 对子控件旋转动画，旋转指定角度、无限旋转。  
/// 利用 补间动画 + RotationTransition 实现
class RotateContainer extends StatefulWidget{
 
  final double endAngle; // 旋转角度
  final bool rotated;    //是否旋转
  final Widget child;
  final int duration;    //旋转时间
  final bool infinityRotated;
 
  ///rotated = true时开启旋转动画，infinityRotated = true动画持续时间为无限
  RotateContainer({this.endAngle,this.duration, this.rotated = false, this.infinityRotated = false,this.child});
 
  @override
  State<StatefulWidget> createState() {
    return _RotateContainer();
  }
}
 
class _RotateContainer extends State<RotateContainer> with SingleTickerProviderStateMixin{
 
  AnimationController _controller;
  Animation<double> _animation;
  double angle = 0;
 
  @override
  void initState() {
    _controller = AnimationController(vsync: this,duration: Duration(seconds: widget.duration) );

    ///判断是否无限旋转，确定补间动画的值
    if(widget.infinityRotated){
      _animation = Tween(begin: 0.0, end:  1.0).animate(_controller);
    }else {
      _animation = Tween(begin: 0.0, end: widget.endAngle / 360.0).animate(_controller);
    }

    ///保存目标旋转角度
    angle = widget.endAngle;

    ///对动画的各种状态的监听
    _controller.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            //动画从 controller.forward()正向执行结束时会回调此方法
            print("status is completed");

            if( widget.infinityRotated){
              //重置起点
              _controller.reset();
              //重新开启
              _controller.forward();
            }
          } else if (status == AnimationStatus.dismissed) {
            //动画从 controller.reverse() 反向执行结束时会回调此方法

          } else if (status == AnimationStatus.forward) {
            //执行 controller.forward() 会回调此状态

          } else if (status == AnimationStatus.reverse) {
            //执行 controller.reverse() 会回调此状态
          }
      }
    );  
    super.initState();

  }
 
  @override
  void didUpdateWidget(RotateContainer oldWidget) {
    if(oldWidget.rotated == widget.rotated){
      return; //减少绘制
    }
    print('RotateContainer-------didUpdateWidget  ');
    // if(! widget.rotated){
    //   _controller.reverse();//反向旋转
    // }else{
    //   _controller.forward();//正向旋转
    // }

    super.didUpdateWidget(oldWidget);
  }
 
  @override
  void dispose() {
    print('旋转动画停止，释放资源');
    _controller.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    if( widget.rotated && ! _controller.isAnimating){
      print('RotateContainer  Started  Anim');
      _controller.forward(from: 0.0);
    }

    return RotationTransition(
                turns: _animation ,
                child: widget.child,
          );
  }
 
}
