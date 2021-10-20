//
//  LocalShowsDataController.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 19/10/21.
//

import CoreData

class LocalShowsDataController: LocalShowsDatabase {
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var fetchedResultsController: NSFetchedResultsController<ShowInfoDatabaseModel>?
    
    init(modelName: String = "ShowDetailDataBase") {
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    
    func saveShow(_ show: ShowInfoModel) {
        guard !showExists(show.id) else {
            return
        }
        let dataBaseShow = ShowInfoDatabaseModel(context: viewContext)
        dataBaseShow.id = Int64(show.id)
        dataBaseShow.image = show.image?.medium
        dataBaseShow.name = show.name
        dataBaseShow.summary = show.summary
        try? viewContext.save()
    }
    
    func deleteShow(_ id: Int) -> Bool {
        guard let managedObject = searchShowBy(id) else { return false }
        viewContext.delete(managedObject)
        try? viewContext.save()
        return true
    }
    
    func showExists(_ id: Int) -> Bool {
        searchShowBy(id) != nil
    }
    
    private func searchShowBy(_ id: Int) -> ShowInfoDatabaseModel? {
        let fetchRequest: NSFetchRequest<ShowInfoDatabaseModel> = ShowInfoDatabaseModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "id == '\(id)'")
        fetchRequest.fetchLimit = 1
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: viewContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: "ShowInfoDatabaseModel")
        guard let result = try? viewContext.fetch(fetchRequest)  else { return nil}
        return result.first
    }
    
    func getAllFavoriteShows() -> Result<[ShowInfoModel], Error> {
        let fetchRequest: NSFetchRequest<ShowInfoDatabaseModel> = ShowInfoDatabaseModel.fetchRequest()
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: viewContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: "ShowInfoDatabaseModel")
        return Result<[ShowInfoModel], Error> {
            let shows = try viewContext.fetch(fetchRequest)
            let result: [ShowInfoModel] = shows.compactMap { (showInfo: ShowInfoDatabaseModel) -> ShowInfoModel? in
                ShowInfoModel(id: Int(showInfo.id),
                              name: showInfo.name ?? "",
                              summary: showInfo.summary,
                              image: ImageSizes(medium: showInfo.image, original: nil))
            }
            return result
        }
    }
}
