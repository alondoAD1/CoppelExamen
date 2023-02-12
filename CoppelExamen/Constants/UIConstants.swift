//
//  UIConstants.swift
//  CoppelExamen
//
//  Created by Ricardo Alonso Diaz Alvarado on 10/02/23.
//

struct UIConstants {
    //MARK: LOGIN
    static let UILogin_username: String = "Username"
    static let UILogin_password: String = "Password"
    static let UILogin_logIn: String = "Log In"
    static let UILogin_error: String = "Invalid username and/or password. You did not provide a valid login."
    
    //MARK: Dashboard
    static let UIDashboard_NavBar_title: String = "TV Shows"
    static let UIDashboard_Segment_title: [String] = ["Popular",
                                                      "Top Rated",
                                                      "On TV",
                                                      "Aring Today"]
    
    struct Dashboard {
        static let BottomAlert_Button_title = "What do you want to do?"
        static let BottomAlert_Button_viewProfile = "View Profile"
        static let BottomAlert_Button_logOut = "Log out"
        static let BottomAlert_Button_cancel = "Cancel"
        static let BottomAlert_Button_myFavorite = "My favourites"
        
        struct Errors {
            static let error = "- Error al obtener las peliculas"
        }
    }
    
    struct Loader {
        static let Loader_mensage = "Por favor espere..."
    }
    
    struct Profile {
        static let Title = "Profile"
        static let Section_collectionView = "Favorite Shows"
    }
    
    struct DetailMovie {
        static let Override = "Override \n\n"
        static let VoteAverage = " / 10"
    }

}
