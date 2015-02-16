How to grab Android SHA1 key from .p12?
=======================================
- Open Terminal or Command line and navigate to where your .p12 key is.
- Type in: `keytool -v -list -keystore mycert.p12 -storetype pkcs12` where mycert.p12 is the filename of your .p12 key.
- Enter keystore password (the one you used when exported .p12 key).
- Copy sha1 fingerprint signature bytes text

https://developers.google.com/+/mobile/android/share/interactive-post#configure_the_share_dialog  
https://developers.google.com/+/mobile/ios/share/interactive-post#configure_your_share_dialog