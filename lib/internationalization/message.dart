import 'package:get/get.dart';
import 'intl_zh_cn.dart';
import 'intl_zh_HK.dart';
import 'intl_en_US.dart';
import 'intl_en_id.dart';
import 'intl_en_ru.dart';
import 'intl_en_ja.dart';
import 'intl_en_ko.dart';
import 'intl_en_fr.dart';
import 'intl_en_es.dart';
import 'intl_en_ed.dart';
import 'intl_en_XA.dart';
import 'intl_en_vi.dart';

class Messages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'zh_Hans': intlZhCn,// 简体
    'zh_Hant': intlZhHK,// 繁体
    'en': intlEnUS,// 英语
    'id': intlEnId,// 印尼
    'ru': intlEnRu,// 俄罗斯
    'ja': intlEnJa,// 日语
    'ko': intlEnKo,// 韩语
    'fr': intlEnFr,// 法语
    'es': intlEnEs,// 西班牙
    'ed': intlEnEd,// 德语
    'XA': intlEnXA,// 阿拉伯 有异议
    'vi': intlEnVi,// 越南语
  };
}

// Locale.fromSubtags(languageCode: 'en'),
// Locale.fromSubtags(languageCode: 'ar'),
// Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
// Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
// Locale.fromSubtags(languageCode: 'vi'),
// Locale.fromSubtags(languageCode: 'id'),
// Locale.fromSubtags(languageCode: 'ru'),
// Locale.fromSubtags(languageCode: 'ja'),
// Locale.fromSubtags(languageCode: 'ko'),
// Locale.fromSubtags(languageCode: 'fr'),
// Locale.fromSubtags(languageCode: 'es'),
