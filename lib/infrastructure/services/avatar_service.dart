import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class AvatarService extends GetxService {
  List<String> avatarUrls = [
    'https://ik.imagekit.io/q1wfe6nw4q6/avatar/9334389__8Bx-DoZl.jpg?updatedAt=1722093676114',
    'https://ik.imagekit.io/q1wfe6nw4q6/avatar/9334407_XZGcYJ8CE.jpg?updatedAt=1722093676105',
    'https://ik.imagekit.io/q1wfe6nw4q6/avatar/9440461_UjAfWHS1yt.jpg?updatedAt=1722093676170',
    'https://ik.imagekit.io/q1wfe6nw4q6/avatar/7294793_yyd-L75v1.jpg?updatedAt=1722093675662',
    'https://ik.imagekit.io/q1wfe6nw4q6/avatar/9439767_yHd08pJUqa.jpg?updatedAt=1722093502231'
  ];
  Rx<String?> selectedAvatar = Rx<String?>(null);
  @override
  void onInit() {
    super.onInit();
    selectedAvatar.value = avatarUrls[0];
  }

  void selectAvatar(String url) {
    selectedAvatar.value = url;
  }
}
