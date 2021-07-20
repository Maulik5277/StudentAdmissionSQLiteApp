//
//  LoginVc.swift
//  FileManager-UseDefauls
//
//  Created by DCS on 20/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class LoginVc: UIViewController {
    
    private var studarray = [student]()
    
    private let bgimage: UIImageView = {
        let bgimage = UIImageView()
        bgimage.image = UIImage(named: "login")
        return bgimage
    }()
    private let usertxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter userid "
        txt.textColor = .black
        txt.text = ""
        //txt.backgroundColor = .gray
        txt.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        //txt.autocorrectionType = .
        txt.autocapitalizationType = .none
       // txt.borderStyle = .roundedRect
        txt.textAlignment = .center
        //txt.borderStyle = .roundedRect
        txt.layer.borderWidth = 5
        txt.layer.cornerRadius = 27
        
        return txt
    }()
    private let pswdtxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter password "
        txt.textColor = .black
        txt.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        txt.isSecureTextEntry = true
        txt.text = ""
        //txt.autocorrectionType = .
        txt.autocapitalizationType = .none
        //txt.borderStyle = .roundedRect
        txt.textAlignment = .center
       // txt.borderStyle = .roundedRect
        txt.layer.borderWidth = 5
        txt.layer.cornerRadius = 27
        
        return txt
    }()
    
    private let mybtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderWidth = 5
        btn.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        btn.addTarget(self, action: #selector(loginfunc), for: .touchUpInside)
        //btn.backgroundColor = .green
        btn.layer.cornerRadius = 27
        
        return btn
    }()
    @objc private func loginfunc(){
        if usertxt.text == "admin" && pswdtxt.text == "admin"
        {
            /* let vc = ViewController()
             navigationController?.pushViewController(vc, animated: true)
             */
            let vc = ViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(false, animated: false)
            present(nav,animated: true)
            UserDefaults.standard.setValue("abcdefg", forKey: "adminToken")
            UserDefaults.standard.setValue(usertxt.text, forKey: "username")
            
            //self.dismiss(animated: false)
            
        }
       else
        {
            let scnt = studarray.count
            for i in 0..<scnt
            {
                if usertxt.text == studarray[i].spid && pswdtxt.text == studarray[i].password
                {
                    /*let vc = StudentVC()
                     navigationController?.pushViewController(vc, animated: true)
                     _ = StudentVC()*/
                    let vc = StudentVC()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    nav.setNavigationBarHidden(false, animated: false)
                    present(nav,animated: true)
                    
                    
                    
                    //UserDefaults.standard.setValue("qwertyuiop", forKey: "studToken")
                    UserDefaults.standard.setValue(studarray[i].spid, forKey: "username")
                    //UserDefaults.standard.setValue(studarray[i].standard, forKey: "std")
                    // UserDefaults.standard.setValue(studarray[i].studName, forKey: "name")
                    //UserDefaults.standard.setValue(studarray[i].phoneno, forKey: "phone")
                    
                    //self.dismiss(animated: true)
                    break
                }
                else if (i == scnt-1){
                    print("Else")
                    let  alert = UIAlertController(title: "Incorrect!", message: "Username and password is incorrect !", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    DispatchQueue.main.async {
                        self.present(alert,animated: false,completion : nil)
                        
                    }
                }
            }
            
            
            
        }

        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login"
        view.addSubview(bgimage)
        view.addSubview(pswdtxt)
        view.addSubview(usertxt)
        view.addSubview(mybtn)
        // Do any additional setup after loading the view.
        //view.backgroundColor = .lightGray
        studarray  = sqlitehandler.shared.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pswdtxt.text = ""
        usertxt.text = ""
        
        if UserDefaults.standard.string(forKey: "adminToken") != nil
            //("abcdefg", forKey: "adminToken"
        {
            /*let vc = ViewController()
             navigationController?.pushViewController(vc, animated: true)*/
            let vc = ViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(false, animated: true)
            present(nav,animated: true)
            
        }
        else if UserDefaults.standard.string(forKey: "studToken") != nil
            //("qwertyuiop", forKey: "studToken") != nil
        {
            /*let vc = StudentVC()
             navigationController?.pushViewController(vc, animated: true)*/
            let vc = StudentVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(false, animated: true)
            present(nav,animated: true)
            
        }
        /* else{
         print("Remain on login Screen")
         let vc = LoginVc()
         navigationController?.pushViewController(vc, animated: false)
         
         }*/
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bgimage.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 250)
        usertxt.frame = CGRect(x: 20,y: 350, width: view.width - 40, height: 50)
        pswdtxt.frame = CGRect(x: 20,y: usertxt.bottom + 20, width: view.width - 40, height: 50)
        mybtn.frame = CGRect(x: 20,y: pswdtxt.bottom + 20, width: view.width - 40, height: 50)
        
    }
    
}
