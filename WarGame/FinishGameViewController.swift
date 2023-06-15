

import UIKit


class FinishGameViewController: UIViewController {
    
    var winnerScore: String?
    var winnerName: String?
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var name: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        score.text=winnerScore
        name.text=winnerName

    }
}
