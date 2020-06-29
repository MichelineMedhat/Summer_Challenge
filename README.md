# Summer Corona 2020

It's a secure flutter website coded with love for prep students to enagage them into activities during the pandemic.

## How to use

- [Download Flutter Web](https://flutter.dev/docs/get-started/web).
- Create a New Project on Firebase.
- Create a web project on Firebase and exchange your firebaseConfig with the one in [user -> web -> index.html].
- Create secretKey.dart in [user -> util]
```
class SecretKey{
   static String secretKey = 'your_secret_key';
}
```