import 'package:caronapp/service/location.service.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../service/carona.service.dart';
import '../service/account.service.dart';
import '../service/group.service.dart';

///Classe para centralizar os providers utilizados na aplicacao
class CustomMultiProvider extends StatelessWidget {
  final Widget child;

  const CustomMultiProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AccountService>(create: (_) => AccountService()),
        ChangeNotifierProvider<CaronaService>(create: (_) => CaronaService()),
        ChangeNotifierProvider<GroupService>(create: (_) => GroupService()),
        ChangeNotifierProvider<LocationService>(create: (_) => LocationService()),
      ],
      child: child,
    );
  }
}
