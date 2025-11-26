# 🚀 Codemagic'e Bağlama Adımları

## ✅ Tamamlanan
- ✅ Proje GitHub'a yüklendi
- ✅ Repository: https://github.com/mahmutkamalak/fishle-mobile-app

## 📋 Codemagic Kurulumu

### ADIM 1: Codemagic Hesabı Oluşturun

1. **https://codemagic.io** adresine gidin
2. **"Start building for free"** veya **"Sign up"** butonuna tıklayın
3. **"Continue with GitHub"** seçeneğini seçin
4. GitHub hesabınızla giriş yapın
5. Codemagic'in repository'lerinize erişim izni verin

### ADIM 2: Projeyi Codemagic'e Ekleyin

1. Codemagic dashboard'da **"Add application"** butonuna tıklayın
2. **"GitHub"** seçeneğini seçin
3. Repository listesinden **"fishle-mobile-app"** projesini bulun
4. Projeyi seçin ve **"Next"** butonuna tıklayın

### ADIM 3: Flutter Yapılandırması

Codemagic otomatik olarak Flutter projesini algılar:

1. **"Flutter app"** seçeneğinin seçili olduğundan emin olun
2. **"Finish"** butonuna tıklayın

### ADIM 4: iOS Yapılandırması

1. Proje sayfasında **"iOS"** sekmesine gidin
2. **"Configure"** butonuna tıklayın

#### Apple Developer Hesabı Bilgileri

**Seçenek A: Apple Developer Hesabınız Varsa**
- Apple ID'nizi girin
- App Store Connect API Key ekleyin (opsiyonel)
- Certificate ve Provisioning Profile oluşturun

**Seçenek B: Apple Developer Hesabınız Yoksa**
- Codemagic size rehberlik edecek
- TestFlight için Apple Developer hesabı gereklidir ($99/yıl)
- Alternatif: Ad-hoc distribution (sınırlı sayıda cihaz)

### ADIM 5: İlk iOS Build'i Başlatın

1. **"Start new build"** butonuna tıklayın
2. **Branch:** `main` seçin
3. **Platform:** `iOS` seçin
4. **Build type:** `Release` seçin
5. **"Start build"** butonuna tıklayın

**Build süresi:** 10-15 dakika

### ADIM 6: Build Durumunu Takip Edin

- Build sayfasında ilerlemeyi görebilirsiniz
- Logları inceleyebilirsiniz
- Hata varsa loglardan görebilirsiniz

### ADIM 7: iPhone'unuzda Test Edin

Build tamamlandığında:

#### Yöntem 1: TestFlight (ÖNERİLEN)
1. Codemagic'te **"Submit to TestFlight"** seçeneğini aktif edin
2. Build tamamlandığında otomatik olarak TestFlight'a yüklenir
3. iPhone'unuzda **TestFlight** uygulamasını açın
4. Uygulamayı bulun ve **"Install"** butonuna tıklayın
5. Test edin! 🎉

#### Yöntem 2: IPA Dosyasını İndirin
1. Build sayfasında **"Download"** butonuna tıklayın
2. IPA dosyasını indirin
3. **Apple Configurator** veya **3uTools** ile cihaza yükleyin

---

## ⚙️ Otomatik Yapılandırma

Projenizde `codemagic.yaml` dosyası var. Bu dosya build sürecini otomatikleştirir.

**Önemli:** Email adresinizi güncelleyin:
- `codemagic.yaml` dosyasında satır 37'deki email'i kendi email'inizle değiştirin

---

## 💰 Codemagic Ücretsiz Plan

- ✅ Ayda 500 build dakikası
- ✅ Sınırsız build sayısı (dakika limiti içinde)
- ✅ TestFlight entegrasyonu
- ✅ iOS ve Android desteği

**Yeterli mi?** Evet! Test için fazlasıyla yeterli.

---

## 🆘 Sorun Giderme

### "Apple Developer hesabı gerekli" hatası
- TestFlight için Apple Developer hesabı ($99/yıl) gereklidir
- Alternatif: Ad-hoc distribution (sınırlı sayıda cihaz için)

### Build başarısız olursa
- Codemagic build loglarını kontrol edin
- Hataları bana gönderin, düzeltelim

### Repository bulunamıyor
- GitHub'da repository'nin Public olduğundan emin olun
- Veya Codemagic'e özel erişim verin

---

## ✅ Hızlı Özet

1. ✅ https://codemagic.io → GitHub ile giriş
2. ✅ "Add application" → fishle-mobile-app seç
3. ✅ iOS yapılandırması yap
4. ✅ "Start new build" → iOS → Build başlat
5. ✅ TestFlight'tan iPhone'a indir ve test et!

**Toplam süre:** 15-20 dakika (ilk kurulum + build)

