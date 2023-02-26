# SHOP APP

A practice Flutter project.

## Description

This is a practice flutter project which is a part a udemy course [Flutter & Dart - The Complete Guide](https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/)
created by [Maximilian Schwarzmüller](https://www.udemy.com/user/maximilian-schwarzmuller/)

## Warning

1. This code is not 100% similar to the ones in the udemy course due to it still uses an old version of flutter whereas this one uses Flutter 3.7.5 (I'm a bit disappointed as well). Also, I like to tinker it myself by refactoring and adding packages that are not used in the course. Therefore, I apologize if you have a hard time following this code.
2. This code is also not 100% optimal. The refactoring and extra packages don't guarantee a better code performance. I'm still a noob in flutter. Therefore, I'm open to any suggestions.

## Requirements

## Envinronment Variables

This project uses environment variables (envar) to store sensitive data (database url, apikey, etc.)

### How to use

1. create `.env` file on the root folder
2. fill the file with all the required envars
3. run the project
4. everytime there's an update to the file, you need to re-run the project so that the app uses an updated version of it

```
<envar key 1>=<envar value 1>
<envar key 2>=<envar value 2>
...
<envar key n>=<envar value n>
```

### required envars

| key                   | description                                                                                                                                | example                        |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |--------------------------------|
| SHOP_APP_FIREBASE_URL | the url of your firebase database (without https)                                                                                          | asdf-123.firebasedatabase.app  |
| SHOP_APP_AUTH_URL     | firebase's auth base url (without https) (see [here](https://firebase.google.com/docs/reference/rest/auth/#section-create-email-password)) | identitytoolkit.googleapis.com |
| SHOP_APP_API_KEY      | the api key of your firebase database                                                                                                      | asdf123                        |
