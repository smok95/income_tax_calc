import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jk/flutter_jk.dart'; // KrUtils
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:vibration/vibration.dart';

import 'num_pad.dart';
import 'pdf_view_page.dart';
import 'money_masked_text_controller.dart';

class IncomeTaxCalcPage extends StatefulWidget {
  final Widget adBanner;

  IncomeTaxCalcPage({this.adBanner});

  @override
  _IncometaxCalcState createState() => _IncometaxCalcState();
}

class _IncometaxCalcState extends State<IncomeTaxCalcPage> {
  int _dependants = 1;
  int _youngDependants = 0;
  int _salary = 0;
  final _title = '소득세 계산기';

  /// 최대 계산 가능 금액 (9999억..., )
  /// 제한금액은 [money_masked_text_controller]의 제한 자리수 기준으로 정했음.
  final _maximumSalary = 999999999999;

  /// 소득세
  int _tax = 0;

  /// 지방소득세
  int _localTax = 0;
  String _result = '';
  final Radius _radius = Radius.circular(5.0);

  /// 선택 세율(80%, 100%, 120%)
  double _taxRate = 1.0;
  Flushbar _flushbar;

  Color _fillColor = Colors.grey[100];
  MoneyMaskedTextController _controller = MoneyMaskedTextController(
      precision: 0, thousandSeparator: ',', decimalSeparator: '');

  @override
  void initState() {
    super.initState();
    _controller.addListener(_textControllerListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_textControllerListener);
    super.dispose();
  }

  void _textControllerListener() {
    final value = _controller.numberValue.toInt();
    if (value == _salary) return;
    print('textController value changed, ${_controller.numberValue}');

    _salary = value;
    _calc();
  }

  _calc() {
    final calculator = IncomeTaxCalc();
    _tax = calculator.calc(_salary, _dependants + _youngDependants,
        taxRate: _taxRate);
    _localTax = calculator.calcLocalIncomeTax(_tax);
    setState(() {});
  }

  String _salaryToEmoticon() {
    final money = _salary ~/ 10000;
    if (money < 100) {
      return '';
    } else if (100 <= money && money < 200) {
      return '🙂';
    } else if (200 <= money && money < 300) {
      return '😊';
    } else if (300 <= money && money < 400) {
      return '😚';
    } else if (400 <= money && money < 500) {
      return '😀';
    } else if (500 <= money && money < 600) {
      return '😃';
    } else if (600 <= money && money < 700) {
      return '😄';
    } else if (700 <= money && money < 800) {
      return '😁';
    } else if (800 <= money && money < 900) {
      return '😍';
    } else if (900 <= money && money < 1000) {
      return '🤑';
    } else if (1000 <= money && money < 1500) {
      return '🥳';
    } else if (1500 <= money && money < 3000) {
      return '💵🤓';
    } else if (3000 <= money && money < 5000) {
      return '👏😎';
    } else if (5000 <= money && money < 10000) {
      return '🤔';
    } else if (10000 <= money && money < 100000) {
      return '😕';
    } else if (100000 <= money && money < 1000000) {
      return '😮';
    } else if (1000000 <= money && money < 10000000) {
      return '😲';
    } else {
      return '😱';
    }
  }

