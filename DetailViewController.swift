//
//  DetailViewController.swift
//  WLBapp
//
//  Created by 나윤서 on 2021/02/14.
//

import UIKit

class DetailViewController: UIViewController {
    // Outlet Definition //
    @IBOutlet var lblMonText: UILabel!
    @IBOutlet var lblTueText: UILabel!
    @IBOutlet var lblWedText: UILabel!
    @IBOutlet var lblThrText: UILabel!
    @IBOutlet var lblFriText: UILabel!
    @IBOutlet var lblSatText: UILabel!
    @IBOutlet var lblSunText: UILabel!
    
    @IBOutlet var lblMonCommuteTime: UILabel!
    @IBOutlet var lblTueCommuteTime: UILabel!
    @IBOutlet var lblWedCommuteTime: UILabel!
    @IBOutlet var lblThrCommuteTime: UILabel!
    @IBOutlet var lblFriCommuteTime: UILabel!
    @IBOutlet var lblSatCommuteTime: UILabel!
    @IBOutlet var lblSunCommuteTime: UILabel!
    
    @IBOutlet var lblMonOffWorkTime: UILabel!
    @IBOutlet var lblTueOffWorkTime: UILabel!
    @IBOutlet var lblWedOffWorkTime: UILabel!
    @IBOutlet var lblThrOffWorkTime: UILabel!
    @IBOutlet var lblFriOffWorkTime: UILabel!
    @IBOutlet var lblSatOffWorkTime: UILabel!
    @IBOutlet var lblSunOffWorkTime: UILabel!
    
    @IBOutlet var lblMonNotWorkTime: UILabel!
    @IBOutlet var lblTueNotWorkTime: UILabel!
    @IBOutlet var lblWedNotWorkTime: UILabel!
    @IBOutlet var lblThrNotWorkTime: UILabel!
    @IBOutlet var lblFriNotWorkTime: UILabel!
    @IBOutlet var lblSatNotWorkTime: UILabel!
    @IBOutlet var lblSunNotWorkTime: UILabel!
    
    // Variable Definition
    var weekTextList: [UILabel] = []
    var weekCommuteList: [UILabel] = []
    var weekOffWorkList: [UILabel] = []
    var weekNotWorkList: [UILabel] = []
    var weekDayNumber: Int = 0      // 0 : Mon,  1 : Tue,  2 : Web,  3 : Thr,  4 : Fri,  5 : Sat,  6 : Sun
    let viewcontroller = ViewController()
    var datecomponent = DateComponents()
    let historySelector: Selector = #selector(updateHistory)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // View Configuration
        view.backgroundColor = UIColor.darkGray
        
        // Initialization
        weekTextList = [lblMonText, lblTueText, lblWedText, lblThrText, lblFriText, lblSatText, lblSunText]
        weekCommuteList = [lblMonCommuteTime, lblTueCommuteTime, lblWedCommuteTime, lblThrCommuteTime, lblFriCommuteTime, lblSatCommuteTime, lblSunCommuteTime]
        weekOffWorkList = [lblMonOffWorkTime, lblTueOffWorkTime, lblWedOffWorkTime, lblThrOffWorkTime, lblFriOffWorkTime, lblSatOffWorkTime, lblSunOffWorkTime]
        weekNotWorkList = [lblMonNotWorkTime, lblTueNotWorkTime, lblWedNotWorkTime, lblThrNotWorkTime, lblFriNotWorkTime, lblSatNotWorkTime, lblSunNotWorkTime]
        
        datecomponent = Calendar.current.dateComponents([.year, .month, .weekOfMonth, .day , .weekday, .hour, .minute, .second], from: Date())
        weekDayNumber = ((datecomponent.weekday ?? 0) + 5) % 7
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: historySelector, userInfo: nil, repeats: true)
    }
    
    func showDetailWokredListOfWeek() {
        for i in 0...weekDayNumber {
            // 일주일 Date를 불러오는 API 생성 필요.. 후에 수정해야할 부분
            let myDateComponents = DateComponents(year: 2021, month: 2, day: (datecomponent.day ?? 0) - weekDayNumber + i)
            let myDate = Calendar.current.date(from: myDateComponents)!
            let workedTime = WorkedListDB.readWorkedItem(id: myDate) ?? WorkedItem("--:--", commute: "--:--", offWork: "--:--", rest: 0.0, realWorkedTime: 0.0, workedTime: 0.0, weekDay: 0, dayWorkStatus: 0, spareTimeToWork: 0.0)
            weekCommuteList[i].text = workedTime.commute
            weekOffWorkList[i].text = workedTime.offWork
            weekNotWorkList[i].text = String(format: "%02d:%02d", Int(workedTime.rest/3600), Int(workedTime.rest/60) % 60)
//            print("rest = \(workedTime.rest) hour = \((workedTime.rest)/3600) min = \((workedTime.rest)/60)")
        }
        for j in weekDayNumber+1..<7 {
            weekCommuteList[j].text = "--:--"
            weekOffWorkList[j].text = "--:--"
            weekNotWorkList[j].text = "--:--"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditFromMon" {
            let vc = segue.destination as! EditDetailViewController
            vc.fromWhat = "Mon"
        } else if segue.identifier == "EditFromTue" {
            let vc = segue.destination as! EditDetailViewController
            vc.fromWhat = "Tue"
        } else if segue.identifier == "EditFromWed" {
            let vc = segue.destination as! EditDetailViewController
            vc.fromWhat = "Wed"
        } else if segue.identifier == "EditFromThr" {
            let vc = segue.destination as! EditDetailViewController
            vc.fromWhat = "Thr"
        } else if segue.identifier == "EditFromFri" {
            let vc = segue.destination as! EditDetailViewController
            vc.fromWhat = "Fri"
        } else if segue.identifier == "EditFromSat" {
            let vc = segue.destination as! EditDetailViewController
            vc.fromWhat = "Sat"
        } else if segue.identifier == "EditFromSun" {
            let vc = segue.destination as! EditDetailViewController
            vc.fromWhat = "Sun"
        }
        
    }
    
    
    
    
    @objc func updateHistory() {
        showDetailWokredListOfWeek()
    }


}
