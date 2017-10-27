
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var MyTableView: UITableView!

    
    @IBAction func unWindSegue(segue: UIStoryboardSegue) {
//        print(segue.identifier!)
        print("back")
    }

    var name = ["John", "Steve", "Mike"]
    var desc = ["Car crash", "Sky Diving", "Butter knife"]
    var date = ["24-January-2018", "08-July-2018", "17-September-2018"]

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (name.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        cell.myName.text = name[indexPath.row]
        cell.myDesc.text = desc[indexPath.row]
        cell.myDate.text = date[indexPath.row]
        
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.name.remove(at: indexPath.row)
            MyTableView.reloadData()
        }
    }

    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
}

