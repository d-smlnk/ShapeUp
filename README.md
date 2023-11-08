UKR:

Назва: ShapeUp!

  ● Опис: 
  
ShapeUp! – це фітнес-додаток призначений для допомоги користувачам вести щоденник тренувань, контролювати раціон харчування та рахувати калорії. Додаток допоможе користувачам скласти раціон харчування на основі фізичних даних користувача та його цілей.

Після стадії MVP додаток буде доступний за підпискою, і у користувачів буде 7-денний безкоштовний пробний період. Після цього періоду вони матимуть можливість підписатися за невелику щомісячну плату за можливість користуватися додатком.

  ● Core functional: 
  
– Вирахування норми калорій для збереження ваги за фізичними даними користувача та від його фізичної активності.
– Вирахування необхідної кількості калорій в залежності від цілей користувача(Набрати або скинути вагу)
– Додаток дозволяє додавати власні вправи, відслідковувати прогресію навантажень в кожній вправі та робити з них програми тренувань.
– Додаток надає можливість додавати енергетичну цінність продукту, якщо його немає в списку існуючих продуктів в додатку.

  ● Фічі: 
  
– Користувач може встановити бажану вагу, яку він хоче досягнути. Додаток щотижня надсилатиме користувачеві нагадування про зважування та оновлення ваги в додатку. Це дозволить додатку розрахувати нову кількість калорій, яку необхідно споживати користувачу для досягнення власної мети.
– У майбутньому планується інтегрувати можливість співпраці з місцевими супермаркетами та службами доставки їжі. Це дозволить додатку не лише надавати рекомендації щодо кількості калорій для споживання, але і створювати персоналізований раціон харчування на кожен день за необхідним калоражем.
– Додаток підтримуватиме чотири мови: українську, російську, французьку та англійську.

  ● Архітектура додатку:
  
Додаток буде написаний на архітектурі MVP(Model-View-Presenter).
Вибір архітектури MVP (Model-View-Presenter) для цього додатку має ряд переваг. 
Ось кілька причин, чому MVP є відмінним вибором:
1.	Розділення відображення та бізнес-логіки: MVP дозволяє чітко розділити відображення (інтерфейс користувача) від бізнес-логіки. У додатку користувачі вводитимуть свої дані, встановлюватимуть цілі та взаємодіятимуть з інтерфейсом, але вся обробка цих даних буде відбуватися в презентері та моделі. Це полегшує розробку та тестування обох компонентів окремо.
2.	Тестування: Використання MVP сприяє полегшенню тестування. Це надає можливість створювати модульні тести для презентера та моделі, перевіряючи їхню правильну роботу і взаємодію. Відображення може бути більш важким для тестування через графічний інтерфейс, але основна логіка залишається в презентері, що робить це більш контрольованим та простим.
3.	Легке розширення та підтримка: MVP сприяє легкому впровадженню нових функцій та модулів у додаток без великих змін у вже існуючому коді. Це дає можливість легко додавати нові функції, розширюючи функціонал презентера та моделі.
4.	Підтримка багатьох мов: Оскільки додаток планує підтримувати кілька мов, MVP робить роботу з локалізацією більш ефективною. Це дає можливість мати окремі ресурси та переклади для кожної мови та легко перемикатися між ними в презентері.

  ● Технології:

UIKit

SnapKit

RxSwift

Firebase - В додатку буде реєстрація та авторизація клієнта, та деякі базові вправи вже будуть додані для зручності юзера.

Realm - В додатку буде використовуватися база данних Realm для збереження фізичних вправ, програм тренувань та енергетичної цінності доданих продуктів. Додаток буде зберігати деякі дані локально на пристрої.

Alamofire - В додатку буде використовуватися технологія Alamofire для підключення до API бази даних яка містить базові продукти та їх енергетичну цінність.  



  ● Опис структури об'єктів:

	Відображення (View):
 
UserView: Авторизація користувача, де він вводить дані про себе такі як вагу, зріст, вік, фізичну активність, стать, ціль(похудати або набрати масу) та відсоток жиру в тілі(Опціонально).

MainView(Головний екран): Головний екран додатку включає в себе профіль користувача, графік (бар чарт), що відображає співвідношення між спожитими калоріями та калоріями, які потрібно спожити, а також налаштування цілей та можливість введення зміни ваги.

ExerciseListView (Список вправ): Представлення для відображення списку доступних фізичних вправ і тренувальних програм.

NutritionView (Харчування): Представлення для відображення і введення інформації щодо прийому їжі та раціону користувача.

	Презентер (Presenter):
 
UserPresenter (Презентер головного екрану): Презентер для головного екрану, який взаємодіє з моделями і відображеннями для обробки введених даних користувача, рекомендацій щодо тренувань та харчування по результату вирахованих калорій.

