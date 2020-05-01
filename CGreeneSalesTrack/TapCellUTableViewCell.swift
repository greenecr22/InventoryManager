////
////  TapCellUTableViewCell.swift
////  CGreeneSalesTrack
////
////  Created by Christopher Greene on 4/27/20.
////  Copyright © 2020 Christopher Greene. All rights reserved.
////
//
//import UIKit
//
//class TapCellTableViewCell: UITableViewCell {
//
//
//    // This will hold the handler closure which the view controller provides
//    var resignationHandler: (() -> Void)?
//
//    @IBAction func handleGesture(_ recognizer: UILongPressGestureRecognizer) {
//        if recognizer.state == .changed
//        {
//            let alertController = UIAlertController(title: nil, message:
//                "Open Product in Safari", preferredStyle: .alert)
//            let indexPath = tableView.indexPathForSelectedRow
//            let itemSku = self.itemArray[indexPath?.row ?? 0].sku
//            alertController.addAction(UIAlertAction(title: "Go to Safari", style: .default,handler: { action in
//                UIApplication.shared.open(URL(string: "\(itemURL)\(itemSku ?? "")") ?? URL(string: "")!, options: [:]) { _ in
//                    print("Link opened")
//                }
//            }))
//
//            present(alertController, animated: true, completion: nil)
//        }
//
//    }
//
//    @objc private func tap(_ recognizer: UILongPressGestureRecognizer) {
//        guard recognizer.state == .ended else { return }
//        activateTitleEditing()
//    }
//}
//
//extension CustomTableViewCell: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        resignationHandler?()
//    }
//}
