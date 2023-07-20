import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labour/src/app/presentation/screens/categories_screen/categories_screen.dart';
import 'package:labour/src/app/presentation/screens/home_screen/home_screen.dart';
import 'package:labour/src/app/presentation/screens/order_screen/order_screen.dart';
import 'package:labour/src/app/presentation/screens/profile_screen/profile/profile_screen.dart';
import 'package:labour/src/core/resources/app_assets.dart';

class AppLayOutScreen extends StatefulWidget {
  const AppLayOutScreen({Key? key}) : super(key: key);

  @override
  State<AppLayOutScreen> createState() => _AppLayOutScreenState();
}

class _AppLayOutScreenState extends State<AppLayOutScreen> {
  final List<Widget> screens = [
    const HomeScreen(),
    const OrderScreen(),
    const CategoriesScreen(),
    const ProfileScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        _bottomNavItem(
          icon: AppAssets.home,
        ),
        _bottomNavItem(
          icon: AppAssets.order,
        ),
        _bottomNavItem(
          icon: AppAssets.dashboard,
        ),
        _bottomNavItem(
          icon: AppAssets.user,
        ),
      ],
    );
  }

  BottomNavigationBarItem _bottomNavItem({
    required String icon,
  }) {
    return BottomNavigationBarItem(
      label: '',
      icon: Padding(
        padding: const EdgeInsetsDirectional.only(top: 10),
        child: SvgPicture.asset(
          icon,
          width: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}


