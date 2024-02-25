Name: ShapeUp!
![](https://github.com/d-smlnk/ShapeUp/blob/main/ShapeUp_Preview.png)
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

