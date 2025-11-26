# 🚀 EAS ile Test Etme - Adım Adım

## ✅ Hazırlık Kontrolü
- ✅ Node.js yüklü (v22.18.0)
- ✅ EAS CLI yüklü (v16.26.0)
- ✅ Flutter projesi hazır

## 📋 Adım Adım Test Süreci

### ADIM 1: EAS'a Giriş Yapın
```bash
eas login
```
- Expo hesabınız varsa email/şifre ile giriş yapın
- Hesabınız yoksa: https://expo.dev adresinden ücretsiz hesap oluşturun

### ADIM 2: Projeyi Yapılandırın
```bash
eas build:configure
```
Bu komut projenizi EAS'a bağlar ve gerekli ayarları yapar.

### ADIM 3: Android APK Build (Test için - ÖNERİLEN)
```bash
eas build --platform android --profile preview
```

**Ne olacak?**
- Build sunucuda başlar (10-20 dakika sürebilir)
- Size bir build URL'i verilir
- Build tamamlandığında QR kod ve indirme linki gösterilir
- APK'yı indirip Android cihazınıza yükleyebilirsiniz

### ADIM 4: Build Durumunu Takip Edin
```bash
eas build:list
```

Veya web'den:
- https://expo.dev/accounts/[kullanıcı-adınız]/projects/fishle/builds

### ADIM 5: APK'yı İndirin ve Test Edin
- Build tamamlandığında size gönderilen linkten APK'yı indirin
- Android cihazınıza yükleyin
- Uygulamayı açın ve test edin

---

## 🎯 Hızlı Test (EAS Olmadan - Daha Hızlı)

Eğer sadece hızlıca test etmek istiyorsanız:

### Seçenek 1: Doğrudan Çalıştırma
```bash
# Android cihaz/emülatör bağlıyken
flutter run --release
```

### Seçenek 2: APK Oluşturma
```bash
# APK oluştur
flutter build apk --release

# APK konumu
# build/app/outputs/flutter-apk/app-release.apk
```
Sonra bu APK'yı Android cihazınıza yükleyin.

---

## 📱 iOS Test (Opsiyonel)

iOS için test etmek isterseniz:
```bash
eas build --platform ios --profile preview
```

**Not:** iOS için Apple Developer hesabı gereklidir ($99/yıl).

---

## ⚠️ Önemli Notlar

1. **İlk build daha uzun sürer** (10-20 dakika)
2. **Android keystore** ilk build'de otomatik oluşturulur
3. **Ücretsiz plan:** Ayda 30 build hakkınız var
4. **Build sırasında** terminal açık kalmalı (veya arka planda çalışabilir)

---

## 🆘 Sorun Giderme

### "Not authenticated" hatası
```bash
eas login
```

### Build başarısız olursa
```bash
eas build:list
# Son build'in detaylarını görüntüleyin
```

### Yerel test yapmak isterseniz
```bash
flutter run --release
```

