//
//  GuitarNoteViewController.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/18.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import UIKit

class GuitarNoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NoteTableViewDelegate {
    
    var notesModel: NotesModel? = nil
    var isNoteViewEditing: Bool = false

    @IBOutlet var guitarNoteViewList: UITableView!
    
    @IBOutlet var editNoteView: EditNoteView!
    @IBOutlet var editNoteViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesModel = NotesModel.getInstance()
        self.guitarNoteViewList.delegate = self
        self.guitarNoteViewList.dataSource = self
        self.guitarNoteViewList.estimatedRowHeight = 0
        self.guitarNoteViewList.register(GuitarNoteTableViewCell().classForCoder, forCellReuseIdentifier: "cell")
        
        self.editNoteView.delegate = self
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(back(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(edit(_:)))
        self.navigationItem.title = notesModel!.getGuitarNoteName()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func back(_: Any) {
        let isChanged: Bool = notesModel!.checkGuitarNotesChanged()
        if isChanged {
            let alertController = UIAlertController(title: "Save", message: "The Guitar Notes has been changed, do you want to save it?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                NSLog("OK")
                self.notesModel!.saveToFile(title: alertController.textFields!.first!.text!)
                self.dismiss(animated: true, completion: nil) //OK事件会自动dismiss对话框，再次dismiss将Controller关闭，返回上层界面
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
                NSLog("Cancel")
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            alertController.addTextField(configurationHandler: { (textField: UITextField!) in
                textField.placeholder = self.notesModel!.getGuitarNoteName()
            })
            self.present(alertController, animated: true) {
                NSLog("Done")
            }
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func edit(_: Any) {
        if isNoteViewEditing {
            self.navigationItem.rightBarButtonItem!.title = "Edit"
            self.editNoteViewHeight.constant = 0
            //self.editNoteViewHeight = NSLayoutConstraint(item: self.editNoteView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
        } else {
            self.navigationItem.rightBarButtonItem!.title = "Done"
            self.editNoteViewHeight.constant = 300
            //self.editNoteViewHeight = NSLayoutConstraint(item: self.editNoteView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 300)
        }
        isNoteViewEditing = !isNoteViewEditing
    }
    
    func reload() {
        notesModel!.calNotesSize()
        guitarNoteViewList.reloadData()
    }
    
    func refreshRow(row: Int) {
        let indexPath: IndexPath = IndexPath(row: row, section: 0)
        guitarNoteViewList.reloadRows(at: [indexPath], with: .none)
        NSLog("row: \(row)")
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesModel!.getNotesSizeArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GuitarNoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GuitarNoteTableViewCell
        cell.delegate = self
        cell.lineNo = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
