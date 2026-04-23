import 'package:flutter_test/flutter_test.dart';
import 'package:temperatureconverter/domain/entities/temperature_unit.dart';
import 'package:temperatureconverter/domain/usecases/convert_temperature_usecase.dart';

void main() {
  group('ConvertTemperatureUseCase', () {
    final useCase = ConvertTemperatureUseCase();

    test('returns same value when units are equal', () {
      final result = useCase(
        25,
        TemperatureUnit.celsius,
        TemperatureUnit.celsius,
      );
      expect(result, 25);
    });

    test('converts celsius to fahrenheit', () {
      final result = useCase(
        100,
        TemperatureUnit.celsius,
        TemperatureUnit.fahrenheit,
      );
      expect(result, 212);
    });

    test('converts fahrenheit to kelvin', () {
      final result = useCase(
        32,
        TemperatureUnit.fahrenheit,
        TemperatureUnit.kelvin,
      );
      expect(result, closeTo(273.15, 0.0001));
    });

    test('converts reamur to celsius', () {
      final result = useCase(
        80,
        TemperatureUnit.reamur,
        TemperatureUnit.celsius,
      );
      expect(result, 100);
    });
  });
}
