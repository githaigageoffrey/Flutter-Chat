import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationManager {
  // Map<String,String> messageBody;
  NotificationManager() {
    print("we are in here");
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (msg) {
      print(msg);
      return;
    }, onLaunch: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
    });
    fbm.subscribeToTopic('chat');
    fbm.subscribeToTopic('mpeketoni');
    fbm.getToken().then((token) => {print(token)});
  }
}
