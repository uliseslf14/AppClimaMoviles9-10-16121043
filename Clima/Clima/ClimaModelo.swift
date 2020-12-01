//
//  ClimaModelo.swift
//  Clima
//
//  Created by Mac19 on 19/11/20.
//  Copyright © 2020 Mac19. All rights reserved.
//

import Foundation
struct ClimaModelo {
    let condicionID: Int
    let nombreCiudad: String
    let descripcionClima: String
    let temperaturaCelcius: Double
    let temperaturaMinima: Double
    let temperaturaMaxima: Double
    let humedad: Int
    let velocidad: Double
    
    var condicionClima : String{
        switch  condicionID {
        case 200...232:
            return "thunderstorm.jpg"
        case 700...781:
            return "cloudy.jpg"
        case 800:
            return "sunny.jpg"
        default:
            return "rainy.jpg"
        }
    }
    var temperaturaDecimal : String{
        return String(format: "%.1f", temperaturaCelcius)
    }
    var minimaDecimal : String{
        return String(format: "%.1f", temperaturaMinima)
    }
    var maximaDecimal : String{
        return String(format: "%.1f", temperaturaMaxima)
    }
    var velocidadDecimal : String{
        return String(format: "%.1f", velocidad)
    }

}
