//
//  secondCalendarVC.swift
//  Gate Guard
//
//  Created by Ram on 4/13/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import JTAppleCalendar
import SwiftKeychainWrapper

class secondCalendarVC: UIViewController {

    let formatter = DateFormatter()
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCalendarView()
    }
    
    func setupCalendarView() {
        self.calendarView.minimumLineSpacing = 0
        self.calendarView.minimumInteritemSpacing = 0
        
        self.calendarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        
        let date = visibleDates.monthDates.first!.date
        
        self.formatter.dateFormat = "yyyy"
        self.year.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        switch self.formatter.string(from: date) {
        case "January":
            self.month.text = "Enero"
        case "February":
            self.month.text = "Febrero"
        case "March":
            self.month.text = "Marzo"
        case "April":
            self.month.text = "Abril"
        case "May":
            self.month.text = "Mayo"
        case "June":
            self.month.text = "Junio"
        case "July":
            self.month.text = "Julio"
        case "August":
            self.month.text = "Agosto"
        case "September":
            self.month.text = "Septiembre"
        case "October":
            self.month.text = "Octubre"
        case "November":
            self.month.text = "Noviembre"
        case "December":
            self.month.text = "Diciembre"
        default:
            self.month.text = "Mes"
        }
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? customCell else { return }
        
        if validCell.isSelected == true {
            validCell.dateLabel.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        }else{
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else {
                validCell.dateLabel.textColor = #colorLiteral(red: 0.1516869267, green: 0.4271139008, blue: 0.6180797906, alpha: 1)
            }
        }
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? customCell else { return }
        
        if validCell.isSelected == true {
            validCell.selectedView.isHidden = false
        }else{
            validCell.selectedView.isHidden = true
        }
        
    }
}


extension secondCalendarVC: JTAppleCalendarViewDataSource {
    //Configure Calendar
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let date = Date()
        formatter.dateFormat = "yyyy MM dd"
        let actualDate = formatter.string(from: date)
        
        let startDate = formatter.date(from: actualDate)!
        let endDate = formatter.date(from: "2020 12 31")!
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
}

extension secondCalendarVC: JTAppleCalendarViewDelegate {
    
    // Display Cell
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "customCell", for: indexPath) as! customCell
        cell.dateLabel.text = cellState.text
        
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        
        return cell
    }
    
    // Actions on Selected Cell
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        let valueOfCell = date
        formatter.dateFormat = "yyyy-MM-dd"
        let dateOnly = formatter.string(from: valueOfCell)
        print("Esta es la fecha \(dateOnly)")
        defaults.set(dateOnly, forKey: "endDate")
//        KeychainWrapper.standard.set(dateOnly, forKey: "endDate")
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    //Actions when calendar scrolls
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        
        setupViewsOfCalendar(from: visibleDates)
        
    }
}
