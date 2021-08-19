//
//  SourceViewController.swift
//  MVVMTest
//
//  Created by Jonathan Castillo on 16/8/21.
//
import UIKit

class SourceViewController: UIViewController {

    @IBOutlet weak var sourceTableView: UITableView!

    private var sourceViewModel : SourcesViewModel!
    private var dataSource : TableViewDataSource<SourceTableViewCell,SourceData>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.sourceViewModel =  SourcesViewModel()
        self.sourceViewModel.bindSourceViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        
        self.dataSource = TableViewDataSource(cellIdentifier: "SourceTableViewCell", items: self.sourceViewModel.sourceData.sources, configureCell: { (cell, evm) in
                    cell.source = evm
                })
        
   
        
        
        DispatchQueue.main.async {
            self.sourceTableView.dataSource = self.dataSource
            self.sourceTableView.reloadData()
        }
        
    }
    
}
