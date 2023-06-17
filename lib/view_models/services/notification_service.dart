import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../main.dart';

class NotificationsSerives {
void showNoification(hours, title, body) async {
    // Create a Bitmap image from a file
    // final String imagePath =
    //     'assets/splash1.png'; // replace with the path of your image
    // final DrawableResourceAndroidBitmap largeIcon =
    //     DrawableResourceAndroidBitmap("assets/splash1.png");
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      "MaticLegend", "Clound Mining",
      priority: Priority.max,
      importance: Importance.max,
      enableVibration: true,
      // largeIcon: largeIcon,
      //  sound: RawResourceAndroidNotificationSound('my_ringtone'),
    );

    DarwinNotificationDetails iosDetails =
        DarwinNotificationDetails(presentAlert: true, presentSound: true);

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    DateTime scheduleDate = tz.TZDateTime.now(tz.getLocation('Asia/Kolkata'))
        .add(Duration(minutes: hours));
    await notificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.from(
          scheduleDate,
          tz.getLocation('Asia/Kolkata'),
        ),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true);
  }
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   final AndroidInitializationSettings _androidInitializationSettings =
//       AndroidInitializationSettings("splash1");

//   void initialiseNotifications() async {
//     InitializationSettings initializationSettings = InitializationSettings(
//       android: _androidInitializationSettings,
//     );
//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   void sendNotifiation(String title, body) async {
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails("channelId", 'channelName',
//             importance: Importance.max, priority: Priority.max);
//     NotificationDetails notificationDetails = NotificationDetails();
//     _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
//   }
}
