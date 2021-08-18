//
//  SavedHeadlinesViewModel.swift
//  MVVMMedibankTest
//
//  Created by Jonathan Castillo on 18/8/21.
//

import Foundation

class SavedHeadlinesViewModel : NSObject {
    
    private var apiService : APIService!
    
    private(set) var savedHeadlineData : SavedHeadlines! {
        didSet {
            self.bindSavedHeadlineViewModelToController()
        }
    }
    var bindSavedHeadlineViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToData()
    }
    
    func callFuncToData() {
            self.apiService.getSavedHeadlinesData { (savedHeadlineData) in
                self.savedHeadlineData = savedHeadlineData
            }
        }
}
