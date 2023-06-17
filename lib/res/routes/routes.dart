import 'package:Blockrium/res/routes/routes_name.dart';
import 'package:get/get.dart';
import '../../View new/authentication/loginpage.dart';
import '../../View/bottomnav.dart';
import '../../main.dart';

class AppRoutes {
  static appRoutes() => [
        // GetPage(
        //     name: RoutesName.splashScreen,
        //     page: () => SplashScreen(),
        //     transition: Transition.fade),
        GetPage(
          name: RoutesName.loginScreen,
          page: () => LoginPage(),
          // transition: Transition.fade
        ),
        // GetPage(
        //   name: RoutesName.homeScreen,
        //   page: () => HomePage(),
        //   // transition: Transition.fade
        // ),
        GetPage(
          name: RoutesName.bottomnavigation,
          page: () => MyBottomNavbar(),
          // transition: Transition.fade
        ),
      ];
}
