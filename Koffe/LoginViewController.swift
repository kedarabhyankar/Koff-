//
//  LoginViewController.swift
//  Koffe
//
//  Created by Kedar Abhyankar on 11/11/20.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signInWithEmailButton: UIButton!
    
    var siwaButton: ASAuthorizationAppleIDButton?;
    
    func determineSIWAStyle() -> ASAuthorizationAppleIDButton.Style{
        switch(traitCollection.userInterfaceStyle){
            case .light:
                return ASAuthorizationAppleIDButton.Style.black
            case .dark:
                return ASAuthorizationAppleIDButton.Style.white
            case .unspecified:
                return ASAuthorizationAppleIDButton.Style.black
            @unknown default:
                fatalError("SIWASET_STYLE")
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if(previousTraitCollection?.userInterfaceStyle == .some(.dark)){
            //was dark, now is light
            siwaButton = ASAuthorizationAppleIDButton(type: .signUp, style: .black)
        } else if(previousTraitCollection?.userInterfaceStyle == .some(.light)){
            //was light now dark
            siwaButton = ASAuthorizationAppleIDButton(type: .signUp, style: .white)
        }
        setupSIWA()
    }
    
    func setupSIWA(){
        siwaButton!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(siwaButton!)
        NSLayoutConstraint.activate([
            siwaButton!.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 60),
            siwaButton!.leadingAnchor.constraint(equalTo: signInWithEmailButton.leadingAnchor),
            siwaButton!.trailingAnchor.constraint(equalTo: signInWithEmailButton.trailingAnchor),
            siwaButton!.heightAnchor.constraint(equalTo: signInWithEmailButton.heightAnchor),
        ])
        siwaButton!.cornerRadius = signInWithEmailButton.layer.cornerRadius;
        print("siwa height -> \(siwaButton!.frame.size.height)")
        siwaButton?.addTarget(self, action: #selector(onSIWApple), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("font size of button is \(String(describing: signInWithEmailButton.titleLabel?.font?.pointSize))")
        siwaButton = ASAuthorizationAppleIDButton(type: .signUp, style: determineSIWAStyle())
        setupSIWA();
    }
    
    @IBAction func onSIWEmail(_ sender: Any) {
    }
    
    @objc func onSIWApple(){
        
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
