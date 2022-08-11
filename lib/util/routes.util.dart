import 'package:caronapp/page/caronaAdd.page.dart';
import 'package:caronapp/page/caronaResult.page.dart';
import 'package:caronapp/page/groupAdd.page.dart';
import 'package:caronapp/page/groupDetail.page.dart';
import 'package:caronapp/page/location.page.dart';
import 'package:caronapp/page/login.page.dart';
import 'package:caronapp/page/document.page.dart';
import 'package:caronapp/page/signup.page.dart';
import 'package:caronapp/page/tabs.page.dart';
import 'package:caronapp/page/userVehicle.page.dart';
import 'package:caronapp/page/userVehicleAdd.page.dart';
import 'package:flutter/material.dart';

import '../page/caronaSearch.page.dart';
import '../page/groupAddByCode.page.dart';

///Classe de gerenciamento de rotas da aplicação
const String loginRoute = "/loginPage";
const String signupRoute = "/signupPage";
const String tabsPage = "/tabsPage";
const String documentPage = "/documentPage";
const String userVehiclePage = "/userVehiclePage";
const String userVehicleAddPage = "/userVehicleAddPage";
const String locationPage = "/locationPage";
const String caronaAddPage = "/caronaAddPage";
const String caronaSearchPage = "/caronaSearchPage";
const String caronaResultPage = "/caronaResultPage";
const String groupAdd = "/groupAdd";
const String groupAddByCode = "/groupAddByCode";
const String groupDetail = "/groupDetail";

class CustomRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    dynamic data;
    if (settings.arguments != null) {
      data = settings.arguments;
    }

    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case signupRoute:
        return MaterialPageRoute(builder: (_) => SignupPage());
      case tabsPage:
        return MaterialPageRoute(builder: (_) => const TabsPage());
      case documentPage:
        return MaterialPageRoute(builder: (_) => const DocumentPage());
      case userVehiclePage:
        return MaterialPageRoute(builder: (_) => UserVehiclePage());
      case userVehicleAddPage:
        return MaterialPageRoute(builder: (_) => const UserVehicleAddPage());
      case locationPage:
        return MaterialPageRoute(builder: (_) => LocationPage());
      case caronaAddPage:
        return MaterialPageRoute(builder: (_) => CaronaAddPage(groupID: data != null ? data[0] : null));
      case caronaSearchPage:
        return MaterialPageRoute(builder: (_) => const CaronaSearchPage());
      case caronaResultPage:
        return MaterialPageRoute(builder: (_) => CaronaResultPage(originID: data[0], destinationID: data[1], date: data[2]));
      case groupAdd:
        return MaterialPageRoute(builder: (_) => const GroupAddPage());
      case groupAddByCode:
        return MaterialPageRoute(builder: (_) => const GroupAddByCodePage());
      case groupDetail:
        return MaterialPageRoute(builder: (_) => GroupDetailPage(model: data[0], index: data[1]));
    }
    return null;
  }
}
