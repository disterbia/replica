import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FirebaseService extends GetxService {
  Future<FirebaseService> init() async {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDWaktX1bwYSXv0iFjpDC2JZuxSnlxzacs",
            appId: "1:854934436212:web:97cc23dc830f7546841421",
            messagingSenderId: "854934436212",
            projectId: "replica-e115a"));
    //print('\x1B[95m========== Firebase initialized ==========\x1B[105m');
    return this;
  }
}