ExerciseListPresenter (Презентер списку вправ): Презентер, який керує списком доступних вправ і тренувальних програм.

NutritionPresenter (Презентер харчування): Презентер, що відповідає за роботу з харчуванням та відображення даних про харчування.

	Модель (Model):
 
UserModel (Обробка даних користувача): Клас який обробляє інформацію користувача, вираховує необхідну кількість калорій до споживання, щоб досягти цілі.

ExerciseModel (Фізичні вправи): Клас, який містить інформацію про різні фізичні вправи. Ця модель містить дані, такі як назва вправи, кількість підходів, вагу, тип вправи (наприклад, аеробіка, силові вправи), тощо.

NutritionModel (Харчування): Модель для зберігання інформації про продукти, їх енергетичну цінність та інші харчові характеристики.



ENG:

Name: ShapeUp!

  ● Description: 
  
ShapeUp! is a fitness application designed to help users keep a training diary, monitor their diet and count calories. The application will help users to create a diet based on the user's physical data and goals.

After the MVP stage, the app will be available on a subscription basis and users will have a 7-day free trial period. After this period, they will have the option to subscribe for a small monthly fee to be able to use the app.

Core functional: 
- Calculation of calorie requirements for weight maintenance based on the user's physical data and physical activity.
- Calculation of the required number of calories depending on the user's goals (gain or lose weight)
- The application allows you to add your own exercises, track the progression of loads in each exercise and make them into training programs.
- The app provides the ability to add the energy value of a product if it is not in the list of existing products in the app.

  ● Features: 

- The user can set the desired weight they want to reach. The app will send weekly reminders to the user to weigh themselves and update their weight in the app. This will allow the app to calculate the new number of calories that the user needs to consume to reach their goal.
- In the future, it is planned to integrate the possibility of cooperation with local supermarkets and food delivery services. This will allow the app not only to provide recommendations on the number of calories to consume, but also to create a personalized diet for each day according to the required calorie intake.
- The app will support four languages: Ukrainian, Russian, French, and English.

  ● Application architecture: 

The application will be written on the MVP (Model-View-Presenter) architecture.
Choosing the MVP (Model-View-Presenter) architecture for this application has a number of advantages. 
Here are some reasons why MVP is an excellent choice:
1.	Separation of display and business logic: MVP allows you to clearly separate the display (user interface) from the business logic. In the application, users will enter their data, set goals, and interact with the interface, but all processing of this data will take place in the presentation and model. This makes it easier to develop and test both components separately.
2.	Testing: Using MVPs helps to facilitate testing. It provides the ability to create unit tests for the presenter and model, verifying that they work and interact correctly. The display may be more difficult to test because of the GUI, but the underlying logic remains in the presenter, making it more controllable and easier.
3.	Easy to extend and maintain: MVP facilitates the easy implementation of new features and modules into the application without major changes to the existing code. This makes it possible to easily add new features, extending the functionality of the presenter and model.
4.	Support for multiple languages: Since the application is planning to support multiple languages, MVP makes the work with localization more efficient. This makes it possible to have separate resources and translations for each language and easily switch between them in the presenter.

  ● Technologies:
  
UIKit

SnapKit

RxSwift

Firebase - There will be client registration and authorization in the app, and some basic exercises will already be added for the convenience of the user.

Realm - The application will use the Realm database to store exercise, training programs, and energy value of the added products. The app will store all data locally on the device.

Alamofire - The application will use Alamofire technology to connect to the API database containing basic products and their energy value.  

  ● Description of the structure of objects:

	 View:

UserView: User authorization, where he enters data about himself such as weight, height, age, physical activity, gender, goal (lose weight or gain weight) and body fat percentage (optional).

MainView: The main screen of the application includes the user profile, a graph (bar chart) showing the relationship between calories consumed and calories to be consumed, as well as goal settings and the ability to enter weight changes.

ExerciseListView: A view that displays a list of available exercises and training programs.

NutritionView: A view for displaying and entering information about the user's food intake and diet.
  
    Presenter:
 
UserPresenter: A home screen presenter that interacts with models and displays to process user input, workout recommendations, and nutrition based on calorie counts.

ExerciseListPresenter: A presenter that manages the list of available exercises and training programs.

NutritionPresenter: The presenter responsible for managing nutrition and displaying nutrition data.

	 Model:
 
UserModel: A class that processes user information and calculates the number of calories to consume to reach a goal.

ExerciseModel: A class that contains information about different physical activities. This model contains data such as exercise name, number of reps, weight, type of exercise (e.g. aerobics, strength training), etc.

NutritionModel: A model for storing information about foods, their energy value, and other nutritional characteristics.
