//
//  SavedHeadlineViewController.swift
//  MVVMTest
//
//  Created by Jonathan Castillo on 18/8/21.
//
import UIKit


class SavedHeadlineViewController: UIViewController, UITableViewDelegate {
   
    
    
    @IBOutlet  var savedHeadlineTableView: UITableView!
    
    private var savedHeadlineViewModel : SavedHeadlinesViewModel!
    
    private var dataSource : SavedHeadlineTableViewDataSource<SavedHeadlineTableViewCell,SavedHeadlineData>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.savedHeadlineTableView.delegate = self
        self.savedHeadlineTableView.rowHeight = UITableView.automaticDimension
        self.savedHeadlineTableView.estimatedRowHeight = 400
        callToViewModelForUIUpdate()
        
    }
    
    func callToViewModelForUIUpdate(){
        
        self.savedHeadlineViewModel =  SavedHeadlinesViewModel()
        self.savedHeadlineViewModel.bindSavedHeadlineViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        
        self.dataSource = SavedHeadlineTableViewDataSource(cellIdentifier: "SavedHeadlineTableViewCell", items: self.savedHeadlineViewModel.savedHeadlineData.Items, configureCell: { (cell, evm) in
                    cell.savedHeadline = evm
                })
        
        DispatchQueue.main.async {
            self.savedHeadlineTableView.dataSource = self.dataSource
            self.savedHeadlineTableView.reloadData()
        }
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is HeadlineDetailViewController {
            let vc = segue.destination as? HeadlineDetailViewController
            let cell = sender as! HeadlineTableViewCell
            vc?.headline = (cell.headline!)
        }
    }
    
}
