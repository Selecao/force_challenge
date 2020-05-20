import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:forcechallenge/components/application/app_theme.dart';
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
    MessageStore messageStore = Provider.of(context, listen: false);

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
            builder: (_) => messageStore.unreadMessagesCounter != 0
                ? Positioned(
                    right: 20,
                    child: SafeArea(
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Text(
                            '${messageStore.unreadMessagesCounter}',
                            style: AppTheme.of(context).bodyLightTextStyle,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: AppTheme.of(context).blueMainColor,
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                  )
                : Container()),
        Positioned(
          left: MediaQuery.of(context).size.width / 4,
          right: MediaQuery.of(context).size.width / 4,
          bottom: 16.0,
          child: Text(
            'FORCE TEST',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28.0 -
                  12.0 * min(1, (shrinkOffset / (maxExtent - minExtent))),
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
