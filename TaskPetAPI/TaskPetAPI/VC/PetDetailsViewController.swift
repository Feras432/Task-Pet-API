//
//  PetDetailsViewController.swift
//  TaskPetAPI
//
//  Created by Feras Alshadad on 04/03/2024.
//

import UIKit
import SnapKit
import Kingfisher
import Alamofire

class PetDetailsViewController: UIViewController {

    var pet: Pet?

    let idLabelView = UILabel()
    let nameLabelView = UILabel()
    let adoptedLabelView = UILabel()
    let imageLabelView = UIImageView()
    let ageLabelView = UILabel()
    let genderLabelView = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        
        view.addSubview(idLabelView)
        view.addSubview(nameLabelView)
        view.addSubview(adoptedLabelView)
        view.addSubview(imageLabelView)
        view.addSubview(ageLabelView)
        view.addSubview(genderLabelView)
        
        setupUI()
        setupConstraints()
        
        title = "Pet Details"
    }
    
    func setupUI(){
        
        imageLabelView.kf.setImage(with: URL(string: pet?.image ?? "no image"))
        imageLabelView.contentMode = .scaleToFill
        
        idLabelView.text = "\(pet?.id ?? 00)"
        
        nameLabelView.text = pet?.name
        
        adoptedLabelView.text = "\(pet?.adopted ?? false)"
        
        ageLabelView.text = "\(pet?.age ?? 00)"
        
        genderLabelView.text = pet?.gender
        
        
        

    }
    
    func setupConstraints(){
        
        imageLabelView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        nameLabelView.snp.makeConstraints { make in
            make.top.equalTo(imageLabelView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            
        }
        
        idLabelView.snp.makeConstraints { make in
            make.top.equalTo(nameLabelView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()

        }
        
        adoptedLabelView.snp.makeConstraints { make in
            make.top.equalTo(idLabelView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()

        }
        
        ageLabelView.snp.makeConstraints { make in
            make.top.equalTo(adoptedLabelView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()

        }
        
        genderLabelView.snp.makeConstraints { make in
            make.top.equalTo(ageLabelView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()

        }
        
    }
   

}
