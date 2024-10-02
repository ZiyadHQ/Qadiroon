
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

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

class AnimatedLoadingWidget extends StatelessWidget
{

  AnimatedLoadingWidget({required this.text});

  final String text;

  @override
  Widget build(BuildContext context)
  {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return DecoratedBox
    (
      decoration: BoxDecoration
      (
        borderRadius: BorderRadius.circular(24),
        color: Colors.white
      ),
      child: SizedBox
      (
        height: height * 0.1,
        width: width * 0.25,
        child : Center
        (
          child: StyledText(color: Colors.black, fontFamily: "Amiri", size: 36, text: text)
          .animate(onPlay: (controller) {controller.repeat();})
          .fadeIn(duration: 1000.ms)
          .fadeOut(delay: 1250.ms, duration: 1000.ms)
        ),
      ),
    );
  }

}