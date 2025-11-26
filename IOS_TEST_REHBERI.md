# 🍎 iOS'ta Test Etme Rehberi

## ⚠️ Önemli Not
iOS build yapmak için **macOS** ve **Xcode** gereklidir. Windows'ta doğrudan iOS build yapılamaz.

## ✅ Çözüm Seçenekleri

### 1. Codemagic ile Bulut Build (ÖNERİLEN) ⭐

Codemagic Flutter projeleri için özel bir CI/CD servisidir ve iOS build yapabilir.

**Adımlar:**

1. **Codemagic Hesabı Oluşturun**
   - https://codemagic.io adresine gidin
   - GitHub/GitLab/Bitbucket ile giriş yapın

2. **Projeyi Bağlayın**
   - Codemagic'te "Add application" butonuna tıklayın
   - GitHub'dan projenizi seçin (veya önce GitHub'a push edin)

3. **iOS Yapılandırması**
   - Codemagic otomatik olarak Flutter projesini algılar
   - iOS için Apple Developer hesabı bilgilerinizi girin

4. **Build Yapın**
   - "Start new build" butonuna tıklayın
   - iOS platformunu seçin
   - Build başlar (10-15 dakika)

5. **TestFlight'a Yükleyin veya Doğrudan İndirin**
   - Build tamamlandığında IPA dosyasını indirebilirsiniz
   - TestFlight'a otomatik yüklenebilir

**Avantajlar:**
- ✅ Windows'tan iOS build yapabilirsiniz
- ✅ Ücretsiz plan (ayda 500 build dakikası)
- ✅ TestFlight entegrasyonu
- ✅ Otomatik build ve dağıtım

---

### 2. Mac Bilgisayar Kullanarak (Eğer Varsa)

Mac bilgisayarınız varsa:

```bash
# 1. Xcode'u yükleyin (App Store'dan)

# 2. iOS build yapın
flutter build ios --release

# 3. Xcode'da açın
open ios/Runner.xcworkspace

# 4. Cihazınızı seçin ve "Run" butonuna basın
```

---

### 3. TestFlight (Apple Developer Hesabı Gerekli)

Apple Developer hesabınız varsa ($99/yıl):

1. **Mac'te build yapın** (veya Codemagic kullanın)
2. **App Store Connect'e yükleyin**
3. **TestFlight'ta test edin**

---

## 🚀 Hızlı Başlangıç: Codemagic

### Adım 1: Projeyi GitHub'a Push Edin

```bash
# Git repository oluşturun (eğer yoksa)
git init
git add .
git commit -m "Initial commit"
git remote add origin <your-github-repo-url>
git push -u origin main
```

### Adım 2: Codemagic'e Bağlayın

1. https://codemagic.io → Sign up
2. GitHub ile giriş yapın
3. "Add application" → Projenizi seçin

### Adım 3: iOS Yapılandırması

Codemagic otomatik olarak `codemagic.yaml` dosyası oluşturur. iOS için:

- Apple Developer hesabı bilgilerinizi girin
- Certificate ve provisioning profile oluşturun

### Adım 4: Build

"Start new build" → iOS → Build başlar!

---

## 📱 Test Etme

### Yöntem 1: TestFlight
1. Build tamamlandığında TestFlight'a yüklenir
2. iPhone'unuzda TestFlight uygulamasını açın
3. Uygulamayı indirin ve test edin

### Yöntem 2: Doğrudan Yükleme
1. IPA dosyasını indirin
2. Apple Configurator veya 3uTools ile cihaza yükleyin

---

## ⚙️ Codemagic Yapılandırma Dosyası

Projenize `codemagic.yaml` dosyası ekleyebiliriz. Bu dosya build sürecini otomatikleştirir.

