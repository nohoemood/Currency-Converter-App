// Router.swift by mac 09.09.2026 

import Foundation
import Combine

enum Tab: Hashable {
    case main
    case list
}

enum Route: Hashable {
    case currencyDetail(currency: Currency)
}

final class Router: ObservableObject {
    @Published var path: [Route] = []
    
    @Published var selectedTab: Tab = .main
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func pop() {
        if !path.isEmpty { path.removeLast() }
    }
}
