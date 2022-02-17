
import 'package:animations/animations.dart';
import 'package:biz_app_bloc/core/app_screen.dart';
import 'package:biz_app_bloc/core/bundle.dart';
import 'package:biz_app_bloc/feature/bookmark/bookmark_page.dart';
import 'package:biz_app_bloc/feature/bookmark/cubit/bookmark_cubit.dart';
import 'package:biz_app_bloc/feature/setting/setting_page.dart';
import 'package:biz_app_bloc/feature/home_navigation/cubit/homenavigation_cubit.dart';
import 'package:biz_app_bloc/feature/home/home_page.dart';
import 'package:biz_app_bloc/utility/colors.dart';
import 'package:biz_app_bloc/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:biz_app_bloc/feature/home/cubit/home_page_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeNavigationScreen extends AppScreen {
  HomeNavigationScreen(
      {RouteObserver<Route>? routeObserver, Key? key, Bundle? arguments})
      : super(routeObserver, key, arguments);
  @override
  _HomeNavigationScreenState createState() => _HomeNavigationScreenState();
}

class _HomeNavigationScreenState extends AppScreenState<HomeNavigationScreen> {
  late List<BottomNavigationBarItem> _navBarItems;
  late List<Widget> _bodyWidgets;
  late HomeNavigationCubit _cubit;
  late HomePageCubit _homePageCubit;
  late BookmarkCubit _bookmarkCubit;


  @override
  void onInit() {
    _cubit = BlocProvider.of<HomeNavigationCubit>(context);
    _homePageCubit = BlocProvider.of<HomePageCubit>(context);
    _bookmarkCubit = BlocProvider.of<BookmarkCubit>(context);

    _navBarItems = [
      BottomNavigationBarItem(
        label: StringConst.HOME,
        icon: _getBottomBarIcons(FontAwesomeIcons.home, false),
        activeIcon: _getBottomBarIcons(FontAwesomeIcons.home, true),
      ),

      BottomNavigationBarItem(
        label: StringConst.BOOKMARK,
        icon: _getBottomBarIcons(FontAwesomeIcons.bookmark, false),
        activeIcon: _getBottomBarIcons(FontAwesomeIcons.bookmark, true),
      ),

        BottomNavigationBarItem(
          label: StringConst.SETTING,
          icon: _getBottomBarIcons(FontAwesomeIcons.slidersH, false),
          activeIcon: _getBottomBarIcons(FontAwesomeIcons.slidersH, true),
        ),

    ];
    _bodyWidgets = [
      BlocProvider.value(
        value: _homePageCubit,
        child: HomePage(),
      ),
      BlocProvider.value(
        value: _bookmarkCubit,
        child: BookmarkPage(),
      ),
      SettingScreen(),
    ];
    super.onInit();
  }

  Widget _getBottomBarIcons(IconData asset, bool isActive) {
    return FaIcon(
      asset,
      color: isActive ? Colors.black : AppColors.grey,
    );
  }


  @override
  Widget? bottomNavigator() {
    final TextStyle unselectedLabelStyle = TextStyle(
        color: AppColors.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        fontFamily: 'sailec');

    final TextStyle selectedLabelStyle = TextStyle(
        color: AppColors.secondaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        fontFamily: 'sailec');
    return BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
      builder: (context, state) {
        if (state is HomeNavigationIndexState)
          return BottomNavigationBar(
            items: _navBarItems,
            onTap: _cubit.switchBottomNavIndex,
            currentIndex: state.index,
            elevation: 16,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.black.withOpacity(0.5),
            selectedItemColor: Colors.black,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
          );
        else
          throw UnimplementedError();
      },
    );
  }

  @override
  Widget setView() {
    return BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
      builder: (context, state) {
        if (state is HomeNavigationIndexState) {
          return PageTransitionSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (child, animation, secondaryAnimation) {
                return FadeThroughTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                );
              },
              child: _bodyWidgets[state.index]);
        } else
          throw UnimplementedError();
      },
    );
  }
}
