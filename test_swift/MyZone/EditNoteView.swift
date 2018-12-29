//
//  EditNoteView.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/21.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import UIKit

class EditNoteView: UIView {
    @IBOutlet var btnMinim: UIButton!
    @IBOutlet var btnCrotcheta: UIButton!
    @IBOutlet var btnQuaver: UIButton!
    @IBOutlet var btnDemiquaver: UIButton!
    @IBOutlet var btnNum1: UIButton!
    @IBOutlet var btnNum2: UIButton!
    @IBOutlet var btnNum3: UIButton!
    @IBOutlet var btnNum4: UIButton!
    @IBOutlet var btnNum5: UIButton!
    @IBOutlet var btnNum6: UIButton!
    @IBOutlet var btnNum7: UIButton!
    @IBOutlet var btnNum8: UIButton!
    @IBOutlet var btnNum9: UIButton!
    @IBOutlet var btnNum0: UIButton!
    @IBOutlet var btnOK: UIButton!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnAddBar: UIButton!
    @IBOutlet var btnRemoveBar: UIButton!
    @IBOutlet var btnAddNote: UIButton!
    @IBOutlet var btnRemoveNote: UIButton!
    
    var notesModel: NotesModel? = nil
    var delegate: NoteTableViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        notesModel = NotesModel.getInstance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        notesModel = NotesModel.getInstance()
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        let myView: UIView = Bundle.main.loadNibNamed("EditNoteView", owner: self, options: nil)?.last as! UIView
        myView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(myView)
        
        let left = NSLayoutConstraint(item: myView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: myView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: myView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: myView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let constraints: [NSLayoutConstraint] = [left, right, top, bottom]
        self.addConstraints(constraints)
    }
    
    @IBAction func changeNoteType(_ sender: UIButton) {
        let noteType: String = "\(sender.tag)"
        let lineNo: Int = notesModel!.getCurrEditNote().lineNo
        notesModel?.changeEditNoteType(noteType: noteType)
        self.delegate!.refreshRow(row: lineNo)
    }
    
    @IBAction func addBar(_ sender: UIButton) {
        let barNo: Int = notesModel!.getCurrEditNote().barNo
        notesModel!.addBlankBarNoData(barNo: barNo)
        self.delegate!.reload()
    }
    @IBAction func removeBar(_ sender: UIButton) {
        let barNo: Int = notesModel!.getCurrEditNote().barNo
        notesModel!.removeBarNoData(barNo: barNo)
        self.delegate!.reload()
    }
    @IBAction func addNote(_ sender: UIButton) {
        let barNo: Int = notesModel!.getCurrEditNote().barNo
        let noteNo: Int = notesModel!.getCurrEditNote().noteNo
        notesModel!.addBlankNoteNoData(barNo: barNo, noteNo: noteNo)
        self.delegate!.reload()
    }
    @IBAction func removeNote(_ sender: UIButton) {
        let barNo: Int = notesModel!.getCurrEditNote().barNo
        let noteNo: Int = notesModel!.getCurrEditNote().noteNo
        notesModel!.removeNoteNoData(barNo: barNo, noteNo: noteNo)
        self.delegate!.reload()
    }
    
    @IBAction func changeFretNo(_ sender: UIButton) {
        let fretNo: Int = sender.tag
        let lineNo: Int = notesModel!.getCurrEditNote().lineNo
        notesModel!.changeEditNoteFretNo(fretNo: fretNo)
        self.delegate!.refreshRow(row: lineNo)
    }
    
    @IBAction func ok(_ sender: UIButton) {
    }
    
    @IBAction func cancel(_ sender: UIButton) {
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
