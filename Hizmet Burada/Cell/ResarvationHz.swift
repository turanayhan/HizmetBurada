//
//  ResarvationItem.swift
//  Hizmet Burada
//
//  Created by turan on 25.11.2023.
//
import UIKit




class ResarvationHz: UICollectionViewCell,  UITableViewDelegate, UITableViewDataSource {
  
    

    var model: Question? {
        didSet {
            itemTitle.text = model?.question
            item.reloadData()
         
        }
    }
    var jobid : Int?
    

    
    lazy var container : UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        return container
    }()

    lazy var itemTitle:UILabel = {
        let itemTitle = UILabel()
        itemTitle.font = UIFont.boldSystemFont(ofSize: 24)
        itemTitle.textColor = .black
        itemTitle.textAlignment = .center
        itemTitle.font = UIFont(name: "Avenir", size: 18)
        return itemTitle
    }()
    
    lazy var item: UITableView = {
        let item = UITableView()
        item.separatorStyle = .none
        item.backgroundColor = .clear
        item.dataSource = self
        item.delegate = self
        item.register(ResarvationVr.self, forCellReuseIdentifier: "re")
      
        
        return item
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(container)
        container.addSubview(item)
        container.addSubview(itemTitle)
        desing()
    }
    
    func desing (){
        container.anchor(top: contentView.safeAreaLayoutGuide.topAnchor,
                         bottom: contentView.bottomAnchor,
                         leading: contentView.leadingAnchor,
                         trailing: contentView.trailingAnchor)
       
        itemTitle.anchor(top: container.safeAreaLayoutGuide.topAnchor,
                     bottom: nil,
                     leading: container.leadingAnchor,
                     trailing: container.trailingAnchor,
                      padding: .init(top: 30, left: 25, bottom: 0, right: 0),
                      size: .init(width: 0, height: 60))
    
        
        
        item.anchor(top: itemTitle.bottomAnchor,
                              bottom: container.bottomAnchor,
                              leading: container.leadingAnchor,
                              trailing: container.trailingAnchor,
                    padding: .init(top: 6, left: 25, bottom: 0, right: 25))
   
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "re", for: indexPath) as! ResarvationVr
        cell.backgroundColor = .backgroundColorWhite
        cell.question = model?.question
        cell.answer = model?.answers[indexPath.row]
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    }
