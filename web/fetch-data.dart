// https://dart.dev/tutorials/web/fetch-data

import 'dart:html';
import 'dart:convert';

// 输入域
final InputElement favoriteNumber =
    querySelector('#favoriteNumber') as InputElement;
final InputElement valueOfPi = querySelector('#valueOfPi') as InputElement;
final InputElement horoscope = querySelector('#horoscope') as InputElement;
final InputElement favOne = querySelector('#favOne') as InputElement;
final InputElement favTwo = querySelector('#favTwo') as InputElement;
final InputElement favThree = querySelector('#favThree') as InputElement;
final RadioButtonInputElement loveChocolate =
    querySelector('#loveChocolate') as RadioButtonInputElement;
final RadioButtonInputElement noLoveForChocolate =
    querySelector('#noLoveForChocolate') as RadioButtonInputElement;

// 显示域绑定
final TextAreaElement intAsJson =
    querySelector('#intAsJson') as TextAreaElement;
final TextAreaElement doubleAsJson =
    querySelector('#doubleAsJson') as TextAreaElement;
final TextAreaElement stringAsJson =
    querySelector('#stringAsJson') as TextAreaElement;
final TextAreaElement listAsJson =
    querySelector('#listAsJson') as TextAreaElement;
final TextAreaElement boolAsJson =
    querySelector('#boolAsJson') as TextAreaElement;
final TextAreaElement mapAsJson =
    querySelector('#mapAsJson') as TextAreaElement;

void main() {
  // 设置监听器
  favoriteNumber.onKeyUp.listen(_showJson);
  valueOfPi.onKeyUp.listen(_showJson);
  loveChocolate.onClick.listen(_showJson);
  noLoveForChocolate.onClick.listen(_showJson);
  horoscope.onKeyUp.listen(_showJson);
  favOne.onKeyUp.listen(_showJson);
  favTwo.onKeyUp.listen(_showJson);
  favThree.onKeyUp.listen(_showJson);

  _populateFromJson();
  _showJson();
}

// 放一些默认的数据进去
void _populateFromJson() {
  const jsonDataAsString = '''{
    "favoriteNumber": 73,
    "valueOfPi": 3.141592,
    "chocolate": true,
    "horoscope": "Cancer",
    "favoriteThings": ["monkeys", "parrots", "lattes"]
  }''';

  Map<String, dynamic> jsonData =
      json.decode(jsonDataAsString) as Map<String, dynamic>;

  favoriteNumber.value = jsonData['favoriteNumber'].toString();
  valueOfPi.value = jsonData['valueOfPi'].toString();
  horoscope.value = jsonData['horoscope'].toString();
  final favoriteThings = jsonData['favoriteThings'] as List<dynamic>;
  favOne.value = favoriteThings[0] as String;
  favTwo.value = favoriteThings[1] as String;
  favThree.value = favoriteThings[2] as String;

  final chocolateRadioButton =
      jsonData['chocolate'] == false ? noLoveForChocolate : loveChocolate;
  chocolateRadioButton.checked = true;
}

// 显示Json
void _showJson([Event? _]) {
  // Grab the data that will be converted to JSON.
  final favNum = int.tryParse(favoriteNumber.value ?? '');
  final pi = double.tryParse(valueOfPi.value ?? '');
  final chocolate = loveChocolate.checked;
  final sign = horoscope.value;
  final favoriteThings = <String>[
    favOne.value ?? '',
    favTwo.value ?? '',
    favThree.value ?? '',
  ];

  final formData = {
    'favoriteNumber': favNum,
    'valueOfPi': pi,
    'chocolate': chocolate,
    'horoscope': sign,
    'favoriteThings': favoriteThings
  };

  // json编码，放到对应位置
  intAsJson.text = json.encode(favNum);
  doubleAsJson.text = json.encode(pi);
  boolAsJson.text = json.encode(chocolate);
  stringAsJson.text = json.encode(sign);
  listAsJson.text = json.encode(favoriteThings);
  mapAsJson.text = json.encode(formData);
}
