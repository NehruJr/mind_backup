import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/core.dart';

class SettingsController extends GetxController {
  var boxStorage = GetStorage();
  RxString langLocale = ene.obs;
  RxDouble fontSize = 0.0.obs;

  RxString selectedFontFamily = 'Roboto'.obs;
  List<String> listOfFonts = <String>[
    'Roboto',
    'YanoneKaffeesatz',
    'Tajawal',
    'Almarai',
  ];

  RxString selectedAudioForNotification = 'doneNotification'.obs;
  List<String> listOfAudios = <String>[
    'doneNotification',
    'bravo',
  ];

  @override
  void onReady() async {
    super.onReady();
    langLocale.value = await getLanguage;
    selectedFontFamily.value = await getFontFamily;
    fontSize.value = double.parse(await getFontSize);
    selectedAudioForNotification.value = await getDoneAudio;
    ever(selectedFontFamily, saveFontFamily);
  }

  void changeDoneAudio(String value) {
    selectedAudioForNotification.value = value;
    saveDoneAudio(selectedAudioForNotification.value);
    update();
  }

  void changeFontFamily(String value) {
    selectedFontFamily.value = value;
    saveFontFamily(selectedFontFamily.value);
    update();
  }

  void changeFontSize(double value) {
    fontSize.value = value;
    saveFontSize(value.toString());
    update();
  }

  void changeLanguage(String typeLang) {
    saveLanguage(typeLang);
    if (langLocale.value == typeLang) {
      return;
    } else if (typeLang == ara) {
      langLocale.value = ara;
      saveLanguage(ara);
    } else {
      langLocale.value = ene;
      saveLanguage(ene);
    }
    update();
  }

  void saveLanguage(String lang) async {
    await boxStorage.write("lang", lang);
  }

  Future<String> get getLanguage async {
    return await boxStorage.read("lang");
  }

  void saveFontFamily(String fontFamily) async {
    await boxStorage.write("fontFamily", fontFamily);
    update();
  }

  Future<String> get getFontFamily async {
    return await boxStorage.read("fontFamily");
  }

  void saveFontSize(String fontSize) async {
    await boxStorage.write("fontSize", fontSize);
    update();
  }

  Future<String> get getFontSize async {
    return await boxStorage.read("fontSize");
  }

  void saveDoneAudio(String doneAudio) async {
    await boxStorage.write("doneAudio", doneAudio);
    update();
  }

  Future<String> get getDoneAudio async {
    return await boxStorage.read("doneAudio");
  }
}
