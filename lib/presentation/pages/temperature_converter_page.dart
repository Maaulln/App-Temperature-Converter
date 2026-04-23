import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/temperature_converter_bloc.dart';
import '../widgets/unit_dropdown.dart';

class TemperatureConverterPage extends StatelessWidget {
  const TemperatureConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocBuilder<TemperatureConverterBloc, TemperatureConverterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Masukkan Suhu',
                    border: OutlineInputBorder(),
                    hintText: 'Contoh: 100',
                  ),
                  onChanged: (value) => context
                      .read<TemperatureConverterBloc>()
                      .add(TemperatureInputChanged(value)),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: UnitDropdown(
                        label: 'Dari:',
                        value: state.fromUnit,
                        onChanged: (unit) {
                          context.read<TemperatureConverterBloc>().add(
                            FromUnitChanged(unit),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: IconButton(
                        onPressed: () {
                          context.read<TemperatureConverterBloc>().add(
                            const SwapUnitsRequested(),
                          );
                        },
                        icon: const Icon(Icons.swap_horiz, size: 32),
                        tooltip: 'Tukar satuan',
                      ),
                    ),
                    Expanded(
                      child: UnitDropdown(
                        label: 'Ke:',
                        value: state.toUnit,
                        onChanged: (unit) {
                          context.read<TemperatureConverterBloc>().add(
                            ToUnitChanged(unit),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.read<TemperatureConverterBloc>().add(
                      const ConvertRequested(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Konversi', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 24),
                if (state.result.isNotEmpty || state.errorMessage != null)
                  Card(
                    color: state.status == TemperatureConverterStatus.error
                        ? Theme.of(context).colorScheme.errorContainer
                        : Theme.of(context).colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text('Hasil:', style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Text(
                            state.errorMessage ?? state.result,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color:
                                  state.status ==
                                      TemperatureConverterStatus.error
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.onErrorContainer
                                  : null,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
