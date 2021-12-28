import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:translator/translator.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

GoogleTranslator translator = GoogleTranslator();
TextEditingController inputController = TextEditingController();
var firstColor = const Color(0xff220c33);
var output;

String? selectedValue;
Map<String, String> items = {
  'en': 'English',
  'de': 'Germany',
  'ru': 'Russia',
  'es': 'Spain',
  'fr': 'French'
};

class _AnasayfaState extends State<Anasayfa> {
  void translate() async {
    output = await translator.translate(inputController.text,
        from: 'tr', to: selectedValue.toString());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Translate"),
          backgroundColor: firstColor,
        ),
        body: Padding(
          padding: context.paddingNormal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              emptyBox(0.03),
              TextField(
                controller: inputController,
                cursorColor: firstColor,
                decoration: InputDecoration(
                    labelText: 'Word or Phrase',
                    labelStyle: TextStyle(color: firstColor),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: firstColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: firstColor))),
              ),
              emptyBox(0.07),
              textWidget('Choose Language'),
              emptyBox(0.01),
              dropDownMenu(context),
              emptyBox(0.04),
              buttonWidget(),
              emptyBox(0.07),
              textWidget('Translated'),
              emptyBox(0.01),
              Container(
                height: context.height * 0.12,
                width: context.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: firstColor, spreadRadius: 1)]),
                child: Padding(
                  padding: context.paddingLow,
                  child: Text(output.toString()),
                ),
              ),
            ],
          ),
        ));
  }

  Center dropDownMenu(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Languages',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff220c33),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Center(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff220c33),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          icon: const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: firstColor,
          iconDisabledColor: Colors.grey,
          buttonHeight: context.height * 0.06,
          buttonWidth: context.width,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: firstColor,
            ),
            color: Colors.white,
          ),
          buttonElevation: 2,
          itemHeight: 40,
          itemWidth: context.width,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownPadding: null,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
        ),
      ),
    );
  }

//Widgets
  Center buttonWidget() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          translate();
        },
        child: const Text("Translate"),
        style: ElevatedButton.styleFrom(primary: firstColor),
      ),
    );
  }

  SizedBox emptyBox(double value) => SizedBox(height: context.height * value);

  Text textWidget(String text) {
    return Text(
      text,
      style: TextStyle(color: firstColor, fontWeight: FontWeight.w500),
    );
  }
}
