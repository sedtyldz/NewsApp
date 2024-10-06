//
//  ContentView.swift
//  NewsApp
//
//  Created by Sedat Yıldız on 11.09.2024.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @AppStorage("Email") var email:String = ""
    @AppStorage("islogin") var islogin:Bool = false
    @State var password:String = ""
    @State var alertmessage:String = ""
    @State var durum:Bool = false
    @State var login:Bool = false
    @State var sign:Bool = false
    
    var body: some View {
        NavigationStack {
        ZStack{
            ContainerRelativeShape()
                .fill(LinearGradient(colors: [Color.orange,Color.white], startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            
            VStack (spacing:40){
                Text("Haberkoliks")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.purple)
                Image("reading")
                    .resizable()
                    .frame(width:200,height: 200)
                    .imageScale(.large)
                
                
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
                    .onChange(of: email) { newValue in
                        alertmessage = ""
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
                    .onChange(of: email) { newValue in
                        alertmessage = ""
                    }
                
            
                Spacer()
                    .frame(height:30)
                
                HStack(spacing:30){
                    Button(action:{
                        sign = true
                    }){
                        Text("New User")
                            .bold()
                            .foregroundColor(.white)
                            .font(.title)
                            .frame(width: 150,height: 50)
                            .background(Color.red)
                            .cornerRadius(30)
                    }
                    
                    Button(action:{
                        
                        login(email: email, password: password)
                        
                        
                    }){
                        Text("Login")
                            .bold()
                            .foregroundColor(.white)
                            .font(.title)
                            .frame(width: 150,height: 50)
                            .background(Color.green)
                            .cornerRadius(30)
                        
                        
                        
                    }
                }
                .navigationDestination(isPresented: $login) {
                    MainPage()
                }
                .navigationDestination(isPresented: $sign) {
                    NewUserPage()
                }
                
                
                Spacer()
                
                if durum{
                    Text(alertmessage)
                        .bold()
                        .foregroundColor(.red)
                        .font(.title3)
                }
                
                
                
                
            }
            .navigationBarBackButtonHidden(true)
            .preferredColorScheme(.light)
            .padding()
            
            
        }
            
        
        }
        
        
    }
    
    
    // if everything is fine connecting firebase to allow user login
    func enter(email:String,password:String){
        Auth.auth().signIn(withEmail: email, password: password){ result,error in
            if error != nil {
                self.alertmessage = error!.localizedDescription
                self.durum  = true
            }
            else{
               
                self.login = true
                islogin = true
            }
            
        }
    }
    
    
    
    // check if its empty or nah
    func login(email:String,password:String){
        var message = ""
        
        if email.isEmpty || password.isEmpty{
            self.alertmessage = "Check Your Infos something is wrong"
           
        }
        else{
            enter(email: email, password: password)
            
        }
        
       
    }
}

#Preview {
    ContentView()
}
