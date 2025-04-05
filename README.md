# Dependency Injection

- Dependency Injection is a `software design pattern` in which `an object receives other objects` that it depends on instead of creating them itself.
- These other objects are called dependencies.
- It is used to achieve `Inversion of Control(IoC)` between classes and their dependencies.

## Why we need Dependency Injection?

- Testability: Real objects can be easily swappable.
- Decoupling: Classes don't create their dependencies, make the code modular and maintainble.
- Flexibility: One can inject different implementation at runtime.

## Types of Dependency Injection

### Constructor Injection:

In constructor Injection dependencies are passes via class initializer. It is the most common and recommended way.

```
final class viewModel {
    let service: Service
    
    init(service: Service) {
        self.service = service
    }
}
```

**_Pros:_** Ensures the object is fully initialized with all the dependencies before use.

### Property Injection:

Dependencies are set after the object is created via public properties.

```
final class ViewModel {
    var analyticsReporter: AnalyticsReporter?
}

let viewModel = ViewModel()
viewModel.analyticsReporter = AnalyticsReporter()
```

**_Pros:_** Can inject after object creation.
**_Cons:_** Can lead to run time error if isn't set before use.

### Method Injection:

Dependencies are passed to specific methods instead of the whole object.

```
final class UserManager {
    func greeting(name: String, using formatter: LogFormatter) {
        let formatted = formatter.format(name)
        print(formatted)
    }
}
```

**_Pros:_** Good for short lived dependencies.
