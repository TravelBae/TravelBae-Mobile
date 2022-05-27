import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({Key? key}) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdown();
}

class _CustomDropdown extends State<CustomDropdown> {
  String dropdownValue = 'Mandiri';
  String holder = '';
  List<String> dropList = ['Mandiri', 'Gopay', 'Shopeepay', 'BCA'];
  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Row(
        children: [
          DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: dropList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
