//
//  ViewController.swift
//  StudentAdmissionSystemUsingSqlite
//
//  Created by DCS on 20/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//
//admin pannel  ..................
import UIKit

class ViewController: UIViewController {

   
    private let myImg: UIImageView = {
        
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 6
        img.image = UIImage(named: "admin")
        img.clipsToBounds = true
        return img
    }()
    private let myImg1: UIImageView = {
        
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 6
        img.image = UIImage(named: "student")
        img.clipsToBounds = true
        return img
    }()
    private let myImg2: UIImageView = {
        
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 6
        img.image = UIImage(named: "notice")
        img.clipsToBounds = true
        return img
    }()
    private let mybtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Student Details", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderWidth = 5
        btn.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        btn.addTarget(self, action: #selector(studDetail), for: .touchUpInside)
        //btn.backgroundColor = .gray
        btn.layer.cornerRadius = 27
        return btn
    }()
    @objc private func studDetail(){
        let vc = StudentListVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    private let mybtn2: UIButton = {
        let btn = UIButton()
        btn.setTitle("NoticeBoard Details", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderWidth = 5
        btn.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        btn.addTarget(self, action: #selector(noticeDetail), for: .touchUpInside)
        //btn.backgroundColor = .gray
        btn.layer.cornerRadius = 27
        return btn
    }()
    @objc private func noticeDetail()
    {
        let vc = NoticeVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc private func logoutFunc(){
     
     UserDefaults.standard.setValue(nil, forKey: "adminToken")
     UserDefaults.standard.setValue(nil, forKey: "username")
     navigationController?.popViewController(animated: true)
     checkAuth()
     }
    
     private func checkAuth(){
     
     if let token = UserDefaults.standard.string(forKey: "adminToken"),
     let name = UserDefaults.standard.string(forKey: "username")
     {
     print("token :: \(name) | \(token)")
     
     }
    else
     {
            /*let vc = LoginVc()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav,animated: false)*/
        
        //navigationController?.popViewController(animated: true)
        
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Admin"
        view.addSubview(myImg)
        view.addSubview(myImg1)
        view.addSubview(myImg2)
        view.addSubview(mybtn)
        view.addSubview(mybtn2)
       // view.addSubview(mylbl)
        
        view.backgroundColor = .white
         let additem2 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(logoutFunc))
        navigationItem.setRightBarButton(additem2, animated: true)
        // Do any additional setup after loading the view.
        
        checkAuth()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
     //   mybtn.frame = CGRect(x: 20,y: pswdtxt.bottom + 20, width: view.width - 40, height: 50)
        myImg.frame = CGRect(x: 40, y: view.safeAreaInsets.top + 30, width: 300, height: 150)
        myImg1.frame = CGRect(x: 15, y: view.safeAreaInsets.top + 250, width: 100, height: 50)
        myImg2.frame = CGRect(x: 30, y: view.safeAreaInsets.top + 390, width: 60, height: 50)
        mybtn.frame = CGRect(x: 20, y: myImg.bottom + 40, width: view.width - 60, height: 100)
        mybtn2.frame = CGRect(x: 20, y: mybtn.bottom + 40, width: view.width - 60, height: 100)
        
    }

}

