//
//  AppParameters.swift
//  Fullmmersion
//
//  Created by Devel02 on 03/10/16.
//  Copyright © 2016 Ubiqstudio. All rights reserved.

import UIKit

struct Constants {
    
    struct APIParameterKey {
        static let card = "CdaCard"
        static let cardDescription = "DesDescrizione"
        static let cardHexColor = "DesColoreHEX"
        static let code = "Code"
        static let clientId = "ClientId"
        static let confirmPassword = "ConfirmPassword"
        
        static let email = "Email"
        
        static let device = "Device"
        static let deviceType = "DeviceType"
        static let deviceToken = "DeviceToken"
        static let deviceUserToken = "DeviceUserToken"
        static let deviceUID = "DeviceUID"
        
        static let facebookAccessToken = "AccessTokenFacebook"
        static let facebookID = "idFacebook"
        
        static let url = "url"
        static let user = "User"
        static let username = "Username"
        static let userToken = "UserToken"
        
        static let newPassword = "NewPassword"
        static let password = "Password"
        static let phoneNumber = "PhoneNumber"
        
        static let refreshToken = "RefreshToken"
        
        static let cdaFidelity = "cdaFedelity"
        static let sendType = "TipoDiInvio"
        static let confirmCode = "ConfirmCode"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
}

enum PhoneArea : String, CaseIterable {
    case it = "+39"
}
