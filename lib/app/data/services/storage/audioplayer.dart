import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';

import '../../../modules/settings/controllers/settings_controller.dart';

class AudioPlayerServices {
  final settingsCtr = Get.put<SettingsController>(SettingsController());

  doneTodoAudio() {
    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/sounds/${settingsCtr.selectedAudioForNotification}.mp3"),
      autoStart: true,
    );
  }

  deleteTodoAudio() {
    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/sounds/deleteSound.mp3"),
      autoStart: true,
    );
  }
}
