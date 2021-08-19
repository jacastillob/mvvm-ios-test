//
//  HeadlineViewController.swift
//  MVVMTest
//
//  Created by Jonathan Castillo on 16/8/21.
//
import UIKit


class HeadlineViewController: UIViewController {
   
    
    
    @IBOutlet  var headlineTableView: UITableView!
    
    private var headlineViewModel : HeadlinesViewModel!
    
    private var dataSource : HeadlineTableViewDataSource<HeadlineTableViewCell,HeadlineData>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headlineTableView.delegate = self
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
extension HeadlineViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
     let AddAction = UIContextualAction(style: .destructive, title: "Save", handler: { (action, view, success) in
         print("Save")
     })
     AddAction.backgroundColor = .blue
     return UISwipeActionsConfiguration(actions: [AddAction])
   }
    
}

