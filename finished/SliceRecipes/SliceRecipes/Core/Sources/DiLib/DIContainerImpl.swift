import Foundation

public final class DIContainerImpl: DIContainer {
    
    private var registeredServices: [String: Any] = [:]
    
    public init() {}
    
    public func register<Service>(_ service: Service.Type, resolver: @escaping (DIContainer) -> Service) {
        let key = String(describing: Service.self)
        registeredServices[key] = resolver(self)
    }
    
    public func resolve<Service>() -> Service {
        guard let service = resolve(Service.self) else {
            fatalError("Service does not exist")
        }
        return service
    }
    
    public func resolve<Service>(_ service: Service.Type) -> Service? {
        let key = String(describing: service)
        guard let service = registeredServices[key] as? Service else {
            fatalError("\(service) has not been registered")
        }
        
        return service
    }
    
}
