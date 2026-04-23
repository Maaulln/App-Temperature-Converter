import '../entities/temperature_unit.dart';

class ConvertTemperatureUseCase {
  double call(double value, TemperatureUnit from, TemperatureUnit to) {
    if (from == to) {
      return value;
    }

    final celsius = _toCelsius(value, from);
    return _fromCelsius(celsius, to);
  }

  double _toCelsius(double value, TemperatureUnit unit) {
    return switch (unit) {
      TemperatureUnit.celsius => value,
      TemperatureUnit.fahrenheit => (value - 32) * 5 / 9,
      TemperatureUnit.kelvin => value - 273.15,
      TemperatureUnit.reamur => value * 5 / 4,
    };
  }

  double _fromCelsius(double celsius, TemperatureUnit unit) {
    return switch (unit) {
      TemperatureUnit.celsius => celsius,
      TemperatureUnit.fahrenheit => (celsius * 9 / 5) + 32,
      TemperatureUnit.kelvin => celsius + 273.15,
      TemperatureUnit.reamur => celsius * 4 / 5,
    };
  }
}
