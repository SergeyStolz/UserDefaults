//
//  ViewController.swift
//  UserDefaults
//
//  Created by mac on 04.10.2021.
//

import UIKit

class UserDefaultsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Properties
    let sexArray = ["Мужской", "Женский"]
    let cities = ["Ростов-на-Дону", "Сочи",
                  "Омск", "Воронеж", "Москва",
                  "Орел", "Санкт-Петербург",
                  "Курск", "Петрозаводск"]
    var pickerCity: String?
    var pickerCityRow: Int?
    var sexIndex: Int?
    var sex: SexType?
    
    // MARK: - Views
    private lazy var nameUserLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var surnameUserLabel: UILabel = {
        let label = UILabel()
        label.text = "Surname"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sexUserLabel: UILabel = {
        let label = UILabel()
        label.text = "Sex"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityUserLabel: UILabel = {
        let label = UILabel()
        label.text = "Cities"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = " Enter your name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var surnameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = " Enter your surname"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var cityPickerView: UIPickerView = {
        let cityPickerView = UIPickerView()
        cityPickerView.translatesAutoresizingMaskIntoConstraints = false
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        return cityPickerView
    }()
    
    private lazy var sexSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: sexArray)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 1
        return segmentedControl
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationController()
        
        nameTextField.text = UserSettings.userModel.name
        surnameTextField.text = UserSettings.userModel.surname
        sexSegmentedControl.selectedSegmentIndex = UserSettings.userModel.sexIndex
        cityPickerView.selectRow(UserSettings.userModel.pickerCityRow,
                                 inComponent: 0,
                                 animated: false
        )
    }
    
    private func setupNavigationController() {
        title = "Registration"
        let rightButtonItem = UIBarButtonItem.init(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(rightButtonAction(sender:))
        )
        navigationItem.rightBarButtonItem = rightButtonItem
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)]
    }
    
    @objc private func rightButtonAction(sender: UIBarButtonItem) {
        
        let nameTrimmingText = nameTextField.text!.trimmingCharacters(in: .whitespaces)
        let surnameTrimmingText = surnameTextField.text!.trimmingCharacters(in: .whitespaces)
        print(nameTrimmingText)
        
        guard let pickerCity = pickerCity,
              let pickerCityRow = pickerCityRow,
              let sex = sex,
              let sexIndex = sexIndex
        else { return }
        
        let userObject = UserModel(name: nameTrimmingText,
                                   surname: surnameTrimmingText,
                                   city: pickerCity,
                                   pickerCityRow: pickerCityRow,
                                   sex: sex,
                                   sexIndex: sexIndex
        )
        UserSettings.userModel = userObject
    }
    
    @objc private func segmentAction(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            sex = .male
        case 1:
            sex = .female
        default:
            break
        }
        sexIndex = segmentedControl.selectedSegmentIndex
    }
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(nameUserLabel)
        view.addSubview(surnameUserLabel)
        view.addSubview(cityUserLabel)
        view.addSubview(sexUserLabel)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(cityPickerView)
        view.addSubview(sexSegmentedControl)
        
        NSLayoutConstraint.activate([
            nameUserLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -245),
            nameUserLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameUserLabel.widthAnchor.constraint(equalToConstant: 340),
            nameUserLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -205),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 350),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            surnameUserLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -145),
            surnameUserLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            surnameUserLabel.widthAnchor.constraint(equalToConstant: 340),
            surnameUserLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            surnameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -105),
            surnameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            surnameTextField.widthAnchor.constraint(equalToConstant: 350),
            surnameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            sexUserLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            sexUserLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sexUserLabel.widthAnchor.constraint(equalToConstant: 340),
            sexUserLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            sexSegmentedControl.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -5),
            sexSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sexSegmentedControl.widthAnchor.constraint(equalToConstant: 350),
            sexSegmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            cityUserLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 55),
            cityUserLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityUserLabel.widthAnchor.constraint(equalToConstant: 340),
            cityUserLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            cityPickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            cityPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityPickerView.widthAnchor.constraint(equalToConstant: 370),
            cityPickerView.heightAnchor.constraint(equalToConstant: 350)
        ])
        view.backgroundColor = .systemGroupedBackground
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let city = cities[row]
        return city
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerCity = cities[row]
        pickerCityRow = row
    }
}


