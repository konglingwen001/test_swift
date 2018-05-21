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

    @IBOutlet var guitarNoteViewList: UITableView!
    
    //var editNoteView: EditNoteView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesModel = NotesModel.getInstance()
        self.guitarNoteViewList.delegate = self
        self.guitarNoteViewList.dataSource = self
        self.guitarNoteViewList.estimatedRowHeight = 0
        self.guitarNoteViewList.register(GuitarNoteTableViewCell().classForCoder, forCellReuseIdentifier: "cell")
        
//        self.editNoteView = EditNoteView()
//        self.editNoteView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(editNoteView)
//        let editNoteViewLeft = NSLayoutConstraint(item: editNoteView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
//        let editNoteViewRight = NSLayoutConstraint(item: editNoteView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
//        let editNoteViewTop = NSLayoutConstraint(item: editNoteView, attribute: .top, relatedBy: .equal, toItem: self.guitarNoteViewList, attribute: .bottom, multiplier: 1, constant: 0)
//        let editNoteViewBottom = NSLayoutConstraint(item: editNoteView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
//        let editNoteViewHeight = NSLayoutConstraint(item: editNoteView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 400)
//        let constraints: [NSLayoutConstraint] = [editNoteViewTop, editNoteViewLeft, editNoteViewRight, editNoteViewBottom]
//
//        self.editNoteView.addConstraint(editNoteViewHeight)
//        self.view.addConstraints(constraints)
        
        

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
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func edit(_: Any) {
        NSLog("Edit")
    }
    
    func reload() {
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
