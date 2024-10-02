
import 'dart:async';

import 'package:flutter/material.dart';

class StyledPageView extends StatefulWidget
{

  StyledPageView({required this.children});

  List<Widget> children;

  @override
  State<StatefulWidget> createState()
  {
    return _StyledPageViewState();
  }

}

class _StyledPageViewState extends State<StyledPageView>
{

  late PageController controller;
  late Timer timer;

  @override
  void initState()
  {
    controller = PageController(initialPage: widget.children.length - 1);
    timer = Timer.periodic
    (
      Duration(seconds: 5),
      (timer)
      {
        int index = controller.page!.round();
        if(index == 0)
        {
          controller.animateToPage(widget.children.length - 1, duration: Duration(seconds: 2), curve: Curves.easeInCubic);
        }
        else
        {
          controller.previousPage(duration: Duration(seconds: 2), curve: Curves.easeInCubic);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose()
  {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return PageView
    (
      controller: controller,
      padEnds: true,
      children: widget.children.map
      (
        (e)
        {
          return DecoratedBox
          (
            decoration: BoxDecoration
            (
              color: Colors.black26,
              borderRadius: BorderRadius.circular(24),
            ),
            child: e,
          );
        },
      ).toList(),
      scrollDirection: Axis.horizontal,
    );
  }

}