//
//  AddPetViewController.swift
//  TaskPetAPI
//
//  Created by Feras Alshadad on 04/03/2024.
//

import UIKit
import SwiftUI
import Eureka

class AddPetViewController: FormViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupForm()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(submitTapped))
        
    }
    
    
    private func setupForm() {
        form +++ Section("Add New Pet")
        <<< TextRow() { row in
            row.title = "Name"
            row.placeholder = "Enter Name"
            row.tag = "\(Tags.name)"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            
            row.cellUpdate{ cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< URLRow() { row in
            row.title = "Image"
            row.placeholder = "Enter the image URL"
            row.tag = "\(Tags.image)"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            
            row.cellUpdate{ cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< IntRow(){ row in
            row.title = "Age"
            row.placeholder = "Enter Age"
            row.tag = "\(Tags.age)"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            
            row.cellUpdate{ cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< TextRow(){ row in
            row.title = "Gender"
            row.placeholder = "Enter Gender"
            row.tag = "\(Tags.gender)"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            
            row.cellUpdate{ cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        
    }
    
    @objc func submitTapped(){
        
        let errors = form.validate()
        
        guard errors.isEmpty else{
            print("Go back and fill it again 🗿")
            print(errors)
            presentAlertWithTitle(title: "🚨", message: "Missing Fields")
            return
        }
        
        
        let nameRow: TextRow? = form.rowBy(tag: "\(Tags.name)")
        let imageUrlRow: URLRow? = form.rowBy(tag: "\(Tags.image)")
        let ageRow: IntRow? = form.rowBy(tag: "\(Tags.age)")
        let genderRow: TextRow? = form.rowBy(tag: "\(Tags.gender)")
        
        
        let name = nameRow?.value ?? ""
        let imageUrl = imageUrlRow?.value?.absoluteString ?? ""
        let age = ageRow?.value ?? 00
        let gender = genderRow?.value ?? ""
        
        let pet = Pet(id: nil, name: name, adopted: true, image: imageUrl, age: age, gender: gender)
        
        NetworkManager.shared.addPet(pet: pet) { success in
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                   print("Error Message 321")
                }
            }
            
        }
  }
    
    
    private func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    
}
