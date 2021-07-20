//
//  StudentVC.swift
//  StudentAdmissionSystemUsingSqlite
//
//  Created by DCS on 20/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class StudentVC: UIViewController {

    var msgdisp = ""
    // StudentVC;
    var sid = ""
   // let sname = UserDefaults.standard.string(forKey: "name")
  //  let sclass = UserDefaults.standard.string(forKey: "std")
  //  let sphone = UserDefaults.standard.string(forKey: "phone")
    
    private var studarray = [student]()
    private var noticearray = [note]()
    /*private let stdtxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter Class"
        txt.textColor = .black
        txt.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        //  txt.borderStyle = .roundedRect
        txt.font = UIFont(name : "", size : 20.0)
        txt.textAlignment = .center
        txt.layer.borderWidth = 5
        txt.layer.cornerRadius = 10
        return txt
    }()*/
    private let namlbl : UITextField = {
        let lbl = UITextField()
        lbl.font = .systemFont(ofSize : 25)
        lbl.textColor = .black
        lbl.isEnabled = false
        lbl.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        //lbl.bor
        lbl.layer.borderWidth = 5
        lbl.layer.cornerRadius = 27
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private let userlbl : UITextField = {
        let lbl = UITextField()
        lbl.font = .systemFont(ofSize : 25)
        lbl.textColor = .black
        lbl.isEnabled = false
//        lbl.text = ""
        lbl.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        //lbl.bor
        lbl.layer.borderWidth = 5
        lbl.layer.cornerRadius = 27
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private let noticelbl :UITextView = {
        let lbl = UITextView()
        lbl.font = .systemFont(ofSize : 20)
        lbl.textColor = .black
        //lbl.isEnabled = false
        lbl.isEditable = false
      //  lbl.text = ""
        lbl.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        //lbl.bor
        lbl.layer.borderWidth = 5
        lbl.layer.cornerRadius = 27
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private let stdlbl : UITextField = {
        let lbl = UITextField()
        lbl.font = .systemFont(ofSize : 25)
        lbl.textColor = .black
       // btn.setTitleColor(.white, for: .normal)
       // lbl.layer.borderWidth = 10        //lbl.text = ""
        lbl.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        //lbl.bor
        lbl.layer.borderWidth = 5
        lbl.layer.cornerRadius = 27
        lbl.textAlignment = .center
        lbl.isEnabled = false
        return lbl
    }()

    private let phonelbl : UITextField = {
        let lbl = UITextField()
        lbl.font = .systemFont(ofSize : 20)
        lbl.textColor = .black
        lbl.isEnabled = false
        lbl.text = ""
        lbl.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        //lbl.bor
        lbl.layer.borderWidth = 5
        lbl.layer.cornerRadius = 27
        lbl.textAlignment = .center
        
        return lbl
    }()
 
    private let mybtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change Password!", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderWidth = 5
        btn.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
       // btn.layer.borderWidth = 10
        
        btn.addTarget(self, action: #selector(changepwd), for: .touchUpInside)
      //  btn.backgroundColor = .blue
        btn.layer.cornerRadius = 27
        return btn
    }()
    
    @objc private func changepwd()
    {
        
        let c = studarray.count
        for i in 0..<c
        {
            if sid == studarray[i].spid
            {
                let id = self.studarray[i].spid
                let name = self.studarray[i].studName
                let std = self.studarray[i].standard
                let phn = self.studarray[i].phoneno
                let age = self.studarray[i].age
                //let pwd = self.studarray[i].password
                
                let  alert = UIAlertController(title: "Update Password", message: "This is your password Change it If want !! ", preferredStyle: .alert)
                alert.addTextField{(tf) in
                    tf.text = "\(self.studarray[i].password)"
                    
                }
                let action = UIAlertAction(title: "Submit", style: .default){
                    (_) in
                    guard let pwd = alert.textFields?[0].text
                        else{
                            
                            return
                    }
                    
                    let stud = student(id: id, name: name, password: pwd, phone: phn, std: std, age: age)
                    sqlitehandler.shared.updatepwd(stud: stud)
                    { [weak self] success in
                        if success{
                            
                            let  alert = UIAlertController(title: "Success", message: "", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {[weak self]  _ in
                                
                                let vc = StudentVC()
                                self?.navigationController?.pushViewController(vc, animated: true)
                            }))
                            DispatchQueue.main.async {
                                self!.present(alert,animated: true,completion: nil)
                            }
                        }
                        
                        else{
                            
                            let  alert = UIAlertController(title: "Warning!", message: "Password not updated", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                            DispatchQueue.main.async {
                                self!.present(alert,animated: true,completion: nil)
                            }
                        }
                        
                    }
                    
                }
               alert.addAction(action)
                
                DispatchQueue.main.async {
                    self.present(alert,animated: false,completion: nil)
                }
                
            }
            
        }
        
    }
    
    @objc private func logoutFunc(){
        
        UserDefaults.standard.setValue(nil, forKey: "studToken")
        UserDefaults.standard.setValue(nil, forKey: "username")
        checkAuth()
    }
    
    private func checkAuth(){
        
        if let token = UserDefaults.standard.string(forKey: "studToken")
        //let name = UserDefaults.standard.string(forKey: "username")
        {
            print("token :: \(token)")
            
        }
        else
        {
            //let vc = LoginVc()
           /* let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav,animated: false)*/
            //self.navigationController?.popViewController(animated: true)
            
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            //(vc, animated: true)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Student-Profile"
        
        view.addSubview(userlbl)
        view.addSubview(stdlbl)
        view.addSubview(namlbl)
        view.addSubview(phonelbl)
        view.addSubview(noticelbl)
        view.addSubview(mybtn)
        
        //view.backgroundColor = .black
        let additem2 = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(logoutFunc))
       // let additem2 = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain,  target: self, action: #selector(logoutFunc))
        
        navigationItem.setRightBarButton(additem2, animated: true)
        // Do any additional setup after loading the view.
        
        //checkAuth()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sid = UserDefaults.standard.string(forKey: "username")!
        
        
        studarray = sqlitehandler.shared.fetch()
        noticearray = sqlitehandler.shared.nfetch()
        
        let c = noticearray.count
        for i in 0..<c
        {
           msgdisp  += " | " + noticearray[i].msg
            
        }
        noticelbl.text = msgdisp
        let cnt = studarray.count
        print(cnt)
        print("userdefult",sid)
        for j in 0..<cnt
        {
            if sid == studarray[j].spid
            {
                
                namlbl.text = studarray[j].studName
                stdlbl.text = studarray[j].standard
                userlbl.text = studarray[j].spid
                phonelbl.text = studarray[j].phoneno
               // break
            }
            
        }
       /* namlbl.text = sname
        stdlbl.text = sclass
        userlbl.text = sid
        phonelbl.text = sphone
        */
        checkAuth()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userlbl.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 20, width: view.width - 40, height: 50)
        //userlbl.frame = CGRect(x: 10, y: 100, width: view.width - 40, height: 80)
        namlbl.frame = CGRect(x: 20, y: userlbl.bottom + 10, width: view.width - 40, height: 50)
        stdlbl.frame = CGRect(x: 20, y: namlbl.bottom + 10, width: view.width - 40, height: 50)
        phonelbl.frame = CGRect(x: 20, y: stdlbl.bottom + 10, width: view.width - 40, height: 50)
        noticelbl.frame = CGRect(x: 20, y: phonelbl.bottom + 10, width: view.width - 40, height: 100)
        mybtn.frame = CGRect(x: 20, y: noticelbl.bottom + 10, width: view.width - 40, height: 50)
        

        
    }
    
   
}
