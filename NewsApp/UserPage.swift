//
//  UserPage.swift
//  NewsApp
//
//  Created by Sedat Yıldız on 25.09.2024.
//

import SwiftUI
import FirebaseFirestore

struct UserPage: View {
    @AppStorage("Email") var email:String = ""
    @State var name:String = ""
    @State var surname:String = ""
    @State var date:String  = ""
    let height = UIScreen.main.bounds.height
    let width = UIScreen.main.bounds.width
    
    
    var body: some View {
        ZStack{
            ContainerRelativeShape()
                .fill(LinearGradient(colors:[Color.orange,Color.white], startPoint:.topLeading, endPoint:.bottomTrailing))
                .ignoresSafeArea()
            
            VStack(spacing: 30){
                Text("User Infos")
                    .padding()
                    .bold()
                    .foregroundStyle(Color.black)
                    .font(.title)
                
            
                HStack{
                    Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 20) {
                        GridRow {
                            Text("Name: ")
                                .bold()
                                .foregroundStyle(Color.black)
                                .font(.title2) +
                            Text(name)
                                .foregroundStyle(Color.blue)
                                .font(.title2)
                                .bold()
                        }
                        
                        GridRow {
                            Text("Surname: ")
                                .bold()
                                .foregroundStyle(Color.black)
                                .font(.title2) +
                            Text(surname)
                                .foregroundStyle(Color.blue)
                                .font(.title2)
                                .bold()
                        }
                        
                        GridRow {
                            Text("Email: ")
                                .bold()
                                .foregroundStyle(Color.black)
                                .font(.title2) +
                            Text(email)
                                .foregroundStyle(Color.blue)
                                .font(.title2)
                                .bold()
                        }
                        
                        GridRow {
                            Text("Register Date: ")
                                .bold()
                                .foregroundStyle(Color.black)
                                .font(.title2) +
                            Text(date)
                                .foregroundStyle(Color.blue)
                                .font(.title3)
                                .bold()
                        }
                    }
                    .padding()
                    Spacer()
                }


                        
                    
               
                
                Spacer()
                
                
                
            }
            
           
        }
        .onAppear(perform:{
            fetchuserinfos(Email: email)
        })
        
    }
    
    func fetchuserinfos(Email:String){
        let db  = Firestore.firestore().collection("users")
        let query = db.whereField("email", isEqualTo: Email)
        query.getDocuments{ ( querySnapshot,error) in
            if let error = error {
                print("error while getting the user information: \(error.localizedDescription)")
            }
            else {
                if let documents = querySnapshot?.documents, !documents.isEmpty {
                    let data = documents[0].data()
                    DispatchQueue.main.async {
                        name = data["name"] as? String ?? "No Name"
                        surname = data["surname"] as? String ?? "No Surname"
                        date = data["date"] as? String ?? "No data"
                        
                        
                    }
                }
                
                
                
                
                
            }
            
            
        }
        
        
    }
}

#Preview {
    UserPage()
}
