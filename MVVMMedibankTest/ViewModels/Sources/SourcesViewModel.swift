//
//  SourcesViewModel.swift
//  MVVMTest
//
//  Created by Jonathan Castillo on 16/8/21.
//

import Foundation

class SourcesViewModel : NSObject {
    
    private var apiService : APIService!
    
    private(set) var sourceData : Sources! {
        didSet {
            self.bindSourceViewModelToController()
        }
    }
    
    var bindSourceViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToData()
    }
    
    func callFuncToData() {
            self.apiService.getSourcesData { (sourceData) in
                self.sourceData = sourceData
            }
        }
}
