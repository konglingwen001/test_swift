//
//  MyZoneViewController.swift
//  test_swift:test
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
        return notesModel!.getGuitarNotesFileNum()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = notesModel!.getGuitarNotesFileName(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
