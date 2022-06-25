import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: neutral_40, width: 1),
      ),
      padding: EdgeInsets.only(left: 12),
      width: double.infinity,
      child: Row(
        children: [
          SvgPicture.asset(
            iconCard,
            height: 24,
            width: 24,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(
            width: 8,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
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
          ),
        ],
      ),
    );
  }
}
