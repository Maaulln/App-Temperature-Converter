import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temperatureconverter/domain/entities/temperature_unit.dart';
import 'package:temperatureconverter/domain/usecases/convert_temperature_usecase.dart';
import 'package:temperatureconverter/presentation/bloc/temperature_converter_bloc.dart';

void main() {
  group('TemperatureConverterBloc', () {
    late TemperatureConverterBloc bloc;

    setUp(() {
      bloc = TemperatureConverterBloc(ConvertTemperatureUseCase());
    });

    tearDown(() {
      bloc.close();
    });

    test('has expected initial state', () {
      expect(bloc.state, const TemperatureConverterState());
    });

    blocTest<TemperatureConverterBloc, TemperatureConverterState>(
      'emits ready state when input changes',
      build: () => bloc,
      act: (bloc) => bloc.add(const TemperatureInputChanged('100')),
      expect: () => [
        const TemperatureConverterState(
          input: '100',
          status: TemperatureConverterStatus.ready,
          fromUnit: TemperatureUnit.celsius,
          toUnit: TemperatureUnit.fahrenheit,
          result: '',
        ),
      ],
    );

    blocTest<TemperatureConverterBloc, TemperatureConverterState>(
      'emits error state on invalid input',
      build: () => bloc,
      act: (bloc) {
        bloc
          ..add(const TemperatureInputChanged('abc'))
          ..add(const ConvertRequested());
      },
      expect: () => [
        const TemperatureConverterState(
          input: 'abc',
          status: TemperatureConverterStatus.ready,
          fromUnit: TemperatureUnit.celsius,
          toUnit: TemperatureUnit.fahrenheit,
          result: '',
        ),
        const TemperatureConverterState(
          input: 'abc',
          status: TemperatureConverterStatus.error,
          fromUnit: TemperatureUnit.celsius,
          toUnit: TemperatureUnit.fahrenheit,
          result: '',
          errorMessage: 'Masukkan angka yang valid',
        ),
      ],
    );

    blocTest<TemperatureConverterBloc, TemperatureConverterState>(
      'emits success state with formatted result on valid conversion',
      build: () => bloc,
      act: (bloc) {
        bloc
          ..add(const TemperatureInputChanged('100'))
          ..add(const ConvertRequested());
      },
      expect: () => [
        const TemperatureConverterState(
          input: '100',
          status: TemperatureConverterStatus.ready,
          fromUnit: TemperatureUnit.celsius,
          toUnit: TemperatureUnit.fahrenheit,
          result: '',
        ),
        const TemperatureConverterState(
          input: '100',
          status: TemperatureConverterStatus.success,
          fromUnit: TemperatureUnit.celsius,
          toUnit: TemperatureUnit.fahrenheit,
          result: '100.00 °C = 212.00 °F',
        ),
      ],
    );

    blocTest<TemperatureConverterBloc, TemperatureConverterState>(
      'swaps from and to units',
      build: () => bloc,
      act: (bloc) => bloc.add(const SwapUnitsRequested()),
      expect: () => [
        const TemperatureConverterState(
          status: TemperatureConverterStatus.ready,
          fromUnit: TemperatureUnit.fahrenheit,
          toUnit: TemperatureUnit.celsius,
          result: '',
        ),
      ],
    );
  });
}
