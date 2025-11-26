# 🍎 iPhone'da Test Etme - Hızlı Başlangıç

## 🎯 En Kolay Yöntem: Codemagic (ÖNERİLEN)

Codemagic sayesinde Windows'tan iOS build yapabilir ve iPhone'unuzda test edebilirsiniz!

---

## 📋 Adım Adım

### ADIM 1: GitHub'a Projeyi Yükleyin

**Eğer GitHub hesabınız yoksa:**
1. https://github.com adresinden ücretsiz hesap oluşturun

**Projeyi GitHub'a yükleyin:**

```bash
# 1. Git repository oluştur
git init

# 2. Dosyaları ekle
git add .

# 3. Commit yap
git commit -m "Fishle iOS build için hazır"

# 4. GitHub'da yeni repository oluşturun (web'den)
#    https://github.com/new

# 5. Repository URL'ini alın ve bağlayın
git remote add origin https://github.com/KULLANICI_ADI/fishle-mobile-app.git
git branch -M main
git push -u origin main
```

---

### ADIM 2: Codemagic Hesabı Oluşturun

1. **https://codemagic.io** adresine gidin
2. **"Start building for free"** butonuna tıklayın
3. **GitHub ile giriş yapın**
4. Codemagic'in GitHub repository'lerinize erişim izni verin

---

### ADIM 3: Projeyi Codemagic'e Bağlayın

1. Codemagic dashboard'da **"Add application"** butonuna tıklayın
2. **GitHub**'ı seçin
3. **"fishle-mobile-app"** repository'sini seçin
4. **"Flutter app"** seçeneğini seçin
5. **"Finish"** butonuna tıklayın

---

### ADIM 4: iOS Yapılandırması

Codemagic otomatik olarak Flutter projesini algılar. iOS için:

1. **"iOS"** sekmesine gidin
2. **Apple Developer hesabı bilgilerinizi girin:**
   - Apple ID
   - App Store Connect API Key (opsiyonel, daha sonra ekleyebilirsiniz)

3. **Certificate ve Provisioning Profile:**
   - Codemagic otomatik oluşturabilir
   - Veya kendi certificate'lerinizi yükleyebilirsiniz

---

### ADIM 5: İlk Build'i Başlatın

1. **"Start new build"** butonuna tıklayın
2. **Branch:** main (veya hangi branch'i kullanıyorsanız)
3. **Platform:** iOS
4. **Build type:** Release
5. **"Start build"** butonuna tıklayın

**Build süresi:** 10-15 dakika

---

### ADIM 6: iPhone'unuzda Test Edin

Build tamamlandığında iki seçenek var:

#### Seçenek A: TestFlight (ÖNERİLEN)
1. Build tamamlandığında TestFlight'a otomatik yüklenir
2. iPhone'unuzda **TestFlight** uygulamasını açın
3. Uygulamayı bulun ve **"Install"** butonuna tıklayın
4. Test edin! 🎉

#### Seçenek B: Doğrudan IPA İndirme
1. Build sayfasında **"Download"** butonuna tıklayın
2. IPA dosyasını indirin
3. **Apple Configurator** veya **3uTools** ile cihaza yükleyin

---

## ⚙️ Otomatik Yapılandırma

Projenize `codemagic.yaml` dosyası ekledim. Bu dosya build sürecini otomatikleştirir.

**Önemli:** Email adresinizi `codemagic.yaml` dosyasında güncelleyin:
- Satır 37: `mahmutkmlk@example.com` → Kendi email'iniz

---

## 💰 Maliyet

**Codemagic Ücretsiz Plan:**
- ✅ Ayda 500 build dakikası
- ✅ Sınırsız build sayısı (dakika limiti içinde)
- ✅ TestFlight entegrasyonu
- ✅ iOS ve Android desteği

**Yeterli mi?** Evet! Test için fazlasıyla yeterli.

---

## 🆘 Sorun Giderme

### "Apple Developer hesabı gerekli" hatası
- Apple Developer hesabı ($99/yıl) iOS uygulamaları için gereklidir
- TestFlight kullanmak için zorunludur
- Alternatif: Ad-hoc distribution (sınırlı sayıda cihaz)

### Build başarısız olursa
- Codemagic build loglarını kontrol edin
- Hataları bana gönderin, düzeltelim

---

## ✅ Hızlı Özet

1. ✅ GitHub'a projeyi yükle
2. ✅ Codemagic'e kaydol (GitHub ile)
3. ✅ Projeyi bağla
4. ✅ iOS build başlat
5. ✅ TestFlight'tan indir ve test et!

**Toplam süre:** 20-30 dakika (ilk kurulum)

