//
//  CoreData.swift
//  News
//
//  Created by Kemal Cegin on 15.01.2023.
//

import UIKit
import CoreData

class CoreData {
    
    static let sharedInstance = CoreData()
    private init(){}
    
    
    private let fetchRequest = NSFetchRequest<NewsEntity>(entityName: "NewsEntity")
    
    
    private func getManagedContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }

    
    func deleteSelectedArticle(news: News) {
        guard let managedContext = getManagedContext() else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsEntity")
        fetchRequest.predicate = NSPredicate(format: "titleC == %@", news.title!)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(batchDeleteRequest)
            try managedContext.save()
        } catch {
            print("Deleting error \(error)")
        }
    }
    

    func isSaved(news: News) -> Bool {
        let savedArticles = CoreData.sharedInstance.fetchDataFromCoreData()
        for savedArticle in savedArticles {
            if savedArticle.title == news.title {
                return true
            }
        }
        return false
    }


    func saveData(news: News) {
        guard let managedContext = getManagedContext() else { return }

        let newsEntity = NewsEntity(context: managedContext)
        newsEntity.titleC = news.title
        newsEntity.urlToImage = news.urlToImage
        newsEntity.descriptionC = news.description
        newsEntity.dateC        = news.publishedAt
        do {
            try managedContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    
    func fetchDataFromCoreData() -> [News] {
        var newsArray: [News] = []
        guard let managedContext = getManagedContext() else { return [] }
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NewsEntity] {
                let title = data.titleC
                let description = data.descriptionC
                let urlToImage = data.urlToImage
                let publishedAt = data.dateC
                
                let news = News(author: nil, title: title, description: description, url: nil, urlToImage: urlToImage, content: nil, publishedAt: publishedAt, category: nil)
                newsArray.append(news)
            }
        } catch {
            print("Failed")
        }
        return newsArray
    }

}

