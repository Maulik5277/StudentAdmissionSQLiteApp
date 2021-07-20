//
//  NewNoticeVC.swift
//  StudentAdmissionSystemUsingSqlite
//
//  Created by DCS on 20/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NewNoticeVC: UIViewController {

    
    var notes : note?
    
    private let txttitle:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter title name"
        txt.textColor = .black
        txt.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        //txt.borderStyle = .roundedRect
        txt.font = UIFont(name : "", size : 20.0)
        txt.textAlignment = .center
        txt.layer.borderWidth = 5
        txt.layer.cornerRadius = 10
        return txt
    }()
    private let contentView:UITextView = {
        let txtView = UITextView()
        txtView.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        txtView.textColor = .black
        txtView.layer.borderWidth = 5
        txtView.layer.cornerRadius = 10
        return txtView
    }()
 
    private let mybtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        btn.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        // btn.backgroundColor = .blue
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 5
        return btn
    }()
    @objc private func saveNote()
    {
        let name = txttitle.text!
       
        let cont = contentView.text!
        
        let notice = note(nid: 0, ntitle: name, msg: cont)
        
        if let notice = notes
        {
            
            let updatenote = note(nid: notice.nid, ntitle: name, msg: cont)
            update(notes:updatenote)
            
        }
        else{
            let insertnote =  note(nid: notice.nid, ntitle: name, msg: cont)
            insert(notice: insertnote)
            
        }
        
        
    }
    
    private func insert (notice: note)
    {
        sqlitehandler.shared.ninsert(notes: notice)
        {
            [weak self] success in
            
            if success {
                
                let  alert = UIAlertController(title: "Success!", message: "insert data successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {[weak self]  _ in self?.navigationController?.popViewController(animated: true)}))
                DispatchQueue.main.async {
                    self?.present(alert,animated: true,completion: nil)
                }
            }else
            {
                let  alert = UIAlertController(title: "Warning", message: "Some issue while save data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                DispatchQueue.main.async {
                    self?.present(alert,animated: true,completion: nil)
                }
            }
            
        }
        
        
    }
    
    private func update (notes : note)
    {
        sqlitehandler.shared.nupdate(note: notes)
        {
            [weak self] success in
            
            if success {
                
                let  alert = UIAlertController(title: "Success!", message: "update data successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {[weak self]  _ in self?.navigationController?.popViewController(animated: true)
                    
                }))
                DispatchQueue.main.async {
                    self?.present(alert,animated: true,completion: nil)
                }
                
            }else
            {
                let  alert = UIAlertController(title: "Warning", message: "Some issue while save data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                DispatchQueue.main.async {
                    self?.present(alert,animated: true,completion: nil)
                }
            }
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(mybtn)
        view.addSubview(txttitle)
        view.addSubview(contentView)
        
        if let notice = notes
        {
            
            txttitle.text = notice.ntitle
           
            contentView.text = notice.msg
            
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        txttitle.frame = CGRect(x: 40, y: view.safeAreaInsets.top + 20, width: view.width - 80, height: 40)
        contentView.frame = CGRect(x: 40, y: txttitle.bottom + 20, width: view.width - 80, height: 400)
        mybtn.frame = CGRect (x: 40, y: contentView.bottom + 20, width: view.width - 80, height: 40)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
