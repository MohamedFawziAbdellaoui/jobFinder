import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final bool selected;
  final Function(bool) onSelect;
  const CustomChip({
    super.key,
    required this.text,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : const Color(0xff189C77),
        ),
      ),
      onSelected: onSelect,
      selected: selected,
      disabledColor: Colors.white,
      selectedColor: const Color(0xff189C77),
    );
  }
}
