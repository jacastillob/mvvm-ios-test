//
//  SavedHeadlineViewController.swift
//  MVVMTest
//
//  Created by Jonathan Castillo on 18/8/21.
//
import UIKit


class SavedHeadlineViewController: UIViewController {
    
    
    @IBOutlet  var savedHeadlineTableView: UITableView!
    
    private var savedHeadlineViewModel : SavedHeadlinesViewModel!
    
    private var dataSource : SavedHeadlineTableViewDataSource<SavedHeadlineTableViewCell,SavedHeadlineData>!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.savedHeadlineTableView.delegate = self
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
            let cell = sender as! SavedHeadlineTableViewCell
            vc?.urlHeadline = (cell.savedHeadline?.url!)
        }
    }
}

extension SavedHeadlineViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
     let DeleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, success) in
        let alert = UIAlertController(title: "Deleting Headline", message: "", preferredStyle: .alert)
        self.present(alert, animated: true)
        self.savedHeadlineViewModel.deleteSaveHeadline(id: (self.dataSource.items[indexPath.row].id! ) )
        self.dismiss(animated: true)
        self.callToViewModelForUIUpdate()
        
     })
     DeleteAction.backgroundColor = .red
     return UISwipeActionsConfiguration(actions: [DeleteAction])
   }
    
}
