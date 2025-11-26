# Fishle Mobile App

Fishle, fiş (receipt) fotoğraflarını çekip yapılandırılmış veriye dönüştüren bir mobil uygulamadır.

## Özellikler

- 📸 Fiş fotoğrafı çekme (kamera veya galeri)
- 🤖 Otomatik fiş işleme (n8n + Google Document AI entegrasyonu için hazır)
- 💾 Offline-first: Tüm veriler cihazda saklanır
- 📱 Android ve iOS desteği
- 🇹🇷 Türkçe arayüz

## Teknolojiler

- **Flutter** - Cross-platform mobil framework
- **SQLite** - Yerel veritabanı (sqflite)
- **Image Picker** - Kamera ve galeri erişimi
- **Path Provider** - Dosya yönetimi

## Kurulum

### Gereksinimler

- Flutter SDK (3.7.2 veya üzeri)
- Android Studio / Xcode (mobil geliştirme için)
- Dart SDK

### Adımlar

1. **Bağımlılıkları yükleyin:**
   ```bash
   flutter pub get
   ```

2. **Uygulamayı çalıştırın:**
   ```bash
   flutter run
   ```

## Proje Yapısı

```
lib/
├── main.dart                 # Uygulama giriş noktası
├── models/                   # Veri modelleri
│   ├── receipt.dart
│   └── receipt_item.dart
├── services/                 # Servisler
│   ├── database_service.dart
│   ├── receipt_processing_service.dart
│   └── image_storage_service.dart
├── screens/                  # Ekranlar
│   ├── home_screen.dart
│   ├── camera_screen.dart
│   ├── preview_screen.dart
│   ├── receipt_edit_screen.dart
│   ├── receipt_detail_screen.dart
│   └── receipts_list_screen.dart
├── widgets/                  # Widget'lar
│   └── empty_state.dart
└── theme/                    # Tema
    └── app_theme.dart
```

## Veri Modeli

### Receipt (Fiş)
- `id`: UUID
- `createdAt`: Oluşturulma tarihi
- `updatedAt`: Güncellenme tarihi
- `imageLocalPath`: Görsel dosya yolu
- `merchantName`: İşletme adı (nullable)
- `date`: Fiş tarihi
- `subtotal`: Ara toplam (nullable)
- `vatAmount`: KDV tutarı (nullable)
- `totalAmount`: Toplam tutar
- `currency`: Para birimi (varsayılan: TRY)
- `items`: Ürün listesi
- `note`: Not (nullable)

### ReceiptItem (Fiş Ürünü)
- `id`: UUID
- `receiptId`: Bağlı olduğu fiş ID'si
- `name`: Ürün adı
- `quantity`: Miktar
- `unitPrice`: Birim fiyat
- `lineTotal`: Satır toplamı

## API Servisi

Şu anda `ReceiptProcessingService` mock veri döndürüyor. Gerçek n8n + Google Document AI entegrasyonu için:

1. `lib/services/receipt_processing_service.dart` dosyasını açın
2. `processReceiptImage` metodundaki TODO yorumlarını takip edin
3. n8n webhook endpoint'inizi ekleyin

Örnek endpoint:
```
POST https://<your-n8n-domain>/webhook/fishle-process-receipt
Content-Type: multipart/form-data
Body: receipt (image file)
```

## Build ve Dağıtım

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## EAS Build (Expo Application Services)

Flutter projeleri için EAS Build kullanmak için:

1. **EAS CLI'yi yükleyin:**
   ```bash
   npm install -g eas-cli
   ```

2. **EAS'a giriş yapın:**
   ```bash
   eas login
   ```

3. **Projeyi yapılandırın:**
   ```bash
   eas build:configure
   ```

4. **Build oluşturun:**
   ```bash
   # Android
   eas build --platform android
   
   # iOS
   eas build --platform ios
   
   # Her ikisi
   eas build --platform all
   ```

## Geliştirme Notları

- Tüm veriler cihazda saklanır (offline-first)
- Mock API servisi 1-2 saniye gecikme ile çalışır
- Türkçe tarih ve para birimi formatlaması kullanılır
- Light theme varsayılan olarak kullanılır (dark theme için hazırlık yapıldı)

## Lisans

Bu proje özel bir projedir.
