//
//  DetailViewController.swift
//  AlamoFire_Demo
//
//  Created by Qamar Abbas on 22/02/2023.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    var data: Displayable?
    var spaceShipsList: [Displayable] = []

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var episode: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var producerName: UILabel!
    @IBOutlet weak var dateValue: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var producer: UILabel!
    @IBOutlet weak var directorName: UILabel!
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var itemList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateOutlets()

        itemList.dataSource = self
        fetchList()
        // Do any additional setup after loading the view.
    }
    
    private func initiateOutlets(){
        guard let data=data else {return}
        movieTitle.text=data.titleLabelText
        episode.text=data.subtitleLabelText
        director.text=data.item1.label
        directorName.text=data.item1.value
        producer.text=data.item2.label
        producerName.text=data.item2.value
        date.text=data.item3.label
        dateValue.text=data.item3.value
  
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return spaceShipsList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
    cell.textLabel?.text = spaceShipsList[indexPath.row].titleLabelText
    return cell
  }
}

extension DetailViewController {
  // 1
  private func fetch<T: Decodable & Displayable>(_ list: [String], of: T.Type) {
    var items: [T] = []
    // 2
    let fetchGroup = DispatchGroup()
    
    // 3
    list.forEach { (url) in
      // 4
      fetchGroup.enter()
      // 5
      AF.request(url).validate().responseDecodable(of: T.self) { (response) in
        if let value = response.value {
          items.append(value)
        }
        // 6
        fetchGroup.leave()
      }
    }
    
    fetchGroup.notify(queue: .main) {
      self.spaceShipsList = items
      self.itemList.reloadData()
    }
  }
    
    func fetchList() {
      // 1
      guard let data = data else { return }
      
      // 2
      switch data {
      case is Film:
        fetch(data.listItems, of: Starship.self)
      default:
        print("Unknown type: ", String(describing: type(of: data)))
      }
    }

}

