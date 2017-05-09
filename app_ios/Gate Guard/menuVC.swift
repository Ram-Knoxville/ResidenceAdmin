//
//  menuVC.swift
//  Gate Guard
//
//  Created by Ram on 2/25/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
//new comment
class menuVC: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var expandedSections : NSMutableSet = []
    
    var sectionData = ["Inicio",/* "Administración de Sistema", "Nuestra Colonia",*/ "Mi Casa"/*, "Control de Acceso", "Reportes", "Configuración de Colonia"*/]
    var row1 = ["Home"]
    var row2 = ["Usuarios", "Colonias", "Guardias", "Perfiles", "Servicios"]
    var row3 = ["Ingresos", "Gastos", "Facturas", "Encuestas y Votaciones", "Notificaciones", "Configuración", "Quejas y Sugerencias", "Monitoreo Paneles de Alarma"]
    var row4  = [/*"Streaming", "AR","Ubicación"*/"Invitados","Invitaciones", "Paneles de Alarma", /*"Servidores de Video",*/ "Usuarios de Residencia", "Mis Vehículos", "Telemetría", "Eventos de Alarma"/*, "Registro de Accesos"*/]
    var row5  = ["Monitor de Acceso", "Registro de Visitas (Vehiculos)", "Registro de Visitas (Peatones)"]
    var row6  = ["Reporte de Accesos"]
    var row7  = ["Residencias", "Grupo de Residencias", "Usuarios del Sistema", "Control de Asistencia"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
    }
    
    func sectionTapped(_ sender: UIButton) {
        //print("section Tapped")
        let section = sender.tag
        let shouldExpand = !expandedSections.contains(section)
        if (shouldExpand) {
            expandedSections.removeAllObjects()
            expandedSections.add(section)
        } else {
            expandedSections.removeAllObjects()
            
            
        }
        self.tableView.reloadData()
    }
}

extension menuVC: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: 300, height: 28))
        
        let headerTitle = UILabel.init(frame: CGRect(x: 38, y: 4, width: 250, height: 28))
        headerTitle.text = sectionData[section]
        headerTitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let tappedSection = UIButton.init(frame: CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: headerView.frame.size.height))
        tappedSection.addTarget(self, action: #selector(sectionTapped), for: .touchUpInside)
        tappedSection.tag = section
        
        
        headerView.addSubview(headerTitle)
        headerView.addSubview(tappedSection)
        headerView.backgroundColor = #colorLiteral(red: 0.1735826195, green: 0.4581983656, blue: 0.7233663201, alpha: 1)
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(expandedSections.contains(section)) {
            switch section {
            case 0:
                return row1.count
            case 1:
                return row4.count
            /*case 2:
                return row4.count
            case 3:
                return row4.count
            case 4:
                return row5.count
            case 5:
                return row6.count
            case 6:
                return row7.count*/
            default:
                return 0
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        switch indexPath.section {
        case 0:
            cell?.textLabel?.text = row1[indexPath.row]
        case 1:
            cell?.textLabel?.text = row4[indexPath.row]
        /*case 2:
            cell?.textLabel?.text = row4[indexPath.row]
        case 3:
            cell?.textLabel?.text = row4[indexPath.row]
        case 4:
            cell?.textLabel?.text = row5[indexPath.row]
        case 5:
            cell?.textLabel?.text = row6[indexPath.row]
        case 6:
            cell?.textLabel?.text = row7[indexPath.row]*/
        default:
            cell?.textLabel?.text = row3[indexPath.row]
        }
        
        cell?.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell?.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                performSegue(withIdentifier: "menuAInicio", sender: nil)
            }
        case 1:
            if indexPath.row == 0 {
                performSegue(withIdentifier: "menuAInvitados", sender: nil)
            }else if indexPath.row == 1 {
                performSegue(withIdentifier: "menuAInvitaciones", sender: nil)
            }else if indexPath.row == 2 {
                performSegue(withIdentifier: "menuAPanelesDeAlarma", sender: nil)
            }else if indexPath.row == 3 {
                performSegue(withIdentifier: "menuAUsuarios", sender: nil)
            }else if indexPath.row == 4 {
                performSegue(withIdentifier: "menuAVehiculos", sender: nil)
            }else if indexPath.row == 5{
                performSegue(withIdentifier: "menuATelemetria", sender: nil)
            }else if indexPath.row == 6 {
                performSegue(withIdentifier: "menuAEventosAlarma", sender: nil)
            }else if indexPath.row == 7 {
                performSegue(withIdentifier: "menuToAccessRegistry", sender: nil)
            }
            
        /*case 2:
            cell?.textLabel?.text = row3[indexPath.row]
        case 1:
            if indexPath.row == 0 {
                performSegue(withIdentifier: "menuAUsuarios", sender: nil)
            }else if indexPath.row == 1 {
                performSegue(withIdentifier: "menuAColonias", sender: nil)
            }else if indexPath.row == 2 {
                performSegue(withIdentifier: "menuAGuardias", sender: nil)
            }
            else if indexPath.row == 3 {
                performSegue(withIdentifier: "menuAPerfiles", sender: nil)
            }else if indexPath.row == 4 {
                performSegue(withIdentifier: "menuAServicios", sender: nil)
            }
        case 1:
            cell?.textLabel?.text = row3[indexPath.row]
        case 2:
            if indexPath.row == 0 {
                performSegue(withIdentifier: "menuAStreaming", sender: nil)
            }else if indexPath.row == 1 {
                performSegue(withIdentifier: "menuAARVC", sender: nil)
            }else if indexPath.row == 2 {
                performSegue(withIdentifier: "menuAPanelesDeAlarma", sender: nil)
            }else if indexPath.row == 5 {
                performSegue(withIdentifier: "menuATelemetria", sender: nil)
            }
        case 3:
            cell?.textLabel?.text = row5[indexPath.row]
        case 4:
            cell?.textLabel?.text = row6[indexPath.row]
        case 5:
            cell?.textLabel?.text = row7[indexPath.row]*/
        default:
            cell?.textLabel?.text = row3[indexPath.row]
        }

    }
}
