//
//  MainViewControllerViewModel.swift
//  Demo
//
//  Created by khawaja fahad on 30/12/2023.
//

import Foundation

class MainViewControllerViewModel {
    
    private var mostPopularService: MainViewControllerServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var results =  [ResultObject]() {
        didSet { reloadTableView?() }
    }
     
    init(mostPopularService: MainViewControllerServiceProtocol = MainViewControllerService()) {
        self.mostPopularService = mostPopularService
    }
    
    func fetchMostPopular() {
    
        mostPopularService.fetchMostPopular { [weak self] result in
            guard let self = self else { return }
            if case .success(let response) = result {
                self.results = response.results
             }
        }
    }
    
    
    func getCellViewModel(at indexPath: IndexPath) -> MostPopularTableViewCellModel {
        
        let dataObject = results[indexPath.row]
        
        var imageURLString = ""
        
        if dataObject.media.count > 0 &&  dataObject.media.first!.type == .image && dataObject.media.first!.mediaMetadata.count > 0  {
            
            let images = dataObject.media[0].mediaMetadata.filter { $0.format == .standardThumbnail }
            
            if let object =  images.first {
                imageURLString = object.url
            }
        }
                
        
        return MostPopularTableViewCellModel(title: dataObject.title, authors: dataObject.byline, date: dataObject.publishedDate, imageURLString: imageURLString)
    }
  
}
