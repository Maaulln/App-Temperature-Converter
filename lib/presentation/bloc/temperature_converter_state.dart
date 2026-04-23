part of 'temperature_converter_bloc.dart';

enum TemperatureConverterStatus { initial, ready, success, error }

final class TemperatureConverterState extends Equatable {
  const TemperatureConverterState({
    this.input = '',
    this.fromUnit = TemperatureUnit.celsius,
    this.toUnit = TemperatureUnit.fahrenheit,
    this.result = '',
    this.status = TemperatureConverterStatus.initial,
    this.errorMessage,
  });

  final String input;
  final TemperatureUnit fromUnit;
  final TemperatureUnit toUnit;
  final String result;
  final TemperatureConverterStatus status;
  final String? errorMessage;

  TemperatureConverterState copyWith({
    String? input,
    TemperatureUnit? fromUnit,
    TemperatureUnit? toUnit,
    String? result,
    TemperatureConverterStatus? status,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TemperatureConverterState(
      input: input ?? this.input,
      fromUnit: fromUnit ?? this.fromUnit,
      toUnit: toUnit ?? this.toUnit,
      result: result ?? this.result,
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    input,
    fromUnit,
    toUnit,
    result,
    status,
    errorMessage,
  ];
}
