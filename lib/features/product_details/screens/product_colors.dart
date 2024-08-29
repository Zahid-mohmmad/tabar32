import 'package:flutter/material.dart';

class ColorSelectionWidget extends StatefulWidget {
  final List<String> colors;
  final Function(String) onColorSelected;

  const ColorSelectionWidget({
    Key? key,
    required this.colors,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  _ColorSelectionWidgetState createState() => _ColorSelectionWidgetState();
}

class _ColorSelectionWidgetState extends State<ColorSelectionWidget> {
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Color:",
          style: TextStyle(fontSize: 14), // Reduced font size
        ),
        Wrap(
          spacing: 4.0, // Reduced spacing between chips
          children: widget.colors.map((color) {
            return ChoiceChip(
              label: Text(
                color,
                style: const TextStyle(
                    fontSize: 12), // Reduced font size for chip labels
              ),
              selected: selectedColor == color,
              onSelected: (bool selected) {
                setState(() {
                  selectedColor = selected ? color : null;
                });
                widget.onColorSelected(selectedColor!);
              },
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4), // Reduced padding inside chips
              labelPadding: const EdgeInsets.symmetric(
                  horizontal: 4), // Reduced padding around the label
            );
          }).toList(),
        ),
      ],
    );
  }
}
