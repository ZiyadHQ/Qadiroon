
import 'package:flutter/material.dart';

class GradientAnimatedIcon extends StatefulWidget
{

  final IconData icon;
  final double size;
  final List<Color> gradient;

  GradientAnimatedIcon({required this.icon, required this.size, required this.gradient});

  State<StatefulWidget> createState()
  {
    return _AnimatedIconState();
  }
  
}

class _AnimatedIconState extends State<GradientAnimatedIcon> with SingleTickerProviderStateMixin
{

  late AnimationController _controller;

  @override
  void initState()
  {
    super.initState();
    _controller = AnimationController
    (
      duration: const Duration(seconds: 3),
      vsync: this
    )..repeat(reverse: true);
  }

  @override
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context)
  {
    return AnimatedBuilder
    (
      animation: _controller,
      builder: (context, child)
      {
        return ShaderMask
        (
          shaderCallback: (Rect bounds)
          {
            return LinearGradient
            (
              colors: widget.gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, _controller.value]
            ).createShader(bounds);
          },
          child: Icon
          (
            widget.icon,
            size: widget.size, 
          ),
        );
      },
    );
  }

}

class GradientAnimatedWrapper extends StatefulWidget
{

  final Widget child;
  final Duration duration;
  final List<Color> gradient;

  GradientAnimatedWrapper({required this.child, required this.duration, required this.gradient});


  @override
  State<StatefulWidget> createState()
  {
    return _GradientAnimatedWrapperState();
  }

}

class _GradientAnimatedWrapperState extends State<GradientAnimatedWrapper> with TickerProviderStateMixin
{

  late AnimationController _controller;

  @override
  void initState()
  {
    super.initState();
    _controller = AnimationController
    (
      vsync: this,
      duration: widget.duration
    )..repeat(reverse: true);
  }

  @override
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context)
  {
    return AnimatedBuilder
    (
      animation: _controller,
      builder: (context, child)
      {
        return ShaderMask
        (
          shaderCallback: (Rect bounds)
          {
            return LinearGradient
            (
              colors: widget.gradient,
              begin: Alignment(-1.0 + _controller.value * 2, -1.0),
              end: Alignment(1.0 + _controller.value * 2, 1.0),
              tileMode: TileMode.mirror,
              stops: [0.0, _controller.value * 4]
            ).createShader(bounds);
          },
          child: widget.child
        );
      },
    );
  }

}