//
//  ViewController.swift
//  stretchableImage
//
//  Created by 蔡尚諺 on 2022/1/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lyricTableView: UITableView!
    
    let maxHeight: CGFloat = 350.0
    let minHeight: CGFloat = 150.0
    
    var lyricData = ["夏夜裡的晚風","吹拂著妳在我懷中","妳的秀髮蓬鬆","纏繞著我隨風擺動","月亮掛在星空","牽絆著妳訴情衷","有妳味道的風","就是我還在等待的愛","一個夏夜晚風的愛","一顆寂寞的心的愛","一個還在等待的愛","不知道怎麼搞的","最近老是做這個夢","可能是我癡情","或者是我太笨","總之　夢很美　妳也很美","只是　我還在等 ","燈火閃著餘波","隨著妳的呼吸移動","妳說妳想入夢","我的臂窩有妳的夢","將妳輕輕捧起","讓妳在我耳邊細語","夏夜的風有妳","就是我還在等待的愛"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lyricTableView.delegate = self
        lyricTableView.dataSource = self
        lyricTableView.contentInset = UIEdgeInsets(top: maxHeight, left: 0, bottom: 0, right: 0)
    }
    
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lyricData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(LyricTableViewCell.self)", for: indexPath) as! LyricTableViewCell
        let lyric = lyricData[indexPath.row]
        cell.lyricLabel.text = lyric
        return cell
    }
    
    //表格捲動時觸發
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let controller = parent as? FirstViewController else { return }
        //算出滑動了多少距離
        let distance = controller.imageViewHeightConstraint.constant + scrollView.contentOffset.y
        //準備要顯示的高度 = 實際圖片高度 - 滑動距離
        var height = controller.imageViewHeightConstraint.constant - distance
        //height 不可為零
        if height < 0 {
            height = 0
        }
        /*ImageView在ContainerView下面的情境： 判斷保留高度，若不想保留高度就移除判斷，只保留
         controller.imageViewHeightConstraint.constant = height */
        //        if height >= maxHeight {
        //            controller.imageViewHeightConstraint.constant = maxHeight
        //        }else if height <= minHeight{
        //            controller.imageViewHeightConstraint.constant = minHeight
        //        }else{
        //            controller.imageViewHeightConstraint.constant = height
        //
        //        }
        
        //ImageView在ContainerView上面的情境
        controller.imageViewHeightConstraint.constant = height
        
        view.backgroundColor = UIColor(white: 0, alpha: (maxHeight - height) / maxHeight)
    }
    
}
