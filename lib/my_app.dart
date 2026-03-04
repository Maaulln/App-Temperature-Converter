import 'package:flutter/material.dart';
import 'utils/temperature_converter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TemperatureConverterPage(),
    );
  }
}

class TemperatureConverterPage extends StatefulWidget {
  const TemperatureConverterPage({super.key});

  @override
  State<TemperatureConverterPage> createState() =>
      _TemperatureConverterPageState();
}

class _TemperatureConverterPageState extends State<TemperatureConverterPage> {
  final _inputController = TextEditingController();
  TemperatureUnit _fromUnit = TemperatureUnit.celsius;
  TemperatureUnit _toUnit = TemperatureUnit.fahrenheit;
  String _result = '';

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _convert() {
    final input = double.tryParse(_inputController.text);
    if (input == null) {
      setState(() => _result = 'Masukkan angka yang valid');
      return;
    }

    final result = TemperatureConverter.convert(input, _fromUnit, _toUnit);
    setState(() {
      _result =
          '${input.toStringAsFixed(2)} ${_fromUnit.symbol} = '
          '${result.toStringAsFixed(2)} ${_toUnit.symbol}';
    });
  }

  void _swapUnits() {
    setState(() {
      final temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputField(),
            const SizedBox(height: 16),
            _buildUnitSelectors(),
            const SizedBox(height: 24),
            _buildConvertButton(),
            const SizedBox(height: 24),
            if (_result.isNotEmpty) _buildResultCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return TextField(
      controller: _inputController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(
        labelText: 'Masukkan Suhu',
        border: OutlineInputBorder(),
        hintText: 'Contoh: 100',
      ),
    );
  }

  Widget _buildUnitSelectors() {
    return Row(
      children: [
        Expanded(
          child: _UnitDropdown(
            label: 'Dari:',
            value: _fromUnit,
            onChanged: (unit) => setState(() => _fromUnit = unit),
          ),
        ),
        _buildSwapButton(),
        Expanded(
          child: _UnitDropdown(
            label: 'Ke:',
            value: _toUnit,
            onChanged: (unit) => setState(() => _toUnit = unit),
          ),
        ),
      ],
    );
  }

  Widget _buildSwapButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: IconButton(
        onPressed: _swapUnits,
        icon: const Icon(Icons.swap_horiz, size: 32),
        tooltip: 'Tukar satuan',
      ),
    );
  }

  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: _convert,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const Text('Konversi', style: TextStyle(fontSize: 18)),
    );
  }

  Widget _buildResultCard(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Hasil:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              _result,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _UnitDropdown extends StatelessWidget {
  const _UnitDropdown({
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
          value: value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: TemperatureUnit.values
              .map(
                (unit) => DropdownMenuItem(
                  value: unit,
                  child: Text(unit.displayName),
                ),
              )
              .toList(),
          onChanged: (unit) {
            if (unit != null) onChanged(unit);
          },
        ),
      ],
    );
  }
}
