//
//  NetworkMonitor.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 27.04.2025.
//

import Network

class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private(set) var isConnected: Bool = true
    
    private init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
