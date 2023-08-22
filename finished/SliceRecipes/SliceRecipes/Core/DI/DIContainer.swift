import Foundation

protocol DIContainer {
    func register<Service>(_ service: Service.Type, resolver: @escaping (DIContainer) -> Service)
    
    func resolve<Service>() -> Service
    func resolve<Service>(_ service: Service.Type) -> Service?
}
