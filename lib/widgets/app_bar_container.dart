import 'package:flutter/material.dart';
import 'package:todo_list/helpers/asset_helper.dart';
import 'package:todo_list/helpers/image_helper.dart';

class AppBarContainer extends StatelessWidget {
  const AppBarContainer({super.key, this.title, required this.child});
  final Widget child;
  final Widget? title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 210,
            child: AppBar(
              flexibleSpace: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(214, 212, 35, 35),
                          Color(0xff6357CC)
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: ImageHelper.loadFromAsset(
                      AssetHelper.icoOvalTop,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: ImageHelper.loadFromAsset(
                      AssetHelper.icoOvalBottom,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: title,
                    ),
                  )
                ],
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 90,
              backgroundColor: Color(0xFFF2F2F2),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 200),
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
