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
    
    override func viewWillAppear(_ animated: Bool) {
        self.guitarNoteList.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func createGuitarNotes(_ sender: UIButton) {
        // TODO
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesModel!.getGuitarNotesFileNum()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = notesModel!.getGuitarNotesFileName(index: indexPath.row)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        notesModel?.setGuitarNotesWithNotesTitle(noteTitle: (tableView.cellForRow(at: indexPath)?.textLabel?.text)!)
        let guitarNoteViewController = UINavigationController(rootViewController: GuitarNoteViewController())
        
        present(guitarNoteViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        notesModel!.deleteFile(title: tableView.cellForRow(at: indexPath)!.textLabel!.text!)
        self.guitarNoteList.reloadData()
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
