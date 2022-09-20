
import 'package:flutter/cupertino.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class AppConstants{
  static const int splashDelay = 3;
  static const int sliderAnimationTime = 300;
}


Widget bottomSheet =  Padding(
              padding: const EdgeInsets.symmetric(vertical:AppPadding.p5 , horizontal: AppPadding.p8 ),
              child: Container(
              //  color: ColorManager.white.withOpacity(0.1),
                child: Row(
                  children: [
                    Text(
                      'By: Mona Mouawad',
                      style: TextStyle(fontSize: 10),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'mona.mouawad21@gmail.com',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ) ;