
/** Dependency Injection */

import Foundation
import XCTest

// Sampel Web api response
let responseData: Data = """
    {
        "name": "john Doe",
        "gender": "Male"
        "age": 32
    }
    """
    .data(using: .utf8)!

// Data Model
struct User: Decodable {
    let name: String
    let gender: String
    let age: Int
}

// Service Layer
protocol ServiceProviding {
    func perform(_ request: URLRequest) -> User
}

final class Service: ServiceProviding {
    func perform(_ request: URLRequest) -> User {
        // fetch data
        // decode into User object
        do {
            let user = try JSONDecoder().decode(User.self, from: responseData)
            return user
        } catch {
            print(error.localizedDescription)
            return User(name: "[unknown]", gender: "[unknown]", age: 0)
        }
    }
}

// ViewModel
final class ViewModel {
    let service: ServiceProviding

    private var user: User?

    var userDetail: String {
        "\(self.user!.name) is a \(self.user!.gender) and is \(self.user!.age) years old."
    }

    init(service: ServiceProviding) {
        self.service = service
    }

    func fetchUser() {
        let request = URLRequest(url: URL(string: "https://iosmantra.com/user")!)
        self.user = self.service.perform(request)
    }
}

// Mock
final class MockService: ServiceProviding {
    func perform(_ request: URLRequest) -> User {
        User(name: "Jane Doe", gender: "female", age: 28)
    }
}

// App Target
let service = Service()
let viewModel = ViewModel(service: service)
viewModel.fetchUser()

// Test Target
let mockService = MockService()
let sut = ViewModel(service: mockService)
sut.fetchUser()
XCTAssertEqual(viewModel.userDetail, "Jane Doe is a female and is 28 years old.")
