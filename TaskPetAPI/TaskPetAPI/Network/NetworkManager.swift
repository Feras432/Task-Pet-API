//
//  NetworkManager.swift
//  TaskPetAPI
//
//  Created by Feras Alshadad on 04/03/2024.
//

import Foundation
import Alamofire
class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://coded-pets-api-crud.eapi.joincoded.com/pets"
    
    
    // GET Method
    func fetchPets(completion: @escaping ([Pet]?) -> Void) {
        AF.request(baseURL).responseDecodable(of: [Pet].self){ response in
            switch response.result {
            case .success(let pets):
                completion(pets)
            case .failure(let error):
                print(error)
                completion(nil)
                
            }
            
        }
        
    }
    // POST Method
    func addPet(pet: Pet, completion: @escaping (Bool) -> Void) {
        AF.request(baseURL, method: .post, parameters: pet, encoder: JSONParameterEncoder.default).response {
            response in
            switch response.result {
                case .success(_):
                    completion(true)
                case .failure(let error):
                    print(error)
                    completion(false)
            }
            
        }
        
    }
    
    //DELETE Method
    func deletePet(petID: Int, completion: @escaping (Bool) -> Void){
        AF.request("\(baseURL)/\(petID)", method: .delete).response{ response in
            
            switch response.result{
            case .success:
                completion(true)
            case .failure(let error):
                print("Error Deleting \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
}
