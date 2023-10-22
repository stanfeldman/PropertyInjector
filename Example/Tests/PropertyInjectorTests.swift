import Quick
import Nimble
import PropertyInjector

protocol Useful {
    func getValue() -> Int
}

class Service: Useful {
    static let value = 5
    
    func getValue() -> Int {
        return Service.value
    }
}

class MockService: Service {
    static let anotherValue = 1
    
    override func getValue() -> Int {
        return MockService.anotherValue
    }
}

class PropertyInjectorTests: QuickSpec {
    
    override class func spec() {

        beforeEach {
            DependencyResolver.clear()
        }

        describe("resolving") {

            it("protocol") {
                DependencyResolver.register {
                    $0.singleton(Useful.self, Service())
                }

                let service: Useful = DependencyResolver.resolve()

                expect(service).to(beAKindOf(Useful.self))
                expect(service).to(beAKindOf(Service.self))
            }

            it("class") {
                DependencyResolver.register {
                    $0.factory(Service.self, Service())
                }

                let service: Service = DependencyResolver.resolve()

                expect(service).to(beAKindOf(Service.self))
            }

            it("class using shortcut method") {
                DependencyResolver.register {
                    $0.factory(Service())
                }

                let service: Service = DependencyResolver.resolve()

                expect(service).to(beAKindOf(Service.self))
            }

            it("works for optionals too") {
                DependencyResolver.register {
                    $0.factory(Service())
                }

                let service: Service? = DependencyResolver.resolve()
                let service2: Service! = DependencyResolver.resolve()

                expect(service).to(beAKindOf(Service.self))
                expect(service2).to(beAKindOf(Service.self))
            }

            it("mocked dependencies") {
                DependencyResolver.register {
                    $0.singleton(Service.self, Service())
                }
                DependencyResolver.register {
                    $0.singleton(Service.self, MockService())
                }

                let service: Service = DependencyResolver.resolve()

                expect(service).to(beAKindOf(MockService.self))
                expect(service.getValue()).to(equal(MockService.anotherValue))
            }

            it("crashes if the dependency is not registered") {
                expect({ () -> Void in
                    let _: Service = DependencyResolver.resolve()
                }).to(throwAssertion())
            }

        }

        describe("resolution strategy is correct for") {

            it("singleton") {
                DependencyResolver.register {
                    $0.singleton(Service.self, Service())
                }

                let service1: Service = DependencyResolver.resolve()
                let service2: Service = DependencyResolver.resolve()

                expect(service1) === service2
            }

            it("factory") {
                DependencyResolver.register {
                    $0.factory(Service.self, Service())
                }

                let service1: Service = DependencyResolver.resolve()
                let service2: Service = DependencyResolver.resolve()

                expect(service1) !== service2
            }

        }
    }
}
