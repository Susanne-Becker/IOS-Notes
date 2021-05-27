import UIKit

class NoteViewController: UIViewController {
    @IBOutlet var contentTextView: UITextView!
    
    var note: Note? = nil
    
    // delete action and message
    @IBAction func deleteNote() {
            let message = UIAlertController(title: "Delete Note", message: "Are you sure you want to delete this note?", preferredStyle: .alert)
            message.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                if NoteManager.shared.deleteNote(note: self.note!) {
                    self.navigationController?.popViewController(animated: true)
                }
            }))
            message.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            DispatchQueue.main.async {
                self.present(message, animated: true, completion: nil)
            }
        }
    
    // set text equal to notes contents
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contentTextView.text = note!.content
    }
    
    // change note object and save
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        note!.content = contentTextView.text
        NoteManager.shared.saveNote(note: note!)
    }
    
}
