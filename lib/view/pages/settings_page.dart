import 'package:flutter/material.dart';
import 'package:qr_code_generator/view/widgets/payments.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_code_generator/model/qr_code_data.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('change output qr size 200x200, ',
                style: TextStyle(fontSize: 24)),
            Text('default colors'),
            Text('default everything'),
            Text('change Ai model'),
            Text('ai quality slider'),
            Text('support us by leaving a review'),
            PaymentButton(),
            PersistentMenuSelector(
              prefsName: qrCodePrefName,
              options: qrCodeSizeOptions,
              selectedOption: selectedQrCodeSize,
              onChanged: (String newValue) => selectedQrCodeSize = newValue,
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentButton extends StatefulWidget {
  const PaymentButton({super.key});

  @override
  State<PaymentButton> createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentApp()),
          );
        },
        child: const Text("payment"));
  }
}

class PersistentMenuSelector extends StatefulWidget {
  final String prefsName;
  final List<String> options;
  String selectedOption;
  final ValueChanged<String> onChanged;

  PersistentMenuSelector({
    required this.prefsName,
    required this.selectedOption,
    required this.options,
    required this.onChanged,
    super.key,
  });
  @override
  PersistentMenuSelectorState createState() => PersistentMenuSelectorState();
}

class PersistentMenuSelectorState extends State<PersistentMenuSelector> {
  @override
  void initState() {
    super.initState();
  }

  // Load the saved selected option from SharedPreferences

  // Save the selected option to SharedPreferences
  Future<void> _saveSelectedOption(String option) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(widget.prefsName, option);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${widget.prefsName}: ',
          style: const TextStyle(fontSize: 20),
        ),
        DropdownButton<String>(
          style: TextStyle(fontSize: 20),
          value: widget.selectedOption,
          items: widget.options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              widget.selectedOption = newValue!;
              widget.onChanged(newValue);
            });
            _saveSelectedOption(newValue!); // Save the new selection
          },
        ),
      ],
    );
  }
}
