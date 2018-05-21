//
//  NoteTableViewDelegate.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/19.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import Foundation

protocol NoteTableViewDelegate {
    func reload();
    func refreshRow(row: Int);
}
