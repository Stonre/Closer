//
//  NewActivityTimeLocationViewController.swift
//  Closer
//
//  Created by Kami on 2017/2/20.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit
import MapKit

class NewActivityTimeLocationViewController: NewActivityContentViewController {
    
//    var endEditingTapGestureRecognizer: UITapGestureRecognizer?
    
    let timeTitleLabel = UILabel()
    let startTimeLabel = UILabel()
    let startTime = UITextField()
    let endTimeLabel = UILabel()
    let endTime = UITextField()
    let locationTitleLabel = UILabel()
    let locationTextField = UITextField()
    let locationSuggestTable = UITableView()
    let categoryTitleLabel = UILabel()
    let categoryTextField = UITextField()
    let tagTitleLabel = UILabel()
    let tagTextField = UITextField()
    let datePicker = UIDatePicker()
    let timeFormatter = DateFormatter()
    
    var settingStartTime = false
    var settingEndTime = false
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]() {
        didSet {
            locationSuggestions.removeAll()
            for completion in searchResults {
                let searchRequest = MKLocalSearchRequest(completion: completion)
                let search = MKLocalSearch(request: searchRequest)
                search.start(completionHandler: { (response, error) in
                    if let name = (response?.mapItems[0].name) {
                        self.locationSuggestions.append(name)
                    }
                })
            }
        }
    }
    
    var locationSuggestions = [String]() {
        didSet {
            locationSuggestTable.reloadData()
            if locationSuggestions.count > 0 {
                locationSuggestTable.isHidden = false
//                locationSuggestTable.isUserInteractionEnabled = true
//                locationTextField.resignFirstResponder()
            }
        }
    }

    
    var startDate: Date? {
        didSet {
            startTime.text = timeFormatter.string(from: startDate!)
        }
    }
    var endDate: Date? {
        didSet {
            endTime.text = timeFormatter.string(from: endDate!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentIndex = 2
        view.backgroundColor = NewActivityController.bgColor
//        endEditingTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapElseWhere))
//        endEditingTapGestureRecognizer?.cancelsTouchesInView = false
//        view.addGestureRecognizer(endEditingTapGestureRecognizer!)

        
        timeFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        setupTimeTitleLabel()
        setupStartTime()
        setupEndTime()
        setupLocationTitleLabel()
        setupLocationTextField()
        setupCategoryTitleLabel()
        setupCategoryTextField()
        setupTagTitleLabel()
        setupTagTextField()
        setupDatePicker()
        setupLocationSuggestionTable()
        
        // Do any additional setup after loading the view.
    }
    
    func tapElseWhere() {
        view.endEditing(true)
        datePicker.isHidden = true
    }
    
    private func setupTimeTitleLabel() {
        view.addSubview(timeTitleLabel)
        timeTitleLabel.backgroundColor = NewActivityController.bgColorTransparent
        timeTitleLabel.text = "任务周期："
        timeTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        timeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        timeTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    private func setupStartTime() {
        view.addSubview(startTimeLabel)
        startTimeLabel.backgroundColor = NewActivityController.bgColorTransparent
        startTimeLabel.text = "起始时间"
        startTimeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        startTimeLabel.topAnchor.constraint(equalTo: timeTitleLabel.bottomAnchor, constant: 8).isActive = true
        startTimeLabel.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 8).isActive = true
        
        view.addSubview(startTime)
        startTime.delegate = self
//        startTime.backgroundColor = .blue
//        startTime.isUserInteractionEnabled = true
        startTime.placeholder = "Tap to set"
//        startTime.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setTimeByDatePicker(_:))))
//        startTime.addTarget(self, action: #selector(setTimeByDatePicker(_:)), for: .touchDown)
        startTime.font = UIFont.preferredFont(forTextStyle: .body)
        startTime.translatesAutoresizingMaskIntoConstraints = false
        startTime.leftAnchor.constraint(equalTo: startTimeLabel.rightAnchor, constant: 8).isActive = true
        startTime.centerYAnchor.constraint(equalTo: startTimeLabel.centerYAnchor, constant: 0).isActive = true
        startTime.widthAnchor.constraint(equalToConstant: 250).isActive = true
        startTime.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    private func setupEndTime() {
        view.addSubview(endTimeLabel)
        endTimeLabel.backgroundColor = NewActivityController.bgColorTransparent
        endTimeLabel.text = "结束时间"
        endTimeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        endTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        endTimeLabel.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 8).isActive = true
        endTimeLabel.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 8).isActive = true
        
        view.addSubview(endTime)
        endTime.delegate = self
        endTime.placeholder = "Tap to set"
        endTime.font = UIFont.preferredFont(forTextStyle: .body)
        endTime.translatesAutoresizingMaskIntoConstraints = false
        endTime.leftAnchor.constraint(equalTo: endTimeLabel.rightAnchor, constant: 8).isActive = true
        endTime.centerYAnchor.constraint(equalTo: endTimeLabel.centerYAnchor, constant: 0).isActive = true
        endTime.widthAnchor.constraint(equalToConstant: 250).isActive = true
        endTime.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func setTimeByDatePicker(_ sender: UITextField) {
        datePicker.isHidden = false
        datePicker.setDate(Date(), animated: true)
        view.endEditing(true)
        if sender == startTime {
            settingStartTime = true
            settingEndTime = false
        } else if sender == endTime {
            settingEndTime = true
            settingStartTime = false
        }
    }
    
    private func setupLocationTitleLabel() {
        view.addSubview(locationTitleLabel)
        locationTitleLabel.backgroundColor = NewActivityController.bgColorTransparent
        locationTitleLabel.text = "任务地点："
        locationTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        locationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        locationTitleLabel.topAnchor.constraint(equalTo: endTimeLabel.bottomAnchor, constant: 12).isActive = true
        locationTitleLabel.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 0).isActive = true
    }
    
    private func setupLocationTextField() {
        view.addSubview(locationTextField)
        locationTextField.delegate = self
        locationTextField.backgroundColor = NewActivityController.bgColorTransparent
        locationTextField.placeholder = "请输入任务地点"
        locationTextField.addTarget(self, action: #selector(locationUpdated), for: .editingChanged)
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.topAnchor.constraint(equalTo: locationTitleLabel.bottomAnchor, constant: 8).isActive = true
        locationTextField.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 8).isActive = true
        locationTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        searchCompleter.delegate = self
    }
    
    func locationUpdated() {
        searchCompleter.queryFragment = locationTextField.text!
    }
    
    private func setupCategoryTitleLabel() {
        view.addSubview(categoryTitleLabel)
        categoryTitleLabel.backgroundColor = NewActivityController.bgColorTransparent
        categoryTitleLabel.text = "任务类别："
        categoryTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        categoryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryTitleLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 12).isActive = true
        categoryTitleLabel.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 0).isActive = true
    }
    
    private func setupCategoryTextField() {
        view.addSubview(categoryTextField)
        categoryTextField.delegate = self
        categoryTextField.backgroundColor = NewActivityController.bgColorTransparent
        categoryTextField.placeholder = "请输入任务类别"
        categoryTextField.translatesAutoresizingMaskIntoConstraints = false
        categoryTextField.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 8).isActive = true
        categoryTextField.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 8).isActive = true
        categoryTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        categoryTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupTagTitleLabel() {
        view.addSubview(tagTitleLabel)
        tagTitleLabel.backgroundColor = NewActivityController.bgColorTransparent
        tagTitleLabel.text = "任务标签："
        tagTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        tagTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tagTitleLabel.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 12).isActive = true
        tagTitleLabel.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 0).isActive = true
    }
    
    private func setupTagTextField() {
        view.addSubview(tagTextField)
        tagTextField.delegate = self
        tagTextField.backgroundColor = NewActivityController.bgColorTransparent
        tagTextField.placeholder = "请输入任务标签"
        tagTextField.translatesAutoresizingMaskIntoConstraints = false
        tagTextField.topAnchor.constraint(equalTo: tagTitleLabel.bottomAnchor, constant: 8).isActive = true
        tagTextField.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 8).isActive = true
        tagTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tagTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupDatePicker() {
        view.addSubview(datePicker)
        datePicker.timeZone = NSTimeZone.local
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: tagTextField.bottomAnchor, constant: 12).isActive = true
        datePicker.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 0).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
        datePicker.isHidden = true
    }
    
    func datePickerChanged() {
        if settingStartTime {
            startDate = datePicker.date
        } else if settingEndTime {
            endDate = datePicker.date
        }
    }
    
    private func setupLocationSuggestionTable() {
        view.addSubview(locationSuggestTable)
        locationSuggestTable.delegate = self
        locationSuggestTable.dataSource = self
//        locationSuggestTable.backgroundColor = .blue
        locationSuggestTable.isHidden = true
        locationSuggestTable.estimatedRowHeight = 28
        locationSuggestTable.rowHeight = 28
        
        locationSuggestTable.translatesAutoresizingMaskIntoConstraints = false
        locationSuggestTable.topAnchor.constraint(equalTo: locationTextField.bottomAnchor).isActive = true
        locationSuggestTable.leftAnchor.constraint(equalTo: locationTitleLabel.leftAnchor).isActive = true
        locationSuggestTable.centerXAnchor.constraint(equalTo: locationTextField.centerXAnchor).isActive = true
        locationSuggestTable.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    func getLocation() -> String? {
        return locationTextField.text
    }
    
    func getCategories() -> String? {
        return categoryTextField.text
    }
    
    func getTags() -> String? {
        return tagTextField.text
    }
    
    func getStartingTime() -> Date? {
        return startDate
    }
    
    func getEndTime() -> Date? {
        return endDate
    }
}

extension NewActivityTimeLocationViewController {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == startTime || textField == endTime {
            setTimeByDatePicker(textField)
            return false
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        datePicker.isHidden = true
        locationSuggestTable.isHidden = true
        return true
    }
}
extension NewActivityTimeLocationViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        //
    }
}

extension NewActivityTimeLocationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationSuggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .blue
        cell.textLabel?.text = locationSuggestions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationTextField.text = locationSuggestions[indexPath.row]
        locationSuggestTable.isHidden = true
    }
    
}
