//
//  BeerViewModel.swift
//  GoalBeer
//
//  Created by Elvis Reyes on 15/5/22.
//

import Foundation
import Moya
import Combine


final class BeerViewModel: ObservableObject {
    
    @Published var beers: [BeerModel] = []
    
    @Published var searchFood: String = ""
    @Published var notResults: Bool = false
    
    // MARK: filters vars
    @Published var brewedBeforeDate:Date = Date()
    @Published var brewedAfterDate:Date = Date()
    @Published var abvGtCounter: Float = 1.0
    @Published var abvLtCounter: Float = 1.0
    @Published var ibuGtCounter: Int = 1
    @Published var ibuLtCounter: Int = 1
    
    @Published var abvFilterActive = false
    @Published var ibuFilterActive = false
    @Published var brewedFilterActive = false
    @Published var countFiltersActives = 0
    
    
    
    @Published var isFiltered:Bool = false
    
    
    
    private var hasMoreLoad: Bool = true
    private var isLoadingRequest: Bool = false
    private var beersParams:[String:Any] = [
        "per_page": 10,
        "page": 1
    ]
    
    
    var searchCancellable: AnyCancellable? = nil
    
    init() {
        searchCancellable = $searchFood
            .removeDuplicates()
            .debounce(for: 0, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == ""{
                    self.beersParams.removeValue(forKey: "food")
                }
                self.restartPagination()
                self.getBeers()
            })
    }
    
    func restartPagination() {
        beersParams["page"] = 1
        beers = []
        hasMoreLoad = true
        notResults = false
    }
    
    //MARK: - PAGINATION LOGIC
    func loadMoreContent(currentItem item: BeerModel){
        let thresholdIndex = self.beers.index(self.beers.endIndex, offsetBy: -1)
        guard let itemindex = self.beers.firstIndex(where: {$0.id == item.id }) else {
            return
        }
        
        if thresholdIndex == itemindex, hasMoreLoad {
            
            if let page = beersParams["page"]{
                beersParams["page"] = (page as? Int ?? 0) + 1
            }
            
            if !isLoadingRequest {
                print("Cargando mas bears \(beersParams)")
                getBeers()
            }
            
        }
    }
    
    //MARK: - Api request beers
    func getBeers() {
        if searchFood != ""{
            beersParams["food"] = searchFood
        }else{
            
        }
        
        isLoadingRequest = true
        
        
        print("[params] \(beersParams)")
        beerProvider.request(.beers(parameters: beersParams)) { result in
            self.isLoadingRequest = false
            switch result {
            case .success(let response):
                do {
                    
                    let results = try JSONDecoder().decode([BeerModel].self, from: response.data)
                    
                    if results.isEmpty {
                        self.hasMoreLoad = false
                        self.notResults = true
                        self.beers = []
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.beers.append(contentsOf: results)
                    }
                } catch let err {
                    print("ERROR \(err)")
                }
            case .failure(let error):
                print("Error principal \(error)")
            }
            
        }
    }
    
    //MARK: Apply filter
    func appyFilters(){
        
        if brewedFilterActive {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-yyyy"
            beersParams["brewed_before"] = dateFormatter.string(from:brewedBeforeDate)
            beersParams["brewed_after"] = dateFormatter.string(from:brewedAfterDate)
        }
        
        if abvFilterActive {
            beersParams["abv_gt"] = abvGtCounter
            beersParams["abv_lt"] = abvLtCounter
        }
        
        if ibuFilterActive {
            beersParams["ibu_gt"] = ibuGtCounter
            beersParams["ibu_lt"] = ibuLtCounter
        }
        
        if brewedFilterActive || abvFilterActive || ibuFilterActive {
            isFiltered = true
            getBeers()
        }
        
        
    }
    
    //MARK: Reset filter
    func resetFilters(){
        beersParams.removeValue(forKey: "brewed_before")
        beersParams.removeValue(forKey: "brewed_after")
        beersParams.removeValue(forKey: "abv_gt")
        beersParams.removeValue(forKey: "abv_lt")
        beersParams.removeValue(forKey: "ibu_gt")
        beersParams.removeValue(forKey: "ibu_lt")
        
        abvFilterActive = false
        ibuFilterActive = false
        brewedFilterActive = false
        
        brewedBeforeDate = Date()
        brewedAfterDate = Date()
        abvGtCounter = 1.0
        abvLtCounter = 1.0
        ibuGtCounter = 1
        ibuLtCounter = 1
        isFiltered = false
        
        restartPagination()
        getBeers()
    }
}
