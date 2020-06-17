//
//  SignIn.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 30/11/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import UIKit
import Firebase

class SignIn: UIViewController {
    
    // MARK: - Private Properties
    
    /**
     Модель всех сотрудников
     */
    private var data = Company.shared
    private var oneOfUsers: User = User(info: InfoUser(), work: WorkUser())
    private var loginTextField: UITextField!
    private var passwordTextField: UITextField!
    private var mainLogo: UIImageView!
    private var authorizationButton: UIButton!
    private var backgroundView: UIView!
    private var enteryLabel: UILabel!
    
    private let logoImage = UIImage(imageLiteralResourceName: "donkomlekt.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    private let checkBoxImage = UIImage(imageLiteralResourceName: "checkBox.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let currentDateTime = Date()
//        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        formatter.dateStyle = .long
//        let greeting = formatter.string(from: currentDateTime)
//        let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
//        let beginning = greeting[..<index]
//        let newString = String(beginning)
//        print(newString)

        setupView()
        if UserDefaults.standard.bool(forKey: "firstLogIn") { } else {
            let alert = UIAlertController(title: "Политика конфиденциальности", message: "ПОЛИТИКА КОНФИДЕНЦИАЛЬНОСТИ\nДата вступления в силу: январь2015\n1. ОБЩИЕ ПОЛОЖЕНИЯ\nНастоящая Политика конфиденциальности является приложением к Условиям пользования (далее – «Условия пользования»), размещенным на Сайте, и регулирует политику и процедурные аспекты сбора, использования и распространения персональных данных через Приложение.\nДля целей настоящей Политики конфиденциальности, «персональные данные» означают информацию, которая дает возможность идентифицировать лицо, а также информация о деятельности лица, например, об использовании Приложения, если такое использование прямо связанно с информацией, позволяющей установить личность пользователя.\nВсе условия и термины, определенные Условиями пользования, применимы в настоящей Политике конфиденциальности и имеют аналогичное значение.\nИспользуя Приложение, Клиент соглашается с настоящей Политикой конфиденциальности. Регистрируя и используя аккаунт в Приложении, Клиент позволяет сбор, использование и распространение своих персональных данных в соответствии с настоящей Политикой Конфиденциальности и применимым законодательством.\n2. СБОР ПЕРСОНАЛЬНЫХ ДАННЫХ КЛИЕНТОВ\nКаждый Клиент может использовать Приложение, не раскрывая при этом своё имя или любые персональные данные; таким образом, все Клиенты, которые используют Приложение, могут оставаться анонимными, пока они не решат авторизоваться в Приложении.\nДля более комфортного использования Приложения при установке Приложения на мобильное устройство от Клиентов могут запрашиваться, например, адрес электронной почты, полное имя, дата рождения, пол, местонахождение (город), профессия, информация о семейном положении, интересах и хобби, информация для авторизации в социальных сетях, и т. п. Данная информация включается в аккаунт Клиента, с помощью которого Клиент использует Приложение.\nАккаунт Клиента в Приложении предоставляет возможность идентифицировать каждого Клиента, включая, но не ограничиваясь, с помощью профайлов в Facebook, LinkedIn. При первом входе в систему Приложения Клиент предоставляет доступ к своему аккаунту в социальных сетях. Обратите внимание! При авторизации Клиента через социальные сети Исполнитель получает доступ ко всей видимой информации, предоставляемой через аккаунт в социальных сетях, в соответствии с настройками конфиденциальности.\nКроме того, на серверах Исполнителя хранится информация о деятельности Клиента в Приложении. Более того, Исполнитель собирает и размещает, например, информацию о предоставленных или предложенных к предоставлению Консультациях и описание таких Консультаций. В состав личной информации и персональных данных может входить некоторая информация, прямо не предоставляемая Клиентами, поскольку Исполнитель также собирает информацию, связанную с доступом к Приложению.\nДополнительно, Исполнитель имеет право собирать следующую информацию:\n- сведения о мобильном устройстве Клиента (модель, версия операционной системы, уникальные идентификаторы устройства, а также данные о мобильной сети и номер телефона);\n- сведения журналов (лог-файлов), содержащих информацию об использовании Приложения или просмотре информации с помощью Приложения (включая, но не ограничиваясь подробными сведениями об использовании Приложения, включая поисковые запросы, данные о телефонных вызовах, включая номера телефонов для входящих, исходящих и переадресованных звонков, дату, время, тип и продолжительность вызовов, а также информацию о маршруте SMS, IP-адресах, данные об аппаратных событиях, в том числе о сбоях и действиях в системе, а также о настройках, типе и языке браузера, дате и времени запроса и URL перехода);\n - сведения о местоположении (включая данные GPS, отправленные мобильным устройством, данные\nnразличных технологий определения координат).\nКаждый Клиент Приложения имеет право просматривать, редактировать и удалять личную информацию и персональные данные в своем аккаунте.\n3. ИСПОЛЬЗОВАНИЕ ПЕРСОНАЛЬНЫХ ДАННЫХ\nТолько уполномоченные сотрудники Исполнителя, занимающиеся поддержкой работы Приложения, имеют доступ к персональным данным Клиентов. Такие сотрудники обязаны строго хранить конфиденциальность и предотвращать доступ третьих лиц или несанкционированный доступ к персональным данным.\nИнформация, связанная с доступом к Приложению, может использоваться Исполнителем для диагностики функционирования Приложения, а также для обеспечения высокого качества обслуживания Клиентов. Кроме того, личная информация и персональные данные могут использоваться для анализа поведения Клиентов Приложения, для оценки интереса, проявляемого в отношении различных разделов Приложения.\nЛичная информация и персональные данные Клиентов могут быть использованы Исполнителем для административных целей, например, для внутренних расследований нарушений Условий пользования и настоящей Политики конфиденциальности.\nВсе публикации, написанные Клиентами и идентифицированные ими как публичные, публикуются в Приложении в открытом доступе, подписываются именем, указанным при установке Приложения на мобильном устройстве Клиента, и доступны к просмотру всеми Клиентами Приложения.Исполнитель оставляет за собой право делиться личной информацией и персональными данными Клиентов с учредителями и руководителями Исполнителя, а также со всеми филиалами, представительствами и другими связанными с Исполнителем компаниями, но обязуется требовать от всех, кто получит доступ к данной информации, соблюдения условий настоящей Политики конфиденциальности.Общедоступные данные аккаунта Клиента в Приложении, а также сведения о действиях, которые Клиент совершает в Приложении, могут быть использованы Исполнителем в коммерческих целях, в том числе, в рекламе.Исполнитель может использовать адреса электронной почты для рассылки обновлений или новостей Приложения. При этом Клиент в любой момент может отказаться от получения таких сообщений.4. РАСПРОСТРАНЕНИЕ И РАСКРЫТИЕИНФОРМАЦИИИсполнитель не продает, не предоставляет на условиях аренды и не делится личной информацией Клиентов с третьими сторонами, за исключением деловых партнеров Исполнителя, в частности, Фондов и платежных систем, с целью повышения качествауслуг.Исполнитель предоставляет Клиентам возможность распространять информацию о других Клиентах (имя; информацию о предоставленных или предложенных к предоставлению Консультациях и их описание; раздел, в котором Консультация предоставлялась или предложена к предоставлению) через Facebook и другие социальные сети с целью популяризации Приложения.Исполнитель взаимодействует с правительством и представителями органов исполнительной власти с целью выполнения и соблюдения законодательства. Исполнитель может раскрывать персональные данные, добросовестно полагая, что он уполномочен это делать, или что такое поведение является оправданно необходимым или обоснованным для соблюдения законодательства, или судебного процесса, или требований органов государственной власти; в ответ на любые жалобы, или для защиты прав, собственности или безопасности Исполнителя, его Клиентов, сотрудников или общества, в том числе, но не ограничиваясь, от мошенничества, злоупотребления, неправильного или незаконного использования Приложения.Исполнитель может раскрыть на официальный запрос органов государственной власти информацию, необходимую для расследования, например, имя Клиента, адрес, телефон, e-mail, дату рождения и т. п.Исполнитель может раскрыть персональные данные Клиента на запрос другого Клиента, если такой Клиент не сможет получить возмещение стоимости Консультации в соответствии с Условиями пользования, с целью предоставить Клиенту возможность обращения в суд.Исполнитель предоставляет обладателям авторских прав всю необходимую информацию для контроля использования их интеллектуальной собственности всети Интернет.5. ИНФОРМАЦИОННАЯ БЕЗОПАСНОСТЬПриложение оснащено мерами обеспечения безопасности и защиты личной информации и персональных данных Клиентов от их утери, злоупотребления, несанкционированного доступа, использования, раскрытия, внесения изменений или уничтожения.Исполнитель обращает внимание на то, что ни один из существующих способов передачи данных не может быть абсолютно безопасным. Поэтому Исполнитель, не смотря на все принятые меры по обеспечению безопасности, не может гарантировать полную сохранность информации и данных.Исполнитель не несет ответственности за незаконные действия третьих лиц, хакеров, злоумышленников и прочих нарушителей применяемого законодательства, которые могут нарушать условия настоящей Политики конфиденциальности и пытаться завладеть полностью или частично личной информацией и персональными данными Клиентов, а также использовать её в личных целях.При работе с Приложением Клиенту не предоставляются права интеллектуальной собственности ни на само Приложение (кроме лицензии, указанной в Условиях пользования), ни на связанный с ним контент. Указанный контент Приложения может быть использован Клиентом только в том случае, если он получил разрешение его владельца или если такая возможность обеспечивается законодательством. Настоящая Политика конфиденциальности не предоставляет Клиентам прав на использование каких-либо различительных элементов Приложения. Клиент не должен удалять, скрывать или изменять юридические уведомления, отображаемые в Приложении.Отдельные функции Приложения позволяют Клиентам загружать, добавлять, хранить, отправлять или получать контент. При этом все права на интеллектуальную собственность в отношении таких материалов остаются у их владельца.Системы Приложения автоматически анализируют контент Клиента с целью предоставления полезной для Клиента информации. Кроме того, такой анализ помогает выявлять спам и вредоносные программы. Он выполняется во время отправки, получения и хранения контента.Наши контакты\ne-mail: mr.gavr1990@inbox.com", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Я ознакомлен(а) и согласен(а)", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "firstLogIn")
        }

        /**
         Реализация автовхода
         */
        if (UserDefaults.standard.bool(forKey: "autoSignIn")) {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            activityIndicator.frame = view.bounds
            activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.2)
            
            Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!) { (user, error) in
                if user != nil {
                    let hams = Auth.auth().currentUser?.uid
                    let base = Database.database().reference()
                    self.data.users.removeAll()
                    self.oneOfUsers.coming.removeAll()
                    self.oneOfUsers.days.removeAll()
                    self.oneOfUsers.leaving.removeAll()
                    // TODO: Вынести в отдельную функцию
                    base.observe(.value, with:  { (snapshot) in
                        guard let value = snapshot.value, snapshot.exists() else { return }
                        let dict: NSDictionary = value as! NSDictionary
                        for (company, uids) in dict {
                            for (uid, _) in uids as! NSDictionary {
                                if hams == uid as? String {
                                    UserDefaults.standard.set(company, forKey: "company")
                                }
                            }
                        }
//                        var a = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company") ?? "").\(hams).coming") as! NSDictionary //В последствии, обнаружил как взять значения без циклов, но не успеваю переписать до диплома
                       /** self.oneOfUsers.work.check = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).work.check") as? Bool
                        if hams == uid as? String {
                            UserDefaults.standard.set(dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).work.admin"), forKey: "admin")
                        }
                        self.oneOfUsers.work.admin = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).work.admin") as? Bool
                        self.oneOfUsers.info.patronymic = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).info.patronymic") as? String
                        self.oneOfUsers.work.wifi = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).work.wifi") as? String
                        self.oneOfUsers.work.monthHours = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).work.monthHours") as? Double
                        self.oneOfUsers.work.weekHours = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).work.weekHours") as? Double
                        self.oneOfUsers.work.totalHours = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).work.totalHours") as? Double
                        self.oneOfUsers.info.date = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).info.date") as? String
                        self.oneOfUsers.info.email = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).info.email") as? String
                        self.oneOfUsers.info.name = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).info.name") as? String
                        self.oneOfUsers.info.pass = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).info.pass") as? String
                        self.oneOfUsers.info.phone = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).info.phone") as? String
                        self.oneOfUsers.info.surname = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).info.surname") as? String
                         **/

                        if Calendar.current.component(.weekday, from: Date()) == 2 {
                            base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("work").updateChildValues(["weekHours": 0])
                        }
                        if Calendar.current.component(.day, from: Date()) == 1 {
                            base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("work").updateChildValues(["monthHours": 0])
                        }
                        for (company, uids) in dict {
                            if company as? String == UserDefaults.standard.string(forKey: "company") {
                                for (uid, categories) in uids as! NSDictionary {
                                    for (category, fields) in categories as! NSDictionary {
                                        if category as? String == "coming" {
                                            for (nameOfField, valueOfField) in fields as! NSDictionary {
                                                if !(self.dateNow(baseDate: nameOfField as! String)) {
                                                    base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("coming").child(nameOfField as! String).removeValue()
                                                } else {
                                                    self.oneOfUsers.days.append(nameOfField as! String)
                                                    self.oneOfUsers.coming.append(valueOfField as! String)
                                                }
                                            }
                                        }
                                        if category as? String == "leaving" {
                                            for (nameOfField, valueOfField) in fields as! NSDictionary {
                                                if !(self.dateNow(baseDate: nameOfField as! String)) {
                                                    base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("leaving").child(nameOfField as! String).removeValue()
                                                } else {
                                                    self.oneOfUsers.leaving.append(valueOfField as! String)
                                                }
                                            }
                                        }
                                        for (nameOfField, valueOfField) in fields as! NSDictionary {
                                            if nameOfField as? String == "admin" {
                                                if hams == uid as? String {
                                                    UserDefaults.standard.set(valueOfField, forKey: "admin")
                                                }
                                                self.oneOfUsers.work.admin = valueOfField as? Bool
                                                continue
                                            }
                                            if nameOfField as? String == "check" {
                                                self.oneOfUsers.work.check = valueOfField as? Bool
                                                continue
                                            }
                                            if nameOfField as? String == "patronymic" {
                                                self.oneOfUsers.info.patronymic = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "wifi" {
                                                self.oneOfUsers.work.wifi = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "monthHours" {
                                                self.oneOfUsers.work.monthHours = valueOfField as? Double
                                                continue
                                            }
                                            if nameOfField as? String == "totalHours" {
                                                self.oneOfUsers.work.totalHours = valueOfField as? Double
                                                continue
                                            }
                                            if nameOfField as? String == "weekHours" {
                                                self.oneOfUsers.work.weekHours = valueOfField as? Double
                                                continue
                                            }
                                            if nameOfField as? String == "date" {
                                                self.oneOfUsers.info.date = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "email" {
                                                self.oneOfUsers.info.email = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "name" {
                                                self.oneOfUsers.info.name = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "pass" {
                                                self.oneOfUsers.info.pass = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "phone" {
                                                self.oneOfUsers.info.phone = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "surname" {
                                                self.oneOfUsers.info.surname = valueOfField as? String
                                                continue
                                            }
                                        }
                                    }
                                    self.data.users.append(self.oneOfUsers)
                                    self.oneOfUsers.coming.removeAll()
                                    self.oneOfUsers.days.removeAll()
                                    self.oneOfUsers.leaving.removeAll()
                                }
                            }
                        }
                        activityIndicator.stopAnimating()
                        let MainScreenTabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenTabBar") as! MainScreenTabBar
                        MainScreenTabBarVC.data = self.data
                        MainScreenTabBarVC.modalPresentationStyle = .fullScreen
                        MainScreenTabBarVC.modalTransitionStyle = .flipHorizontal
                        self.present(MainScreenTabBarVC, animated: true, completion: nil)
                    })
                } else {
                    self.clearAutoLogIn()
                    activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        self.loginTextField.text = ""
//        self.passwordTextField.text = ""
//    }
    
    override func viewDidLayoutSubviews() {
        
        let screenWidth = UIScreen.main.bounds.width
        let space = screenWidth/2
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainLogo.topAnchor.constraint(equalTo: view.topAnchor,constant: space / 1.8 ),
            mainLogo.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor,constant: space / 4 ),
            mainLogo.widthAnchor.constraint(equalToConstant: space / 4),
            mainLogo.heightAnchor.constraint(equalTo: mainLogo.widthAnchor),
            loginTextField.topAnchor.constraint(equalTo: enteryLabel.bottomAnchor, constant: space / 3),
            loginTextField.leadingAnchor.constraint(equalTo: enteryLabel.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: enteryLabel.trailingAnchor, constant: -20),
            loginTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 14),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor),
            authorizationButton.bottomAnchor.constraint(equalTo: view.safeArea.bottomAnchor, constant: -25),
            authorizationButton.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            authorizationButton.widthAnchor.constraint(equalTo: enteryLabel.widthAnchor),
            authorizationButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor),
            enteryLabel.leadingAnchor.constraint(equalTo: mainLogo.leadingAnchor),
            enteryLabel.topAnchor.constraint(equalTo: mainLogo.bottomAnchor, constant: 44),
            enteryLabel.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -space/4)
        ])
    }
    
    deinit {
        loginTextField = nil
        passwordTextField = nil
        mainLogo = nil
        authorizationButton = nil
        backgroundView = nil
        enteryLabel = nil
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        
        /**
         Тап по экрану, чтобы спрятать клаву
         */
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
        
        backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        mainLogo = UIImageView(image: logoImage)
        mainLogo.translatesAutoresizingMaskIntoConstraints = false
        mainLogo.layer.cornerRadius = 5
        mainLogo.clipsToBounds = true
        view.addSubview(mainLogo)
        
        enteryLabel = UILabel()
        enteryLabel.translatesAutoresizingMaskIntoConstraints = false
        enteryLabel.layer.borderColor = UIColor.black.cgColor
        enteryLabel.text = "Добро пожаловать в MyOffice"
        enteryLabel.numberOfLines = 3
        enteryLabel.textAlignment = .center
        enteryLabel.font = UIFont.italicSystemFont(ofSize: 32)
        enteryLabel.clipsToBounds = true
        view.addSubview(enteryLabel)
        
        loginTextField = UITextField()
        loginTextField.borderStyle = .none
        loginTextField.layer.backgroundColor = UIColor.white.cgColor
        loginTextField.layer.masksToBounds = false
        loginTextField.delegate = self
        loginTextField.layer.shadowColor = UIColor.gray.cgColor
        loginTextField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        loginTextField.layer.shadowOpacity = 1.0
        loginTextField.layer.shadowRadius = 0.0
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Логин"
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Логин", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        loginTextField.autocapitalizationType = .none
        loginTextField.textAlignment = .left
        view.addSubview(loginTextField)
        
        passwordTextField = UITextField()
        passwordTextField.borderStyle = .none
        passwordTextField.layer.backgroundColor = UIColor.white.cgColor
        passwordTextField.layer.masksToBounds = false
        passwordTextField.delegate = self
        passwordTextField.layer.shadowColor = UIColor.gray.cgColor
        passwordTextField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        passwordTextField.layer.shadowOpacity = 1.0
        passwordTextField.layer.shadowRadius = 0.0
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Пароль"
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textAlignment = .left
        view.addSubview(passwordTextField)
        
        authorizationButton = UIButton()
        authorizationButton.setTitle("Авторизироваться", for: .normal)
        authorizationButton.setTitleColor(.yellow, for: .normal)
        authorizationButton.setTitleColor(.lightGray, for: .highlighted)
        authorizationButton.layer.cornerRadius = 6
        authorizationButton.backgroundColor = .blue
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        authorizationButton.addTarget(self, action:#selector(didAuthButtonTap), for: .touchUpInside)
        view.addSubview(authorizationButton)
                
    }
            
    @objc private func didAuthButtonTap() {
        if !(loginTextField.text! == "" || passwordTextField.text! == "") {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            activityIndicator.frame = view.bounds
            activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.2)
            Auth.auth().signIn(withEmail: loginTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if user != nil {
                    let hams = Auth.auth().currentUser?.uid
                    let base = Database.database().reference()
                    self.data.users.removeAll()
                    self.oneOfUsers.coming.removeAll()
                    self.oneOfUsers.days.removeAll()
                    self.oneOfUsers.leaving.removeAll()
                    // TODO: Вынести в отдельную функцию
                    base.observe(.value, with:  { (snapshot) in
                        guard let value = snapshot.value, snapshot.exists() else { return }
                        let dict: NSDictionary = value as! NSDictionary
                        for (company, uids) in dict {
                            for (uid, _) in uids as! NSDictionary {
                                if hams == uid as? String {
                                    UserDefaults.standard.set(company, forKey: "company")
                                }
                            }
                        }
                        if Calendar.current.component(.weekday, from: Date()) == 2 {
                            base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("work").updateChildValues(["weekHours": 0])
                        }
                        if Calendar.current.component(.day, from: Date()) == 1 {
                            base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("work").updateChildValues(["monthHours": 0])
                        }
                        for (company, uids) in dict {
                            if company as? String == UserDefaults.standard.string(forKey: "company")! {
                                for (uid, categories) in uids as! NSDictionary {
                                    for (category, fields) in categories as! NSDictionary {
                                        if category as? String == "coming" {
                                            for (nameOfField, valueOfField) in fields as! NSDictionary {
                                                if !(self.dateNow(baseDate: nameOfField as! String)) {
                                                    base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("comming").child(nameOfField as! String).removeValue()
                                                } else {
                                                    self.oneOfUsers.days.append(nameOfField as! String)
                                                    self.oneOfUsers.coming.append(valueOfField as! String)
                                                }
                                            }
                                        }
                                        if category as? String == "leaving" {
                                            for (nameOfField, valueOfField) in fields as! NSDictionary {
                                                if !(self.dateNow(baseDate: nameOfField as! String)) {
                                                    base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("leaving").child(nameOfField as! String).removeValue()
                                                } else {
                                                    self.oneOfUsers.leaving.append(valueOfField as! String)
                                                }
                                            }
                                        }
                                        for (nameOfField, valueOfField) in fields as! NSDictionary {
                                            if nameOfField as? String == "admin" {
                                                if hams == uid as? String {
                                                    UserDefaults.standard.set(valueOfField, forKey: "admin")
                                                }
                                                self.oneOfUsers.work.admin = valueOfField as? Bool
                                                continue
                                            }
                                            if nameOfField as? String == "check" {
                                                self.oneOfUsers.work.check = valueOfField as? Bool
                                                continue
                                            }
                                            if nameOfField as? String == "patronymic" {
                                                self.oneOfUsers.info.patronymic = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "wifi" {
                                                self.oneOfUsers.work.wifi = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "monthHours" {
                                                self.oneOfUsers.work.monthHours = valueOfField as? Double
                                                continue
                                            }
                                            if nameOfField as? String == "totalHours" {
                                                self.oneOfUsers.work.totalHours = valueOfField as? Double
                                                continue
                                            }
                                            if nameOfField as? String == "weekHours" {
                                                self.oneOfUsers.work.weekHours = valueOfField as? Double
                                                continue
                                            }
                                            if nameOfField as? String == "date" {
                                                self.oneOfUsers.info.date = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "email" {
                                                self.oneOfUsers.info.email = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "name" {
                                                self.oneOfUsers.info.name = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "pass" {
                                                self.oneOfUsers.info.pass = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "phone" {
                                                self.oneOfUsers.info.phone = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "surname" {
                                                self.oneOfUsers.info.surname = valueOfField as? String
                                                continue
                                            }
                                        }
                                    }
                                    self.data.users.append(self.oneOfUsers)
                                    self.oneOfUsers.coming.removeAll()
                                    self.oneOfUsers.days.removeAll()
                                    self.oneOfUsers.leaving.removeAll()
                                }
                            }
                        }

                        UserDefaults.standard.set(true, forKey: "autoSignIn") // Уже после того, как сделал автовход узнал про KeyChain, но также поджимают сроки написания программы
                        UserDefaults.standard.set(self.loginTextField.text?.lowercased(), forKey: "login")
                        UserDefaults.standard.set(self.passwordTextField.text, forKey: "password")
                        activityIndicator.stopAnimating()
                        let MainScreenTabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenTabBar") as! MainScreenTabBar
                        MainScreenTabBarVC.data = self.data
                        MainScreenTabBarVC.modalPresentationStyle = .fullScreen
                        MainScreenTabBarVC.modalTransitionStyle = .flipHorizontal
                        self.present(MainScreenTabBarVC, animated: true, completion: nil)
                    })
                } else {
                    self.clearAutoLogIn()
                    activityIndicator.stopAnimating()
                }
            })
        } else {
            if (loginTextField.text == "") {
                loginTextField.backgroundColor = .systemRed
                loginTextField.endEditing(true)
            }
            if (passwordTextField.text == "") {
                passwordTextField.backgroundColor = .systemRed
                passwordTextField.endEditing(true)
            }
            clearAutoLogIn()
        }
    }
    
    private func clearAutoLogIn() {
        let alert = UIAlertController(title: "Вход не удался", message: "Автовход был очищен", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        // Очистка всего UserDefaults, если вход не был выполнен
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
    
    private func dateNow(baseDate: String) -> Bool {
        var dateNow: String
        switch Calendar.current.component(.month, from: Date()) {
        case 1:
            dateNow = "\(Calendar.current.component(.day, from: Date())) january"
        case 2:
            dateNow = "\(Calendar.current.component(.day, from: Date())) february"
        case 3:
            dateNow = "\(Calendar.current.component(.day, from: Date())) march"
        case 4:
            dateNow = "\(Calendar.current.component(.day, from: Date())) april"
        case 5:
            dateNow = "\(Calendar.current.component(.day, from: Date())) may"
        case 6:
            dateNow = "\(Calendar.current.component(.day, from: Date())) june"
        case 7:
            dateNow = "\(Calendar.current.component(.day, from: Date())) july"
        case 8:
            dateNow = "\(Calendar.current.component(.day, from: Date())) august"
        case 9:
            dateNow = "\(Calendar.current.component(.day, from: Date())) september"
        case 10:
            dateNow = "\(Calendar.current.component(.day, from: Date())) october"
        case 11:
            dateNow = "\(Calendar.current.component(.day, from: Date())) november"
        case 12:
            dateNow = "\(Calendar.current.component(.day, from: Date())) december"
        default:
            dateNow = "0"
        }
        let separatedBaseDate = baseDate.components(separatedBy: [" "])
        let separatedNowDate = dateNow.components(separatedBy: [" "])

        if separatedBaseDate[1] == separatedNowDate[1] {
            if Int(separatedNowDate[0])! - Int(separatedBaseDate[0])! > 7 {
                return false
            }
        } else {
            return false
        }
        return true
        
    }
    
}

extension SignIn : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordTextField {
            passwordTextField.backgroundColor = .white
        }
        if textField == loginTextField {
            loginTextField.backgroundColor = .white
        }
    }
    
}

