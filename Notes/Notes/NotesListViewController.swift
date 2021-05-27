import UIKit

class NotesListViewController: UITableViewController, UISearchBarDelegate {
    
    //connecting data to views
    @IBOutlet var SearchBar: UISearchBar!
    @IBAction func createNote() {
        let _ = NoteManager.shared.create()
        reload()
    }
    
    //lists
    var searchResults: [Note] = []
    var notes: [Note] = []
    
    //reload data
    func reload() {
        notes = NoteManager.shared.getNotes()
        tableView.reloadData()
    }
    
    //load data
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SearchBar?.delegate = self
        reload()
    }
    
    //display data in table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // how many items
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults.count == 0 {
            return notes.count
        }
        else {
            return searchResults.count
        }
    }
    
    // show right content
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        if searchResults.count == 0 {
            cell.textLabel?.text = notes[indexPath.row].content
        }
        else {
            cell.textLabel?.text = searchResults[indexPath.row].content
        }
        return cell
    }
    
    // use segue to pass note from list to other view controler
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NoteSegue",
                let destination = segue.destination as? NoteViewController,
                let index = tableView.indexPathForSelectedRow?.row {
            if searchResults.count == 0 {
                destination.note = notes[index]
            }
            else {
                destination.note = searchResults[index]
            }
            
        }
    }
    
    
    //search results
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults.removeAll()
        
        if searchText.count != 0 {
            for one in notes {
                if one.content.contains(searchText) {
                    searchResults.append(one)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
