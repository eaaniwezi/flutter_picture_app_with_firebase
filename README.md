Тестовое задание
Разработать приложение на Flutter для обеих мобильных платформ (Android/iOS). В качестве бэкенда использовать Firebase (модули Authentication, Cloud Firestore, Storage, App Distribution). Приложение должно состоять из:
Экран(ы) входа в приложение (ввод номера телефона, ввод кода подтверждения). Ввести номер телефона, отправить смс через Firebase Authentication, получить код подтверждения, авторизовать пользователя в Firebase Authentication. Сохранить пользователя в коллекцию в Firebase Cloud Firestore.
Главный экран приложения. Состоит из списка (GridView) фотографий, сделанных пользователем и кнопки добавления новой фотографии. Кнопка добавления нового фото должна вызывать диалог выбора источника фотографии (камеры или галереи). Сделанную (выбранную) фотографию загружать в Firebase Storage. Полученную абсолютную ссылку на фото сохранять в коллекцию фотографий пользователя в Cloud Firestore. Пользователь должен иметь возможность удалять фотографии (из Storage и Cloud Firestore) с диалогом подтверждения удаления. 
Также, на главном экране должно быть боковое меню с номером телефона пользователя и кнопкой выхода из приложения.

Для стейт-менеджмента и разделения бизнес и UI логики желательно использовать библиотеку flutter_bloc. Приветствуется использование подходов Clean Architecture/SOLID.

Готовый apk приложения разместить в Firebase App Distribution. Выслать ссылку (инвайт) на установку приложения.

Большим плюсом будет наличие продакшн Flutter приложений в Appstore/Google Play.

Также дополнительным плюсом будет:
Умение разбираться в чужом коде.
Понимание основ и опыт использования в реальных проектах Clean Architecture/SOLID principles.
Знакомство с Kotlin/Java/Swift/Objective-c.
Знание основ реляционных бд, умение составлять SQL запросы.
Опыт работы с админкой Django приложений.
Умение общаться и взаимодействовать с небольшой и дружной командой.



Test task
Develop an application on Flutter for both mobile platforms (Android/iOS). Use Firebase as a backend (Authentication, Cloud Firestore, Storage, App Distribution modules). The application should consist of:
The application login screen(s) (entering a phone number, entering a confirmation code). Enter a phone number, send SMS via Firebase Authentication, get a confirmation code, authorize the user in Firebase Authentication. Save the user to a collection in Firebase Cloud Firestore.
The main screen of the application. It consists of a list (GridView) of photos taken by the user and a button for adding a new photo. The button for adding a new photo should open a dialog for selecting the photo source (camera or gallery). Upload the taken (selected) photo to Firebase Storage. Save the received absolute link to the photo to the user's photo collection in the Cloud Firestore. The user should be able to delete photos (from Storage and Cloud Firestore) with the delete confirmation dialog.
Also, there should be a side menu on the main screen with the user's phone number and an exit button from the application.

For state management and separation of business and UI logic, it is advisable to use the flutter_bloc library. The use of Clean Architecture/SOLID approaches is encouraged.

The finished apk of the application should be placed in Firebase App Distribution. Send a link (invite) to install the application.

A big plus will be the availability of production Flutter applications in the Appstore / Google Play.

Also an additional plus will be:
The ability to understand someone else's code.
Understanding the basics and experience of using Clean Architecture/SOLID principles in real projects.
Introduction to Kotlin/Java/Swift/Objective-c.
Knowledge of the basics of relational databases, the ability to compose SQL queries.
Experience working with the admin panel of Django applications.
Ability to communicate and interact with a small and friendly team.