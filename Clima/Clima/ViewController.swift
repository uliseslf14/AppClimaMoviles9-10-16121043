//
//  ViewController.swift
//  Clima
//
//  Created by Mac19 on 19/11/20.
//  Copyright © 2020 Mac19. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
    var climaManager = ClimaManager()
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var climaImageView: UIImageView!
    @IBOutlet weak var minimaLAbel: UILabel!
    @IBOutlet weak var maximaLabel: UILabel!
    @IBOutlet weak var velocidadLabel: UILabel!
    @IBOutlet weak var humedadLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        climaManager.delegado = self
        buscarTextField.delegate = self
    }
    @IBAction func obtenerUbicacion(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Se obtuvo la ubicacion")
        if let ubicaciones = locations.last {
            locationManager.stopUpdatingLocation()
            let latitud = ubicaciones.coordinate.latitude
            let longitud = ubicaciones.coordinate.longitude
            climaManager.fetchClima(lat: latitud, long: longitud)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print(error.localizedDescription)
    }
    
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ciudadLabel.text = buscarTextField.text
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else{
            buscarTextField.placeholder = "Escribe una ciudad."
            return false
        }
    }
    @IBAction func BuscarButton(_ sender: UIButton) {
        ciudadLabel.text = buscarTextField.text
        climaManager.fetchClima(nombreCiudad: buscarTextField.text!)
    }
}
extension ViewController :ClimaManagerDelegate{
    func findError(wichError: Error) {
        var mensaje:String?
        DispatchQueue.main.async {
            if(wichError.localizedDescription == "The data couldn’t be read because it is missing."){
                mensaje="El nombre de la ciudad está mal escrito."
            }
            if(wichError.localizedDescription == "A server with the specified hostname could not be found."){
                mensaje="El enlace del servidor no existe o no está disponible."
            }
            let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
    }
    func actualizarClima(clima: ClimaModelo) {
        DispatchQueue.main.async{
            self.temperaturaLabel.text = String(clima.temperaturaDecimal)
            self.climaImageView.image = UIImage(named: String(clima.condicionClima))
            self.descripcionLabel.text = "Hoy tenemos: \(clima.descripcionClima)"
            self.ciudadLabel.text = String(clima.nombreCiudad)
            self.maximaLabel.text = String(clima.maximaDecimal)
            self.minimaLAbel.text = String(clima.minimaDecimal)
            self.humedadLabel.text = String(clima.humedad)
            self.velocidadLabel.text = String(clima.velocidadDecimal)
        }
    }
}

