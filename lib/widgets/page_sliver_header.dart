import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:forcechallenge/constants.dart' as constants;
import 'package:forcechallenge/state/message_store.dart';

class PageSliverHeader implements SliverPersistentHeaderDelegate {
  PageSliverHeader({
    this.minExtent,
    @required this.maxExtent,
  });
  final double minExtent;
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: is this dependency injection right?
    var _counter = Provider.of<MessageStore>(context).unreadMessagesCounter;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/yoda_baby.png',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
            //boxShadow: [constants.boxShadow],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(
              titleOpacity(shrinkOffset),
            ),
          ),
        ),
        Observer(
            builder: (_) => _counter != 0
                ? Positioned(
                    //top: 10,
                    right: 20,
                    child: SafeArea(
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Text(
                            '$_counter',
                            style: constants.defaultTextStyle,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: constants.buttonColor,
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                  )
                : SizedBox()),
        Positioned(
          left: MediaQuery.of(context).size.width / 4,
          right: MediaQuery.of(context).size.width / 4,
          bottom: 16.0,
          child: Text(
            'FORCE TEST',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28.0,
              //color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
              color: titleColor(shrinkOffset),
            ),
          ),
        ),
      ],
    );
  }

  Color titleColor(double shrinkOffset) {
    return Color.lerp(Colors.black, Colors.white,
        1.0 - (max(0.0, shrinkOffset) * 2) / maxExtent);
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
