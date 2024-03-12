//
//  ViewController.swift
//  TaskPetAPI
//
//  Created by Feras Alshadad on 04/03/2024.
//

import UIKit
import SnapKit

class PetTableViewController: UITableViewController {
    
    var pets: [Pet] = []
    
    private func fetchPetsData() {
        NetworkManager.shared.fetchPets { fetchedPets in
            DispatchQueue.main.async {
                self.pets = fetchedPets ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        fetchPetsData()
        setupNav()
        setupNavigationBar()
        
        title = "Pets"
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pet = pets[indexPath.row]
        cell.textLabel?.text = pet.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

            let detailVC = PetDetailsViewController()

            let selectedPet = pets[indexPath.row]
            detailVC.pet = selectedPet

            navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func setupNav(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
    }
    
    private func setupNavigationBar() {
           navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPetSelected))
       }
    
    @objc private func addPetSelected() {
            let navigationController = UINavigationController(rootViewController: AddPetViewController())
            present(navigationController, animated: true, completion: nil)
        }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let petToDelete = pets[indexPath.row]
            
            NetworkManager.shared.deletePet(petID: petToDelete.id!)
            {[weak self] success in
                DispatchQueue.main.async {
                    if success {
                        self?.pets.remove(at: indexPath.row)
                        
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                
                }
                
            }
        }
    }

}

