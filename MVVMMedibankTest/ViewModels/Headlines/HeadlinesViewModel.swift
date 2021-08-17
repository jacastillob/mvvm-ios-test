//
//  HeadlinesViewModel.swift
//  MVVMTest
//
//  Created by Jonathan Castillo on 16/8/21.
//

import Foundation

class HeadlinesViewModel : NSObject {
    
    private var apiService : APIService!
    
    private(set) var headlineData : Headlines! {
        didSet {
            self.bindHeadlineViewModelToController()
        }
    }
    
    var bindHeadlineViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToData()
    }
    
    func callFuncToData() {
            self.apiService.getHeadlinesData { (headlineData) in
                self.headlineData = headlineData
            }
        }
}
