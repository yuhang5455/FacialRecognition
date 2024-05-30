//
//  ViewController.swift
//  FacialRecognitionSwift
//
//  Created by 于航 on 2024/5/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let btn = UIButton()
        btn.setTitle("人脸识别", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        self.view.addSubview(btn)
        // Do any additional setup after loading the view.
    }
    @objc func btnClick() {
        let vc = FaceRecognitionViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

