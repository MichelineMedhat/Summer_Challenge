# Summer Corona 2020

It's a secure flutter website coded with love for prep students to enagage them into activities during the pandemic.

## How to use

- [Download Flutter Web](https://flutter.dev/docs/get-started/web).
- Create a New Project on Firebase.
- Create a web project on Firebase and exchange your firebaseConfig with the one in [user -> web -> index.html].
- Create secretKey.dart in [user -> util]

```dart
class SecretKey{
   static String secretKey = 'your_secret_key';
}
```

# For Multiple Firebase Projects

- Create secretKey.dart in [web directory].

```js
function get_config(type) {
    if (type === 'test') {
        return {
            apiKey: "apiKey",
            authDomain: "authDomain",
            databaseURL: "databaseURL",
            projectId: "projectId",
            storageBucket: "storageBucket",
            messagingSenderId: "messagingSenderId",
            appId: "appId"
        };
    } else {
        return {
            apiKey: "apiKey",
            authDomain: "authDomain",
            databaseURL: "databaseURL",
            projectId: "projectId",
            storageBucket: "storageBucket",
            messagingSenderId: "messagingSenderId",
            appId: "appId"
        };
    }
}
```

- Call get_confige method in [user -> web -> index.html].

```js
    <script>
        var firebaseConfig = get_config('test');
        
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig);
    </script>
```

