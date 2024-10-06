//
//  NewsPage.swift
//  NewsApp
//
//  Created by Sedat Yıldız on 25.09.2024.
//

import SwiftUI
import Foundation
import WebKit

struct All: Codable {
    let status: String
    let articles: [Article]
    let totalResults: Int
}

struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}

struct Article: Codable, Identifiable {
    let id = UUID() // To conform to Identifiable
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    var urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String
}

struct NewsPage: View {
    @State var newlist: [Article] = []
    @State private var selectedNewsURL: IdentifiableURL? = nil

    var body: some View {
        
        VStack {
            
            Text("LAST NEWS")
                .font(.title)
                .bold()
                .foregroundStyle(Color.green)
                
            List {
                ForEach(newlist) { new in
                    Button(action:{
                        if let url = URL(string: new.url) {
                            selectedNewsURL = IdentifiableURL(url: url)
                            }
                        
                    }){
                        VStack(alignment: .leading) {
                            
                            if var image = new.urlToImage {
                                
                                AsyncImage(url: URL(string:image)){ result in
                                    result.image?.resizable()
                                    .frame(width:300,height:150)
                                }
                                    
                                }
                            Text(new.title)
                                .font(.headline)
                                .bold()
                            Text(new.description ?? "Açıklama bilgisi eklenmemiş")
                                .foregroundColor(.blue)
                            Text(new.publishedAt)
                                .font(.caption)
                                .foregroundColor(.blue)
                            Text(new.author ?? "Yazar bilgisi eklenmemiş")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        .padding()
                    }
                   
                }
                
            }
            .sheet(item: $selectedNewsURL) { identifiableURL in
                            WebView(url: identifiableURL.url) // Use the wrapped URL
                        }
            .onAppear {
                fetchData()
            }
        }
    }
    
    
        func fetchData() {
            let UrlString:String  = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(YourAPIKey)"
            
            // create a URL type value
            guard let  url = URL(string: UrlString) else {
                print("error while trying to create url")
                return
            }
            
            
            // bir URl veri tipi bekler String gönderdik hata aldık
            let task = URLSession.shared.dataTask(with: url) { data,response,error in
                if let error = error {
                    print("error while trying to get data")
                }
                else if let data = data {
                    print("We get data succesfully\(data)")
                    
                    // veriyi Parse edip ekranda göstermeliyiz
                    do{
                        let parseddata = try JSONDecoder().decode(All.self, from:data)
                        
                        DispatchQueue.main.async {
                            self.newlist = parseddata.articles
                        }
                    }
                    catch{
                        print("Error while trying to parse the data")
                    }
                    
                }
                
            }
            task.resume()
            
        
            
        }
        
    }


struct WebView: UIViewRepresentable {
    let url:URL
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}


#Preview {
    NewsPage()
}
