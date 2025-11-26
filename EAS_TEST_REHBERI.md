# EAS ile Test Etme Rehberi

## Ön Hazırlık

### 1. Node.js ve npm Kurulumu
EAS CLI Node.js gerektirir. Eğer yüklü değilse:
- https://nodejs.org/ adresinden Node.js'i indirin ve kurun

### 2. EAS CLI Kurulumu
```bash
npm install -g eas-cli
```

Kurulumu kontrol edin:
```bash
eas --version
```

### 3. Expo Hesabı Oluşturma
EAS Build kullanmak için Expo hesabı gereklidir:
- https://expo.dev adresinden ücretsiz hesap oluşturun

### 4. EAS'a Giriş Yapma
```bash
eas login
```
Email ve şifrenizle giriş yapın.

## İlk Yapılandırma

### 1. Projeyi EAS'a Bağlama
```bash
eas build:configure
```

Bu komut:
- `eas.json` dosyasını kontrol eder (zaten var)
- Projeyi Expo hesabınıza bağlar
- Gerekli yapılandırmaları yapar

### 2. Android için Keystore Oluşturma (İlk defa)
```bash
eas credentials
```
Android seçeneğini seçin ve keystore oluşturun.

## Build Oluşturma

### Android APK (Test için - Hızlı)
```bash
eas build --platform android --profile preview
```

Bu komut:
- Android APK oluşturur
- Build süreci 10-20 dakika sürebilir
- Build tamamlandığında indirme linki verilir

### Android App Bundle (Play Store için)
```bash
eas build --platform android --profile production
```

### iOS (Test için)
```bash
eas build --platform ios --profile preview
```

**Not:** iOS için Apple Developer hesabı gereklidir.

### Her İki Platform
```bash
eas build --platform all --profile preview
```

## Build Durumunu Takip Etme

Build başladıktan sonra:
```bash
eas build:list
```

Veya web üzerinden:
- https://expo.dev/accounts/[your-username]/projects/fishle/builds

## Build İndirme ve Test

1. Build tamamlandığında size bir link gönderilir
2. Linke tıklayarak APK/iOS dosyasını indirin
3. Android için: APK'yı cihazınıza yükleyin
4. iOS için: TestFlight veya doğrudan yükleme

## Hızlı Test Alternatifleri

### Yerel Build (Daha Hızlı)

EAS kullanmak istemiyorsanız, yerel build yapabilirsiniz:

#### Android APK
```bash
flutter build apk --release
```
APK dosyası: `build/app/outputs/flutter-apk/app-release.apk`

#### Android App Bundle
```bash
flutter build appbundle --release
```
AAB dosyası: `build/app/outputs/bundle/release/app-release.aab`

### Firebase App Distribution (Alternatif)

1. Firebase Console'da proje oluşturun
2. App Distribution'ı etkinleştirin
3. APK'yı yükleyin ve test kullanıcılarına gönderin

## Sorun Giderme

### "EAS CLI not found" hatası
```bash
npm install -g eas-cli
```

### "Not authenticated" hatası
```bash
eas login
```

### Build başarısız olursa
```bash
eas build:list
```
Son build'in loglarını kontrol edin.

## Önemli Notlar

1. **İlk build daha uzun sürer** (10-20 dakika)
2. **Android için keystore** ilk build'de oluşturulur
3. **iOS için** Apple Developer hesabı gereklidir
4. **Build sayısı sınırlıdır** (ücretsiz plan: ayda 30 build)

## Hızlı Başlangıç Komutları

```bash
# 1. EAS CLI kurulumu
npm install -g eas-cli

# 2. Giriş yap
eas login

# 3. Yapılandır
eas build:configure

# 4. Android APK build (test için)
eas build --platform android --profile preview

# 5. Build durumunu kontrol et
eas build:list
```

## Yerel Test (EAS Olmadan)

Eğer sadece hızlıca test etmek istiyorsanız:

```bash
# Android cihaz/emülatör bağlıyken
flutter run --release

# Veya APK oluştur
flutter build apk --release
# Sonra APK'yı cihaza yükleyin
```

