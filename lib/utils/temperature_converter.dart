enum TemperatureUnit {
  celsius,
  fahrenheit,
  kelvin,
  reamur;

  String get symbol {
    return switch (this) {
      TemperatureUnit.celsius => '°C',
      TemperatureUnit.fahrenheit => '°F',
      TemperatureUnit.kelvin => 'K',
      TemperatureUnit.reamur => '°R',
    };
  }

  String get displayName {
    return switch (this) {
      TemperatureUnit.celsius => 'Celsius',
      TemperatureUnit.fahrenheit => 'Fahrenheit',
      TemperatureUnit.kelvin => 'Kelvin',
      TemperatureUnit.reamur => 'Reamur',
    };
  }
}

class TemperatureConverter {
  static double convert(double value, TemperatureUnit from, TemperatureUnit to) {
    if (from == to) {
      return value;
    }

    // Convert the input value to Celsius first
    double celcius = _toCelsius(value, from);

    return _fromCelsius(celcius, to);
  }

  static double _toCelsius(double value, TemperatureUnit unit) {
    return switch (unit) {
      TemperatureUnit.celsius => value,
      TemperatureUnit.fahrenheit => (value - 32) * 5 / 9,
      TemperatureUnit.kelvin => value - 273.15,
      TemperatureUnit.reamur => value * 5 / 4,
    };
  }

  static double _fromCelsius(double celsius, TemperatureUnit unit) {
    return switch (unit) {
      TemperatureUnit.celsius => celsius,
      TemperatureUnit.fahrenheit => (celsius * 9 / 5) + 32,
      TemperatureUnit.kelvin => celsius + 273.15,
      TemperatureUnit.reamur => celsius * 4 / 5,
    };
  }
}