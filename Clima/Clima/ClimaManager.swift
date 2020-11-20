//
//  ClimaManager.swift
//  Clima
//
//  Created by Mac19 on 19/11/20.
//  Copyright © 2020 Mac19. All rights reserved.
//

import Foundation
struct ClimaManager {
    let ClimaURL = "https://api.openweathermap.org/data/2.5/weather?appid=4df2edf1787113f56f83dd5ecffc512a&units=metric"
    func fetchClima(nombreCiudad : String) {
            let urlString = "\(ClimaURL)&q=\(nombreCiudad)"
        
        realizarSolicitud(urlString: urlString)
    }
    func realizarSolicitud(urlString : String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url, completionHandler: handle(data:respuesta:error:))
            tarea.resume()
        }
    }
    func handle(data : Data?, respuesta : URLResponse?, error : Error?) {
        if error != nil {
            print(error!)
            return
        }
        if let datosSeguros = data{
            let dataString = String(data: datosSeguros, encoding: .utf8)
            print(dataString!)
        }
    }
}
