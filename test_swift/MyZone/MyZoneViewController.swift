//
//  MyZoneViewController.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/10.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import UIKit

class MyZoneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var guitarNoteList: UITableView!
    
    var notesModel: NotesModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesModel = NotesModel.getInstance()

        guitarNoteList.delegate = self
        guitarNoteList.dataSource = self
        
        self.guitarNoteList.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "cell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesModel!.getGuitarNotesFileNum() + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.row == notesModel!.getGuitarNotesFileNum() {
            cell.textLabel?.text = "新建吉他谱"
        } else {
            cell.textLabel?.text = notesModel!.getGuitarNotesFileName(index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < notesModel!.getGuitarNotesFileNum() {
            notesModel?.setGuitarNotesWithNotesTitle(noteTitle: (tableView.cellForRow(at: indexPath)?.textLabel?.text)!)
            let guitarNoteViewController = UINavigationController(rootViewController: GuitarNoteViewController())
            
            present(guitarNoteViewController, animated: true, completion: nil)
        } else {
            // TODO
        }
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
