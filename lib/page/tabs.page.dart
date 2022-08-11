import 'package:caronapp/page/userCarona.page.dart';
import 'package:caronapp/page/group.page.dart';
import 'package:caronapp/page/home.page.dart';
import 'package:caronapp/page/profile.page.dart';
import 'package:caronapp/util/responsivity.util.dart';
import 'package:caronapp/widget/customGradientImage.widget.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: ((value) => setState(() {
              _tabController.index = value;
            })),
        items: [
          BottomNavigationBarItem(
            label: "Home",
            activeIcon: GradientImage('assets/icon_home.svg', size: 30.r, active: true),
            icon: GradientImage('assets/icon_home.svg', size: 30.r, active: false),
          ),
          BottomNavigationBarItem(
            label: "Grupos",
            activeIcon: GradientImage('assets/icon_group.svg', size: 30.r, active: true),
            icon: GradientImage('assets/icon_group.svg', size: 30.r, active: false),
          ),
          BottomNavigationBarItem(
            label: "Caronas",
            activeIcon: GradientImage('assets/icon_carona.svg', size: 30.r, active: true),
            icon: GradientImage('assets/icon_carona.svg', size: 30.r, active: false),
          ),
          BottomNavigationBarItem(
            label: "Perfil",
            activeIcon: GradientImage('assets/icon_profile.svg', size: 30.r, active: true),
            icon: GradientImage('assets/icon_profile.svg', size: 30.r, active: false),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomePage(),
          GroupPage(),
          UserCaronaPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
