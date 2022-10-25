import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/presentation/Main/Pages/home/home_page.dart';
import 'package:tut_app/presentation/Main/Pages/notifications_page.dart';
import 'package:tut_app/presentation/Main/Pages/search_page.dart';
import 'package:tut_app/presentation/Main/Pages/settings_page.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingsPage()
  ];
  List<String> _title = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notification.tr(),
    AppStrings.settings.tr(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title[_currentIndex], style: Theme.of(context).textTheme.titleSmall),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar:
      Container(decoration: BoxDecoration(boxShadow: [BoxShadow(color: ColorManager.lightGrey,spreadRadius: AppSize.s1)]),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon:Icon( Icons.home) ,label: AppStrings.home.tr()),
            BottomNavigationBarItem(icon:Icon( Icons.search) ,label: AppStrings.search.tr()),
            BottomNavigationBarItem(icon:Icon( Icons.notifications) ,label: AppStrings.notification.tr()),
            BottomNavigationBarItem(icon:Icon( Icons.settings) ,label: AppStrings.settings.tr()),

          ],
          currentIndex: _currentIndex,
          onTap: (index) {_onTap(index);},
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,

        ),
      ),
    );
  }

  _onTap(int index)
  {
    setState(() {
      _currentIndex=index;
    });
  }
}
