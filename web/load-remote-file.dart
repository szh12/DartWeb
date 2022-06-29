// 锛坔ttps://dart.dev/tutorials/web/fetch-data#using-getString-function锛�

import 'dart:async';
import 'dart:convert';
import 'dart:html';

final UListElement wordList = querySelector('#wordList') as UListElement;

void main() {
  querySelector('#getWords')!.onClick.listen(makeRequest);
}

Future<void> makeRequest(Event _) async {
  const path = 'portmanteaux.json';
  try {
    // 发起Get请求
    final jsonString = await HttpRequest.getString(path);
    // 请求成功，解析json
    processResponse(jsonString);
  } catch (e) {
    // 请求失败，显示错误信息
    print("Couldn't open $path");
    wordList.children.add(LIElement()..text = 'Request failed.');
  }
}

void processResponse(String jsonString) {
  final raw_data = json.decode(jsonString) as List<dynamic>;
  Set data = Set.from(raw_data); 
  for (final portmanteau in data) {
    wordList.children.add(LIElement()..text = portmanteau as String);
  }
}
