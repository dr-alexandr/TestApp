//
//  ApplicationCoordinator.swift
//  TestFive
//
//  Created by Dr.Alexandr on 23.12.2022.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
}

final class ApplicationCoordinator: Coordinator {
    
    // MARK: - Vars & Lets
    private let router: RouterProtocol


    // MARK: - Coordinator
    
    func start() {
        showViewController()
    }
    
    deinit {
        print("Deallocation \(self)")
    }
    
    // MARK: - Private methods
    
    private func showViewController() {
        let vc = TestViewController(viewModel: TestViewModel(networkManager: NetworkManager()))
        self.router.setRootModule(vc, hideBar: true)
    }
    
    // MARK: - Init
    
    init(router: Router) {
        self.router = router
    }
    
}
