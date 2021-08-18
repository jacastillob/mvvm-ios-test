//
//  HeadlineViewController.swift
//  MVVMTest
//
//  Created by Jonathan Castillo on 16/8/21.
//
import UIKit


class HeadlineViewController: UIViewController, UITableViewDelegate {
   
    
    
    @IBOutlet  var headlineTableView: UITableView!
    
    private var headlineViewModel : HeadlinesViewModel!
    
    private var dataSource : HeadlineTableViewDataSource<HeadlineTableViewCell,HeadlineData>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headlineTableView.delegate = self
        self.headlineTableView.rowHeight = UITableView.automaticDimension
        self.headlineTableView.estimatedRowHeight = 400
        callToViewModelForUIUpdate()
        
    }
    
    func callToViewModelForUIUpdate(){
        
        self.headlineViewModel =  HeadlinesViewModel()
        self.headlineViewModel.bindHeadlineViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        
        self.dataSource = HeadlineTableViewDataSource(cellIdentifier: "HeadlineTableViewCell", items: self.headlineViewModel.headlineData.articles, configureCell: { (cell, evm) in
                    cell.headline = evm
                })
        
        DispatchQueue.main.async {
            self.headlineTableView.dataSource = self.dataSource
            self.headlineTableView.reloadData()
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