  /// 화면 상단 앱타이틀
  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          _title,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () async {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            showAboutDialog(
                context: context,
                applicationVersion: packageInfo.version,
                applicationLegalese: '오늘 하루도 수고하셨습니다 :)\n',
                children: [
                  Text(
                    '''"소득세 계산기"는 2020년 2월 개정된 근로소득 간이세액표 기준으로 만들어졌습니다.
해당 프로그램의 계산결과는 참고용 자료이며, 실제 징수세금과는 차이가 있을 수 있습니다.
                
- 월급여액은 비과세 소득을 제외한 금액입니다.
- "부양가족 수(본인포함)"는 본인을 포함한 기본공제대상자에 해당하는 부양가족의 수입니다.
- "20세 이하 자녀 수"는 기본공제대상자에 해당하는 20세 이하의 자녀수입니다.
- 연간 소득금액이 100만원을 초과하는 경우에는 기본공제대상자에서 제외되며, 
  20세 이하의 자녀이더라도 연간 소득금액이 100만원을 초과하면 자녀수에서 제외합니다.

* 근로자는 원천징수세액을 근로소득간이세액표에 따른 세액의 80%, 100%, 120% 중에서 선택할 수 있습니다.
(원천징수의무자에게 '소득세 원천징수세액 조정신청서'를 제출하여야 함.)

문의 : kjk15881588@gmail.com
                ''',
                    style: TextStyle(fontSize: 15),
                  )
                ]);
          },
        ),
        Spacer(),
        Text(
          _salaryToEmoticon(),
          style: TextStyle(fontSize: 30),
        )
      ],
    );
  }

  /// 급여액 입력란
  Widget _builTextInput() {
    String moneyString = _salary > 0 ? KrUtils.numberToManwon(_salary) : '';

    return TextField(
      readOnly: true,
      showCursor: true,
      autofocus: true,
      controller: _controller,
      decoration: InputDecoration(
        labelText: '월 급여액  ' + moneyString,
        suffixText: '원',
        isDense: true,
        labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: '월급여액',
        border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(_radius)),
        filled: true,
        fillColor: _fillColor,
      ),
      textAlign: TextAlign.right,
      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
      keyboardType:
          TextInputType.numberWithOptions(signed: true, decimal: false),
      onChanged: (value) {
        _salary = _controller.numberValue.toInt();
        _calc();
      },
    );
  }

  /// 급여액 한글 도움말
  Widget _buildMoneyHelpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          KrUtils.numberToManwon(_salary),
          textAlign: TextAlign.end,
        ),
        Text('     ')
      ],
    );
  }

  void _vibrate() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 3);
    }
  }

  Widget _buildNumberStepper(
      final String label, int value, void Function(int) onChanged,
      {int minimum = 1, int maximum = 999}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        NumStepper(
            width: 150.0,
            minimum: minimum,
            maximum: maximum,
            rightSymbol: ' 명',
            textStyle: TextStyle(fontSize: 15),
            value: value,
            onChanged: onChanged)
      ],
    );
  }

  /// 부양가족수 설정 컨트롤
  Widget _buildDependantsInput() {
    return _buildNumberStepper('부양가족 수(본인포함) ', _dependants, (value) {
      _vibrate();

      if (value <= _youngDependants) {
        _showFlushbar('부양가족의 수는 자녀 수보다 많아야 합니다.');
        value += 1;
      }

      _dependants = value;
      _calc();
    });
  }

  void _showFlushbar(final String message) {
    if (_flushbar?.isShowing() ?? false) {
      _flushbar.dismiss();
    }

    _flushbar = Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        color: Colors.redAccent,
      ),
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    );

    _flushbar.show(context);
  }

  /// 20세 이하 자녀 설정 컨트롤
  Widget _buildYoungDependants() {
    return _buildNumberStepper('20세 이하 자녀 수 ', _youngDependants, (value) {
      print(value);
      _vibrate();

      if (value >= _dependants) {
        _showFlushbar('자녀의 수는 부양가족 수보다 적어야 합니다.');
        value = _dependants - 1;
      }

      _youngDependants = value;
      _calc();
    }, minimum: 0);
  }

  /// 원천징수 세율 토글버튼
  Widget _buildTaxRateToggleButtons() {
    final isSelected = [_taxRate == 0.8, _taxRate == 1.0, _taxRate == 1.2];

    Text _createText(final data, final bool selected) {
      return Text(
        data,
        style: TextStyle(
            fontSize: selected ? 15 : 14,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('원천징수 세율'),
        ToggleButtons(
          constraints: BoxConstraints(minHeight: 25, minWidth: 48),
          children: [
            _createText('80%', isSelected[0]),
            _createText('100%', isSelected[1]),
            _createText('120%', isSelected[2]),
          ],
          fillColor: Colors.transparent,
          selectedColor: Colors.black,
          color: Colors.grey,
          borderColor: Colors.transparent,
          selectedBorderColor: Colors.transparent,
          isSelected: isSelected,
          onPressed: (index) {
            _vibrate();
            if (index == 0)
              _taxRate = 0.8;
            else if (index == 2)
              _taxRate = 1.2;
            else
              _taxRate = 1.0;
            _calc();
          },
        )
      ],
    );
  }

  /// 계산결과 뷰
  Widget _buildResultView() {
    String getMoneyString(int value) {
      return FlutterMoneyFormatter(amount: value.toDouble())
          .output
          .withoutFractionDigits;
    }

    final tax = getMoneyString(_tax);
    final localTax = getMoneyString(_localTax);
    final total = getMoneyString(_tax + _localTax);

    Widget createResultRow(String label, String value) {
      final style = TextStyle(fontWeight: FontWeight.bold, fontSize: 17);
      final labelStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 17);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: labelStyle),
          Text('$value 원', style: style)
        ],
      );
    }

    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(_radius), color: Colors.amberAccent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          createResultRow('소득세 ', tax),
          createResultRow('지방소득세 ', localTax),
          createResultRow('합계액 ', total),
        ],
      ),
    );
  }

  /// 전체 초기화
  void _clearAll() {
    _controller.updateValue(0.0);
    _salary = 0;
    _dependants = 1;
    _youngDependants = 0;
    _taxRate = 1.0;
    _calc();
  }

  /// 초기화 버튼
  Widget _buildResetButton() {
    return InkWell(
      borderRadius: BorderRadius.all(_radius),
      child: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        child: Text(
          '초기화',
          style: TextStyle(fontSize: 15.0),
        ),
      ),
      onTap: () {
        _vibrate();
        _clearAll();
      },
    );
  }

  Widget _buildDrawer() {
    const EdgeInsetsGeometry padding = EdgeInsets.only(left: 10, top: 10);
    const String taxTable = '근로소득 간이세액표';
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
            height: 60,
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              padding: padding,
              decoration: BoxDecoration(color: Colors.amberAccent),
              child: Text(_title, style: TextStyle(fontSize: 24)),
            )),
        ListTile(
          leading: Icon(Icons.picture_as_pdf),
          title: Text(taxTable),
          onTap: () async {
            const String assetFile = 'assets/2020_income_tax_table.pdf';
            final document = await PDFDocument.fromAsset(assetFile);

            Get.to(PdfViewPage(document,
                bottomAd: widget.adBanner, title: taxTable));
            /*
            final file = await Utils.fromAsset(
                //'assets/_nts_data_info_조회_2020년_근로소득_간이세액표(조견표).pdf',
                'assets/2020_income_tax_table.pdf',
                '2020_income_tax_table.pdf');

            Get.to(PdfViewPage(
              file.path,
              bottomAd: this.widget.adBanner,
              title: taxTable,
            ));
            */
          },
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Colors.white;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        shadowColor: Colors.transparent,
        title: _buildTitle(),
      ),
      drawer: _buildDrawer(),
      body: SafeArea(
          child: Column(children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: Column(
            children: [
              _builTextInput(),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  _buildDependantsInput(),
                  _buildYoungDependants(),
                  _buildTaxRateToggleButtons(),
                ],
              ))),
              Padding(padding: EdgeInsets.all(5)),
              Expanded(child: _buildResultView()),
              //_buildResetButton(),
              NumberButtonBar(
                [100, 10, 1],
                suffix: '만',
                onPressed: (value) {
                  print('NumberButtonBar.onPressed=$value');

                  _vibrate();

                  var newVal = _controller.numberValue + value * 10000;
                  if (newVal < 0) newVal = 0;
                  if (newVal > _maximumSalary) {
                    _showFlushbar(
                        '최대 ${KrUtils.numberToManwon(_maximumSalary)} 까지만 계산 가능합니다.');
                    return;
                  }

                  _controller.updateValue(newVal.toDouble());
                  _salary = newVal.toInt();
                  _calc();
                },
              ),

              NumPad(
                height: 190,
                onPressed: (value) {
                  _vibrate();
                  _controller.insertInt(value);
                },
                onBackspace: () {
                  _vibrate();
                  _controller.removeNumber();
                },
                onClear: () {
                  _vibrate();
                  _clearAll();
                },
              ),
            ],
          ),
        ))
      ])),
    );
  }
}
