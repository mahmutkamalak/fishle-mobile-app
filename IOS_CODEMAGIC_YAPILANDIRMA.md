# 🍎 iOS Build için Codemagic Yapılandırması

## ❌ Sorun
```
Building a deployable iOS app requires a selected Development Team with a Provisioning Profile.
```

## ✅ Çözüm: Codemagic'te iOS Yapılandırması

iOS build yapmak için Codemagic'te Apple Developer hesabı bilgilerinizi yapılandırmanız gerekiyor.

---

## 📋 Adım Adım Yapılandırma

### ADIM 1: Codemagic'te Projeyi Açın

1. **https://codemagic.io** adresine gidin
2. **fishle-mobile-app** projesini açın
3. **"Settings"** (Ayarlar) sekmesine gidin

### ADIM 2: Apple Developer Hesabı Bilgilerini Ekleyin

#### Seçenek A: Apple Developer Hesabınız Varsa ($99/yıl)

1. **"Code signing identities"** bölümüne gidin
2. **"Add code signing identity"** butonuna tıklayın
3. **Apple ID** ve **App-specific password** girin
   - App-specific password oluşturmak için: https://appleid.apple.com → Sign-In and Security → App-Specific Passwords

4. **"Certificates"** bölümüne gidin
5. **"Add certificate"** butonuna tıklayın
6. Codemagic otomatik olarak certificate oluşturacak

7. **"Provisioning profiles"** bölümüne gidin
8. **"Add provisioning profile"** butonuna tıklayın
9. Codemagic otomatik olarak provisioning profile oluşturacak

#### Seçenek B: Apple Developer Hesabınız Yoksa

**Test için iki seçenek:**

1. **Apple Developer hesabı alın** ($99/yıl)
   - https://developer.apple.com/programs/
   - TestFlight için gereklidir

2. **Ad-hoc distribution** (Sınırlı sayıda cihaz)
   - Ücretsiz Apple ID ile yapılabilir
   - Sadece kayıtlı cihazlarda çalışır
   - TestFlight kullanılamaz

### ADIM 3: App Store Connect API Key (Opsiyonel - Önerilen)

TestFlight'a otomatik yüklemek için:

1. **App Store Connect** → **Users and Access** → **Keys**
2. **App Store Connect API** key oluşturun
3. Codemagic'te **"App Store Connect API key"** bölümüne ekleyin

### ADIM 4: Environment Variables (Gerekli)

Codemagic'te **"Environment variables"** bölümüne gidin ve şunları ekleyin:

```
APP_ID = com.fishle.fishle
BUNDLE_ID = com.fishle.fishle
```

### ADIM 5: Build Yapılandırmasını Kontrol Edin

1. **"Workflows"** sekmesine gidin
2. **"ios-workflow"** workflow'unu seçin
3. **"Start new build"** butonuna tıklayın
4. **Branch:** `main` seçin
5. **Workflow:** `ios-workflow` seçin
6. **"Start build"** butonuna tıklayın

---

## 🔧 Alternatif: Basit iOS Build (Test için)

Eğer sadece test etmek istiyorsanız, Codemagic yapılandırmasını basitleştirebiliriz:

### Ad-hoc Distribution için codemagic.yaml Güncellemesi

```yaml
ios-workflow:
  name: iOS Workflow
  max_build_duration: 120
  instance_type: mac_mini_m1
  environment:
    vars:
      FLUTTER_VERSION: "3.29.3"
    flutter: stable
    xcode: latest
    cocoapods: default
  scripts:
    - name: Get Flutter dependencies
      script: |
        flutter pub get
    - name: Install CocoaPods dependencies
      script: |
        cd ios && pod install
    - name: Build iOS app (ad-hoc)
      script: |
        flutter build ios --release --no-codesign
  artifacts:
    - build/ios/iphoneos/*.app
```

**Not:** Bu yöntemle oluşturulan app'i manuel olarak imzalamanız gerekir.

---

## 📱 Test Etme

### Yöntem 1: TestFlight (ÖNERİLEN)

1. Build tamamlandığında otomatik olarak TestFlight'a yüklenir
2. iPhone'unuzda **TestFlight** uygulamasını açın
3. Uygulamayı bulun ve **"Install"** butonuna tıklayın

### Yöntem 2: IPA Dosyasını İndirme

1. Build sayfasında **"Download"** butonuna tıklayın
2. IPA dosyasını indirin
3. **Apple Configurator** veya **3uTools** ile cihaza yükleyin

---

## ⚠️ Önemli Notlar

1. **Apple Developer hesabı:** TestFlight için zorunludur ($99/yıl)
2. **Bundle ID:** `com.fishle.fishle` olarak ayarlanmış
3. **Code signing:** Codemagic otomatik olarak yönetebilir
4. **İlk build:** 15-20 dakika sürebilir

---

## 🆘 Sorun Giderme

### "No code signing identities found"
- Codemagic'te Apple Developer hesabı bilgilerinizi ekleyin
- Certificate oluşturulduğundan emin olun

### "Provisioning profile not found"
- Codemagic'te provisioning profile oluşturun
- Bundle ID'nin doğru olduğundan emin olun

### "App Store Connect API key required"
- TestFlight için App Store Connect API key ekleyin
- Veya TestFlight yüklemesini devre dışı bırakın

---

## ✅ Hızlı Özet

1. ✅ Codemagic'te Settings → Code signing identities
2. ✅ Apple Developer hesabı bilgilerinizi ekleyin
3. ✅ Certificate ve Provisioning Profile oluşturun
4. ✅ iOS build başlatın
5. ✅ TestFlight'tan iPhone'unuza indirin!

