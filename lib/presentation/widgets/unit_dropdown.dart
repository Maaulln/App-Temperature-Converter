import 'package:flutter/material.dart';

import '../../domain/entities/temperature_unit.dart';

class UnitDropdown extends StatelessWidget {
  const UnitDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final TemperatureUnit value;
  final ValueChanged<TemperatureUnit> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<TemperatureUnit>(
          initialValue: value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: TemperatureUnit.values
              .map(
                (unit) => DropdownMenuItem<TemperatureUnit>(
                  value: unit,
                  child: Text(unit.displayName),
                ),
              )
              .toList(),
          onChanged: (unit) {
            if (unit != null) {
              onChanged(unit);
            }
          },
        ),
      ],
    );
  }
}
