# SwiftUIWeatherApp

The project  architecture is based on MVVM + Coordinators, where logic is decomposed into four main parts: View, Modal View, ViewModel and Coordinator. 

ViewModel is a class which contains business logic except for navigation. It is a subclass of `ObservableObject`, and the interaction between the ViewModel and View is done by `@published` properties of the ViewModel. The ViewModel is signed by `ViewModelType` Protocol which contains inputs, outputs and bindings. 

For navigation, the ViewModel interacts with the Coordinator using Combine, with two Structs and Properties: Routing and Output. Both Structs conform to `RoutingProtocol` and `OutputProtocol`, and contain `PassthroughSubjects` of any value types. 

The Coordinator should subclass Coordinator, and has a generic type `ResultType` which indicates the result the Coordinator returns after it is dismissed. It has a unique identifier and a dictionary of child Coordinators. To present a Coordinator on top of another, the `coordinateTo(coordinator:)` method should be called which stores the Coordinator in `childCoordinators` and runs the `start()` method. 

Services are Structs with methods for interacting with external API. Every method returns `AnyPublisher` which emits a value (or error) when the request is finished. 

Routers are basic Classes which contain static methods for Modal Presentation - `present()` and `dismiss()`, NavigationController Property and custom Push and Pop methods. The Router should be used to handle popping action, passing `onNavigateBack` closure and doing actions when the ViewController is popped using gesture. To present Modals, `present(modalTransitionStyle:modalPresentationStyle:animated:)` should be used.
