# Modular & Type-Safe Localization in SwiftUI 🌍

![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%2017.0+-lightgrey.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

Büyük ölçekli SwiftUI projelerinde **String Catalogs (.xcstrings)** kullanarak oluşturulmuş, modüler, ölçeklenebilir ve tip güvenli (type-safe) 
yerelleştirme mimarisi örneği.

Bu proje, devasa `Localizable.strings` dosyalarının yarattığı yönetim kaosunu çözmeyi ve "Magic String" kullanımını ortadan kaldırmayı hedefler.

## 🎯 Amaç ve Sorun Tespiti

Geleneksel iOS projelerinde tek bir `Localizable` dosyası kullanmak zamanla şu sorunlara yol açar:
* **Merge Conflict:** Ekip büyüdükçe herkesin aynı dosyada çalışması.
* **Bağlam Kaybı:** Hangi anahtarın (key) hangi ekrana ait olduğunun unutulması.
* **Kirli Kod:** `tableName` parametrelerinin elle string olarak girilmesi (`tableName: "LoginView"`).

**Çözüm:** Yerelleştirme dosyalarını modüllere/ekranlara bölmek ve erişimi tip güvenli bir `Enum` üzerinden yönetmek.

## 🏗 Proje Yapısı

Dosyalar, kullanım alanlarına (veya modüllere) göre ayrıştırılmıştır:

```text
Resources/
├── Localization/
│   ├── LoginViewLocalizable.xcstrings    <-- Login ekranına özel
│   ├── SettingsViewLocalizable.xcstrings <-- Ayarlar ekranına özel
│   ├── SharedLocalizable.xcstrings       <-- Ortak (Tamam, İptal vb.)

```

## 🚀 Kurulum ve Kullanım
Bu mimariyi projenize entegre etmek sadece 3 adım sürer.

1. Tablo İsimlerini Tanımlayın (Enum)

String hatası yapmamak için dosya isimlerinizi bir enum içinde toplayın.

```Swift
enum LocalizableTables: String {
    case shared = "SharedLocalizable"
    case loginView = "LoginViewLocalizable"
    case settingsView = "SettingsViewLocalizable"
}
```

2. Extension Ekleyin

String sınıfına, bu enum'ı kabul eden bir extension yazın.

```Swift
extension String {
    func localized(table: LocalizableTables) -> String {
        return NSLocalizedString(self, tableName: table.rawValue, comment: "")
    }
}
```

3. SwiftUI View İçinde Kullanın

Artık tableName parametresini string olarak yazmanıza gerek yok.

```Swift
struct LoginView: View {
    var body: some View {
        VStack {
            // LoginViewLocalizable.xcstrings içinden okur
            Text("welcome_title".localized(table: .loginView))
            
            // SharedLocalizable.xcstrings içinden okur
            Button("login_button".localized(table: .shared)) {
                // Action
            }
        }
        .navigationTitle("nav_title".localized(table: .loginView))
    }
}
```

## ⚡️ İleri Seviye: Parametreli ve Çoğul (Plural) Kullanım
Dinamik veriler ve parametreli metinler için extension'ı şu şekilde genişletebilirsiniz:

```Swift
extension String {
    func localizedWithParameter(table: LocalizableTables, _ args: CVarArg...) -> String {
        let format = self.localized(table: table)
        return String(format: format, arguments: args)
    }
}
```

Kullanım:

```Swift
// Çıktı: "Sepetinizde 3 ürün var."
Text("cart_item_count".localizedWithParameter(table: .shared, 3))
```

## ✅ Avantajları
| Özellik         | Geleneksel Yöntem            | Bu Mimari (Modüler)                 |
|----------------|------------------------------|-------------------------------------|
| Dosya Boyutu   | Devasa (Binlerce satır)      | Küçük ve Yönetilebilir              |
| Git Çakışması  | Yüksek Risk                  | Düşük Risk (İzole Dosyalar)          |
| Tip Güvenliği  | Yok (String Literal)         | Var (Enum)                           |
| Namespace      | login_screen_title           | title (Dosya ismi namespace olur)   |

## 📖 İlgili Makale
Bu mimarinin detaylarını ve arkasındaki mantığı anlattığım Medium yazısına buradan ulaşabilirsiniz: 
[SwiftUI'da Sürdürülebilir Yerelleştirme: Modüler ve Tip Güvenli .xcstrings (String Catalogs) Mimarisi](LINK_BURAYA)
