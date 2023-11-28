//
//  RegistrationView.swift
//  lztrans
//
//  Created by jsw_cool on 2023/8/17.
//

import SwiftUI

struct RegistrationView: View {
    
    @State var username:String
    @State var password:String
    @State var aginPassword:String
    
    var body: some View {
        VStack {
            TextField("用户名",text:$username)
                .font(.system(size: 20,weight: .semibold))
                .padding(.horizontal)
            
            Divider()
                .padding(.horizontal)
            
            //密码
            SecureField("密码", text: $password)
                .font(.system(size: 20, weight: .semibold))
                .padding(.horizontal)
            
            Divider()
                .padding(.horizontal)
            
            SecureField("再次输入密码", text: $aginPassword)
                .font(.system(size: 20, weight: .semibold))
                .padding(.horizontal)
            
            Divider()
                .padding(.horizontal)
            
            //注册按钮
            Button(action: {

                }) {
                Text("注册")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }

        }
    }
}

