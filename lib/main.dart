import 'package:caronapp/page/splashscreen.page.dart';
import 'package:caronapp/theme/material.theme.dart';
import 'package:caronapp/util/multiProvider.util.dart';
import 'package:caronapp/util/routes.util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  Intl.defaultLocale = 'pt_BR';
  runApp(const Caronapp());
}

class Caronapp extends StatelessWidget {
  const Caronapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomMultiProvider(child: Sizer(
      builder: (context, orientation, deviceType) {
        //WidgetsFlutterBinding.ensureInitialized();
        return MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const <Locale>[Locale("pt", "BR")],
          debugShowCheckedModeBanner: false,
          title: 'Caronapp',
          onGenerateRoute: CustomRouter.onGenerateRoute,
          scaffoldMessengerKey: scaffoldMessengerKey,
          home: const SplashScreenPage(),
          theme: materialTheme,
        );
      },
    ));
  }
}
