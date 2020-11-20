//
//  ClimaManager.swift
//  Clima
//
//  Created by Mac19 on 19/11/20.
//  Copyright © 2020 Mac19. All rights reserved.
//

import Foundation
protocol ClimaManagerDelegate {
    func actualizarClima(clima: ClimaModelo)
}
struct ClimaManager {
    var delegado: ClimaManagerDelegate?
    let ClimaURL = "https://api.openweathermap.org/data/2.5/weather?appid=4df2edf1787113f56f83dd5ecffc512a&units=metric&lang=es"
    func fetchClima(nombreCiudad : String) {
            let urlString = "\(ClimaURL)&q=\(nombreCiudad)"
        
        realizarSolicitud(urlString: urlString)
    }
    func realizarSolicitud(urlString : String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            //let tarea = session.dataTask(with: url, completionHandler: handle(data:respuesta:error:))
            let tarea = session.dataTask(with: url){ (data, respuesta, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let datosSeguros = data{
                    if let clima = self.parseJSON(climaData: datosSeguros){
                        self.delegado?.actualizarClima(clima: clima)
                    }
                    
                }
            }
            tarea.resume()
        }
    }
    func parseJSON(climaData: Data) -> ClimaModelo?{
        let decoder = JSONDecoder()
        do{
            let dataDecodificada = try decoder.decode(ClimaData.self, from: climaData)
            let id = dataDecodificada.weather[0].id
            let nombre = dataDecodificada.name
            let descripcion = dataDecodificada.weather[0].description
            let temperatura = dataDecodificada.main.temp
            
            let ObjClima = ClimaModelo(condicionID: id, nombreCiudad: nombre, descripcionClima: descripcion, temperaturaCelcius: temperatura)
            return ObjClima
            
        }catch{
            print(error)
            return nil
        }
    }
}
