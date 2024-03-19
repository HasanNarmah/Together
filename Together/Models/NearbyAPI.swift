//
//  NearbyAPI.swift
//  Together
//
//  Created by Hasan Narmah on 19/03/2024.


import SwiftSoup
import Foundation

func main() {
    scrapeConflictLocations(fromURL: "https://www.aljazeera.com/news/2023/11/27/palestine-and-israel-brief-history-maps-and-charts")
}

// Example function to scrape conflict locations from a news article URL
func scrapeConflictLocations(fromURL url: String) {
    guard let articleURL = URL(string: url) else {
        print("Invalid URL")
        return
    }
    
    do {
        let html = try String(contentsOf: articleURL)
        let document = try SwiftSoup.parse(html)
        
        // Use CSS selectors to find elements containing location information
        let locationElements = try document.select(".location")
        
        for locationElement in locationElements {
            let location = try locationElement.text()
            print("Conflict Location: \(location)")
        }
    } catch {
        print("Error scraping article: \(error)")
    }
}

// Call the main function
main()


