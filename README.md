# Temperature Converter - Flutter App

Aplikasi konversi suhu untuk 4 satuan: Celsius, Fahrenheit, Kelvin, dan Reamur.

## Fitur

- Input nilai suhu
- Pilih satuan asal dan tujuan
- Tombol swap satuan
- Konversi suhu dengan hasil terformat
- Validasi input angka tidak valid

## Arsitektur (BLoC)

Refactor sudah dipindah dari `setState` ke arsitektur event-driven menggunakan `flutter_bloc`.

Layer utama:

- `presentation`: halaman UI, widget, dan BLoC
- `domain`: entitas (`TemperatureUnit`) dan use case (`ConvertTemperatureUseCase`)

Alur state:

1. UI mengirim event (`TemperatureInputChanged`, `FromUnitChanged`, `ToUnitChanged`, `SwapUnitsRequested`, `ConvertRequested`).
2. `TemperatureConverterBloc` memproses event, validasi input, lalu memanggil use case domain.
3. UI render ulang berdasarkan state immutable (`TemperatureConverterState`).

## Struktur Proyek

```text
temperatureconverter/
├── lib/
│   ├── main.dart
│   ├── my_app.dart
│   ├── domain/
│   │   ├── entities/
│   │   │   └── temperature_unit.dart
│   │   └── usecases/
│   │       └── convert_temperature_usecase.dart
│   └── presentation/
│       ├── bloc/
│       │   ├── temperature_converter_bloc.dart
│       │   ├── temperature_converter_event.dart
│       │   └── temperature_converter_state.dart
│       ├── pages/
│       │   └── temperature_converter_page.dart
│       └── widgets/
│           └── unit_dropdown.dart
└── test/
    ├── bloc/
    │   └── temperature_converter_bloc_test.dart
    ├── domain/
    │   └── convert_temperature_usecase_test.dart
    ├── presentation/
    │   └── temperature_converter_page_test.dart
    └── widget_test.dart
```

## Menjalankan Aplikasi

```bash
flutter pub get
flutter run
```

## Menjalankan Quality Check

```bash
flutter analyze
flutter test
```

## Teknologi

- Flutter
- Dart
- flutter_bloc
- bloc
- equatable
- bloc_test
