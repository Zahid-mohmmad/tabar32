import 'package:flutter/material.dart';

class SizeSelectionWidget extends StatefulWidget {
  final List<String> sizes;
  final Function(String) onSizeSelected;

  const SizeSelectionWidget(
      {super.key, required this.sizes, required this.onSizeSelected});

  @override
  _SizeSelectionWidgetState createState() => _SizeSelectionWidgetState();
}

class _SizeSelectionWidgetState extends State<SizeSelectionWidget> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select Size:", style: TextStyle(fontSize: 16)),
        Wrap(
          spacing: 4.0,
          children: widget.sizes.map((size) {
            return ChoiceChip(
              label: Text(size),
              selected: selectedSize == size,
              onSelected: (bool selected) {
                setState(() {
                  selectedSize = selected ? size : null;
                });
                widget.onSizeSelected(selectedSize!);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
