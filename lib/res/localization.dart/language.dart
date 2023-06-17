import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": {"email_hint": "Enter email",
        "lets_signin": "Let's Sign In",
        "forgot_password": "Forgot Password",
        "login_now": "LOGIN NOW",
        "dont_have_account": "Don't Have an Account?"
        },

        "ur_PK": {"email_hint": "ای میل درج کریں"}
      };
}
