//
//  Repository.swift
//  ListMovies5
//
//  Created by Bryan Andres  Almeida Flores on 30/04/2022.
//

import Foundation
import Combine
import CoreData

class Repository{

    
    lazy var context = ListMovieCore.context
    private var page = 1
    private let networkManager:NetworkManager
    private var subscribers = Set<AnyCancellable>()
    
    
    init(_ networkManager:NetworkManager){
        self.networkManager = networkManager
    }


//    func getMovieData(page:Int,_ completionHandler: @escaping (Result<[ApiMovieResponse], NetworkErrors>)->Void){
//        networkManager.getModel(.self, from: NetworkURLs.imageBaseUrl)
//            .sink{_ in} receiveValue:{ data in
//                let movieData = data.results
//                completionHandler(.success(movieData))
//            }.store(in: &subscribers)
//    }
//    func getMovieDetailsData(_ id:Int,_ completionHandler: @escaping (MovieDetail)->Void){
//        networkManager.getModel(DetailsViewController.self, from: NetworkURLs.movieDetailBase , completionHandle: completionHandler)
//    }
//    func getPosterData(from url:NetworkURLs, _ completionHandler: @escaping (Result<Data,NetworkError>)->Void){
//        networkManager.getPosterImage(url: url){ data in
//            if let data = data{
//                completionHandler(.success(data))
//            }else{
//                completionHandler(.failure(NetworkError.badURL))
//            }
//        }
//    }
//
//    func saveMovieData(user:String?,movieData:[MovieModel]){
//        if let user = user{
//            var favorIds:[Int] = movieData.filter{$0.favor ?? false}.map{$0.id}
//            guard let fetchDesc = NSEntityDescription.entity(forEntityName: "EntityFavor", in: context) else{return}
//            let fetchRequest = EntityFavor.fetchRequest()
//            do{
//                fetchRequest.predicate = NSPredicate(format:"user=%@",user)
//                let fetchResult = try context.fetch(fetchRequest)
//                for result in fetchResult{
//                    let rid = Int(result.id)
//                    if favorIds.contains(rid){
//
//                    }else{
//
//                       context.delete(result)
//                    }
//                    if let index = favorIds.firstIndex(of: rid){
//                        favorIds.remove(at: index)
//                    }
//                }
//                if favorIds.count != 0{
//                    // save id
//                    for rid in favorIds{
//                        let newFavor = Favourite(entity: fetchDesc, insertInto: context)
//                        newFavor.setValue(Int64(rid),forKey: "id")
//                        newFavor.setValue(user,forKey: "user")
//                        }
//                }
//                try context.save()
//            }catch (let error){
//                print(error.localizedDescription)
//            }
//        }
//    }
//    func updateMovieData(user:String?,movieData:inout [ApiMovieResponse]){
//        if let user = user{
//
//            let fetchRequest = Favourite.fetchRequest()
//            do{
//                for (pos,oneMovie) in movieData.enumerated(){
//                    fetchRequest.predicate = NSPredicate(format:"user=%@ && id=%d",user,oneMovie.id)
//                    let fetchResult = try context.fetch(fetchRequest)
//                    if fetchResult.count == 0{
//
//                    }else{
//                        movieData[pos].favor = true
//                    }
//                }
//                try context.save()
//            }catch (let error){
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//    func removeAllData() {
//        let request:NSFetchRequest = Favourite.fetchRequest()
//        do{
//            let posts = try context.fetch(request)
//            for post in posts{
//                context.delete(post)
//            }
//            try context.save()
//        }catch(let error){
//            print(error.localizedDescription)
//        }
    }


