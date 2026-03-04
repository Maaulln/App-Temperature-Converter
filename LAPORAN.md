# LAPORAN PEMBUATAN APLIKASI TEMPERATURE CONVERTER

**Nama:** Maulana Chandra Irawan  
**NRP:** 3124521038  
**Tanggal:** 4 Maret 2026

---

## 1. PENDAHULUAN

### 1.1 Latar Belakang
Konversi suhu merupakan kebutuhan yang sering digunakan dalam berbagai bidang seperti ilmu pengetahuan, teknik, dan kehidupan sehari-hari. Aplikasi Temperature Converter ini dibuat untuk memudahkan pengguna dalam mengkonversi nilai suhu antar satuan yang berbeda.

### 1.2 Tujuan
- Membuat aplikasi konversi suhu berbasis Flutter
- Mengimplementasikan konversi antar 4 satuan suhu: Celsius, Fahrenheit, Kelvin, dan Reamur
- Menerapkan prinsip clean code dan modular programming

---

## 2. TEKNOLOGI YANG DIGUNAKAN

| Teknologi | Versi | Keterangan |
|-----------|-------|------------|
| Flutter | 3.x | Framework UI cross-platform |
| Dart | ^3.11.0 | Bahasa pemrograman |
| Material Design 3 | - | Design system |

---

## 3. STRUKTUR PROYEK

```
temperatureconverter/
├── lib/
│   ├── main.dart                      # Entry point aplikasi
│   ├── my_app.dart                    # Widget utama dan UI
│   └── utils/
│       └── temperature_converter.dart # Logika konversi suhu
├── pubspec.yaml                       # Dependencies
└── ...
```

---

## 4. IMPLEMENTASI

### 4.1 Logika Konversi Suhu (`temperature_converter.dart`)

#### 4.1.1 Enum TemperatureUnit
Mendefinisikan 4 satuan suhu dengan getter untuk simbol dan nama tampilan:

```dart
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
```

#### 4.1.2 Class TemperatureConverter
Menggunakan pendekatan **konversi melalui Celsius** sebagai basis:

```dart
class TemperatureConverter {
  static double convert(double value, TemperatureUnit from, TemperatureUnit to) {
    if (from == to) return value;
    double celsius = _toCelsius(value, from);
    return _fromCelsius(celsius, to);
  }
}
```

### 4.2 Rumus Konversi

| Dari | Ke Celsius | Rumus |
|------|------------|-------|
| Celsius | - | C |
| Fahrenheit | °C | (F - 32) × 5/9 |
| Kelvin | °C | K - 273.15 |
| Reamur | °C | R × 5/4 |

| Dari Celsius | Ke | Rumus |
|--------------|-----|-------|
| - | Celsius | C |
| °C | Fahrenheit | (C × 9/5) + 32 |
| °C | Kelvin | C + 273.15 |
| °C | Reamur | C × 4/5 |

### 4.3 User Interface (`my_app.dart`)

#### 4.3.1 Komponen UI
1. **TextField** - Input nilai suhu
2. **DropdownButtonFormField** - Pemilihan satuan asal dan tujuan
3. **IconButton** - Tombol swap untuk menukar satuan
4. **ElevatedButton** - Tombol konversi
5. **Card** - Menampilkan hasil konversi

#### 4.3.2 Widget Reusable
Dibuat widget `_UnitDropdown` untuk mengurangi duplikasi kode:

```dart
class _UnitDropdown extends StatelessWidget {
  const _UnitDropdown({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final TemperatureUnit value;
  final ValueChanged<TemperatureUnit> onChanged;
  // ...
}
```

---

## 5. FITUR APLIKASI

| No | Fitur | Deskripsi |
|----|-------|-----------|
| 1 | Input Suhu | Memasukkan nilai suhu yang akan dikonversi |
| 2 | Pilih Satuan | Memilih satuan asal dan tujuan dari dropdown |
| 3 | Swap | Menukar satuan asal dan tujuan dengan satu klik |
| 4 | Konversi | Menghitung dan menampilkan hasil konversi |
| 5 | Validasi | Menampilkan pesan error jika input tidak valid |

---

## 6. SCREENSHOT TAMPILAN

### 6.1 Tampilan Utama
Aplikasi menampilkan:
- AppBar dengan judul "Temperature Converter"
- Input field untuk memasukkan suhu
- Dropdown untuk memilih satuan asal (Dari) dan tujuan (Ke)
- Tombol swap di antara kedua dropdown
- Tombol "Konversi"
- Card hasil konversi (muncul setelah konversi)

---

## 7. CARA PENGGUNAAN

1. Buka aplikasi Temperature Converter
2. Masukkan nilai suhu pada field "Masukkan Suhu"
3. Pilih satuan asal dari dropdown "Dari"
4. Pilih satuan tujuan dari dropdown "Ke"
5. (Opsional) Tekan tombol swap untuk menukar satuan
6. Tekan tombol "Konversi"
7. Hasil akan ditampilkan pada card di bawah tombol

---

## 8. CARA MENJALANKAN APLIKASI

```bash
# Install dependencies
flutter pub get

# Jalankan aplikasi
flutter run

# Atau jalankan di device tertentu
flutter run -d chrome    # Web
flutter run -d macos     # macOS
flutter run -d ios       # iOS Simulator
flutter run -d android   # Android Emulator
```

---

## 9. KESIMPULAN

Aplikasi Temperature Converter berhasil dibuat dengan fitur-fitur berikut:
- Konversi antar 4 satuan suhu (Celsius, Fahrenheit, Kelvin, Reamur)
- UI yang responsif dan user-friendly menggunakan Material Design 3
- Kode yang modular dan mudah di-maintain
- Validasi input untuk mencegah error

### 9.1 Pengembangan Selanjutnya
- Menambahkan history konversi
- Menambahkan fitur copy hasil ke clipboard
- Menambahkan unit test
- Menambahkan dark mode

---

## 10. REFERENSI

1. Flutter Documentation - https://flutter.dev/docs
2. Dart Language - https://dart.dev
3. Material Design 3 - https://m3.material.io

---

**Dibuat oleh:**  
Maulana Chandra Irawan (3124521038)
