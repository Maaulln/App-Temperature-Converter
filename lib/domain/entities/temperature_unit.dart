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
