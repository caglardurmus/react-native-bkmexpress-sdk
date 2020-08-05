# react-native-bkmexpress-sdk
BKM Express ödeme,kart eşleştirme ve kart değiştirme işlemlerini gerçekleştirilmek için kullanılır. BKM Express native SDK'ları baz alınarak geliştirme yapılmıştır. Kütüphane oluşturulurken bazı konularda benzer bir kütüphane olan [react-native-bkmexpress](https://github.com/kubilaytural/react-native-bkmexpress) kütüphanesinden yararlanılmıştır.

**Android:** [https://github.com/BKMExpress/BEXAndroidSDK](https://github.com/BKMExpress/BEXAndroidSDK)

**IOS:** [https://github.com/BKMExpress/iOSBKMExpressSDK](https://github.com/BKMExpress/iOSBKMExpressSDK)

## Kurulum

`$ npm install react-native-bkmexpress-sdk --save`

`$ yarn add react-native-bkmexpress-sdk`

## IOS

Projenizin ios klasörü içindeki ***.xcworkspace** dosyasını XCode ile çalıştırın.

**node_modules/react-native-bkmexpress-sdk/ios** klasörü içindeki **BEX.bundle** ve **libBKMExpressSDK.a** dosyalarını sürükleyerek **Frameworks** klasörü altına ekleyin **Copy items if needed** seçili olduğundan emin olun ve **Add to targets** kısmından uygulamanızı seçin.

Son olarak pod yüklemesini gerçekleştirmeyi unutmayın.

```
$ cd ios && pod install && cd ..
```

## Android

Projenizin içindeki **local.properties** dosyasına aşağıdaki keyleri Bkm Expiress'den aldığınız bilgiler ile tanımlayınız.

**AndroidX** desteği bulunmayan uygulamalarınız için versiyon bilgisini **1.1.23** olarak değiştiriniz

```
bkm_username=user_name
bkm_password=password
bkm_maven_url=http://...
bkm_version=2.1.1
```

**android/build.gradle** altında aşağıdaki değişikliği yapınız

```
Properties properties = new Properties()
properties.load(project.rootProject.file('local.properties').newDataInputStream())

allprojects {
    repositories {
        //...        
        maven {
          url = properties.getProperty("bkm_maven_url")
          credentials {
            username = properties.getProperty("bkm_username")
            password = properties.getProperty("bkm_password")
         }
       }
    }
}
```

## Kullanım
```import BkmExpressSdk from 'react-native-bkm-express-sdk';```


#### SUBMIT CONSUMER (KART EŞLEME)
```
BkmExpressSdk.submitConsumer(token, environment , (callback, result) => {
        if (result === '0') {
            console.log('Successful. kart no: ', callback)
        }
        else if (result === '1') {
            console.log('Canceled')
        }
        else if (result === '2') {
            console.log('failed. error: ', callback)
        } 
    }
);
BkmExpressSdk;
```

####  RESUBMIT CONSUMER (KART EŞLEME)
* Diğer işlemlerden farklı olarak, ReSubmitConsumer operasyonu <u>daha önceden kart eklemiş</u> kullanıcının tekrardan sisteme giriş yapmadan kart değiştirmesine olanak sağlamaktadır. Bahsi geçen Ticket, BEX Core servisleri tarafından sağlanmaktadır.

```
BkmExpressSdk.resubmitConsumer(ticket, environment , (callback, result) => {
        if (result === '0') {
            console.log('Successful. kart no: ', callback)
        }
        else if (result === '1') {
            console.log('Canceled')
        }
        else if (result === '2') {
            console.log('failed. error: ', callback)
        } 
    }
);
BkmExpressSdk;
```
####  PAYMENT (ÖDEME)
```
BkmExpressSdk.payment(token, environment , (callback, result) => {
        if (result === '0') {
            console.log('Successful. Pos Cevabı: ',result)
        }
        else if (result === '1') {
            console.log('Canceled')
        }
        else if (result === '2') {
            console.log('failed. error: ', callback)
        } 
    }
);
BkmExpressSdk;
```

### Parametreler

| Değer Adı | Değer Tipi | Değerin Amacı |
| ------------- | ------------- | ------------- |
| token  | String  | Yapılacak olan işlemin token bilgisi |
| environment | String | Çalıştırma ortamı - PREPORD ortamı için "PREPROD", PROD ortamı için "PROD" giriniz |
| ticket  | String  | Kartı yeniden eşleştirmede kullanılacak Bkm tarafından iletilen ticket numarası |
| callback | String | İşlem başarılı ise duruma göre obje veya string dönebilir. Başarısız işlemlerde hata mesajı |
| result | String | Dönen sonuç (0 Başarılı - 1 İptal - 2 Başarısız) |
