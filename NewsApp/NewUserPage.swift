//
//  NewUserPage.swift
//  NewsApp
//
//  Created by Sedat Yıldız on 18.09.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct NewUserPage: View {
    @AppStorage("Email") var email:String = ""
    @AppStorage("islogin") var islogin:Bool = false
    @State var password:String = ""
    @State var name :String = ""
    @State var surname:String = ""
    @State var login:Bool = false
    @State var sign:Bool = false
    @State var errormessage:String = ""
    
    var body: some View {
        NavigationStack{
        ZStack{
            ContainerRelativeShape()
                .fill(LinearGradient(colors: [Color.white,Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            VStack(spacing: 30){
                Spacer()
                    .frame(height:20)
                    
                Text("Haberkoliks")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.purple)
                Image("reading")
                    .resizable()
                    .frame(width:200,height: 200)
                Spacer()
                    .frame(height:20)
                
                TextField("Name:", text: $name)
                    .font(.title)
                    .padding()
                    .bold()
                    .frame(width: 300,height: 40)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(30)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .onChange(of:name){
                        errormessage = ""
                    }
                   
                
                
                TextField("Surname:", text: $surname)
                    .font(.title)
                    .padding()
                    .bold()
                    .frame(width: 300,height: 40)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(30)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .onChange(of:surname){
                        errormessage = ""
                    }
                
                
                TextField("Email:", text: $email)
                    .font(.title)
                    .padding()
                    .bold()
                    .frame(width: 300,height: 40)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(30)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .onChange(of:email){
                        errormessage = ""
                    }
                
                
                SecureField("Password:", text: $password)
                    .font(.title)
                    .padding()
                    .bold()
                    .frame(width: 300,height: 40)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(30)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .onChange(of:password){
                        errormessage = ""
                    }
                Spacer()
                    .frame(height:20)
                HStack(spacing: 30){
                    Button(action:{
                        login  = true
                        
                    }){
                        Text("LoginPage")
                            .bold()
                            .foregroundColor(.white)
                            .font(.title)
                            .frame(width: 150,height: 50)
                            .background(Color.red)
                            .cornerRadius(30)
                    }
                    Button(action:{
                       signtheuser(name: name, surname: surname, email: email, Password: password)
                        
                    }){
                        Text("Sign Up")
                            .bold()
                            .foregroundColor(.white)
                            .font(.title)
                            .frame(width: 150,height: 50)
                            .background(Color.green)
                            .cornerRadius(30)
                    }
                    
                   
                }
                .navigationDestination(isPresented:$login){
                    ContentView()
                }
                .navigationDestination(isPresented:$sign){
                    MainPage()
                }
                
                if errormessage != ""{
                    Text(errormessage)
                        .bold()
                        .foregroundColor(.black)
                        .font(.caption2)
                }
                
                Spacer()
                
            }
            .navigationBarBackButtonHidden(true)
        }
    }
        
    }
    
    // functions
    
    
    
    
    
    
    func check(name:String,surname:String,email:String,Password:String) -> Bool {
        if name.isEmpty || surname.isEmpty || email.isEmpty || Password.isEmpty {
            return false
        }
        return true
    }
    
    
    
    func signtheuser(name:String,surname:String,email:String,Password:String){
        if check(name: name, surname: surname, email: email, Password: Password){
            Auth.auth().createUser(withEmail: email, password: Password) { result, error in
                if error != nil{
                    print("error while trying to sign")
                    self.errormessage = error!.localizedDescription
                }
                else{
                    let registerdate = Date()
                    saveuserinfos(name: name, surname: surname, email: email, password: password, registerdate: registerdate)
                    islogin = true
                    self.sign = true
                    
                }
                
            }
            
        }
        else{
            self.errormessage = "!! Please check your Infos !!"
        }
    }
    
    func saveuserinfos(name:String,surname:String,email:String,password:String,registerdate:Date){
        let db = Firestore.firestore()
        let newdocument = db.collection("users").document()
        let documentId = newdocument.documentID
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let dateStr = dateFormatter.string(from: registerdate)
        newdocument.setData([
            "id": documentId,
            "name": name,
            "surname":surname,
            "email" : email,
            "password":password,
            "date":dateStr
        ]){ err in
            if let err = err {
                print("error")
            }
            else{
                print("document added")
            }
            
        }
    }
}

#Preview {
    NewUserPage()
}
