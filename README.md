# UITableViewAgent

[![Version](https://img.shields.io/cocoapods/v/UITableViewAgent.svg?style=flat)](https://cocoapods.org/pods/UITableViewAgent)
[![License](https://img.shields.io/cocoapods/l/UITableViewAgent.svg?style=flat)](https://cocoapods.org/pods/UITableViewAgent)
[![Platform](https://img.shields.io/cocoapods/p/UITableViewAgent.svg?style=flat)](https://cocoapods.org/pods/UITableViewAgent)



## 示例程序

要运行示例项目，克隆仓库，并首先从`Example`目录运行' pod install '。

## 安装与使用

UITableViewAgent可以通过[CocoaPods](https://cocoapods.org)获得。安装
在你的Podfile中添加以下代码:

```ruby
pod 'UITableViewAgent'
```

> 运行条件：iOS 9.0+ (Swift 5+)

UITableViewAgent可以承担UITableViewDataSource和UITableDelegate的指责，让TableView的编码变得更加容易和充满乐趣。为什么要使用UITableViewAgent呢？请看下文。

### 使用UITableViewDataSource和UITableViewDelegate实现TableView数据呈现

让我们来看看传统的TableView编码：

* 设置tableView的代理

```Swift
tableView.dataSource = self
tableView.delegate = self    
```

* 代理回调

```Swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
        return self.news.newslist?.count ?? 0
    } else if section == 1 {
        return 1
    } else {
        return 10
    }
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
        return UITableView.automaticDimension
    } else if indexPath.section == 1 {
        return 80.0
    } else {
        return 100.0
    }
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell", for: IndexPath) as! NewsListTableViewCell
        cell.lblTitle.text = self.news.newslist![indexPath.row].title
        cell.lblSubTitle.text = self.news.newslist![indexPath.row].source
        return cell
    } else if indexPath.section == 1 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppliancesTableViewCell", for: IndexPath) as! AppliancesTableViewCell.self
        cell.lblName.text = self.appliances!.name
        cell.lblColor.text = self.appliances!.color
        cell.lblPrice.text = "\(self.appliances!.price)"
        return cell
    } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTCell.self", for: IndexPath) as! PersonTCell
        cell.lblName.text = "人物 - \(indexPath.row)"
        return cell
    }
}
```

嗯...这里实现了一个多类型Cell和多种数据的TableView列表展示，这里没有列举出Header与Footer的复用，也没有列出Cell选中某行时的回调。
类似这样的代码实现有诸多的**缺点**：

* **代码量大**：实现简单的功能需要大量代码，影响开发效率。
* **灵活性差**：配置数据和UI不够灵活，多个类的复用视图的处理需要繁琐判断，开发者需要自行计算索引值已经行数等不必要的数据。
* **可阅读性差**：为了遵守TableView的代理函数，形式上写入大量代码，却没有直观地凸显出数据和UI。

### 使用UITableViewAgent实现TableView数据呈现

#### 定制Cell数据行


```Swift
tableViewAgent = UITableViewAgent(tableView: tableView, display: UITableViewDisplay({ sections in
    sections.append(UITableViewSectionDisplay({ rows in
        for i in 0..<10 {
            rows.append(UITableViewRowDisplay(cellHeight: 60, cellType: UITableViewCell.self, reuseType: .anyClass) { tableView, indexPath, cell in
                cell.textLabel?.text = "row: _ \(i)"
            } didSelectRowAtIndexPath: {[weak self] tableView, indexPath, cell in
                guard let self = self else { return }
                let vc = TraditionalListViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            })
        }
    }))
}))
```

只需要这里少许的代码即可实现10行行高为50.0像素点,类型为`UITableViewCell`的Cell，选中某一行时，通过其中`didSelectRowAtIndexPath`回调方法实现响应的操作。
当然，功能远远不只这么简单，若需要比较复杂的需求，它的优势将体现得更加明显。

比如：
* Cell行数免计算灵活配置
* 各行Cell高度灵活配置
* 各行Cell类型与复用形式灵活配置
* 各行Cell的数据展示灵活配置
* 各行Cell点击响应事件的灵活配置


```Swift
// 添加一行Cell展示动物信息
rows.append(UITableViewRowDisplay(cellHeight: 100, cellType: PersonTCell.self, reuseType: .nib) { tableView, indexPath, cell in
    cell.name.text = "Panda"
    cell.country.text = "China"
} didSelectRowAtIndexPath: { tableView, indexPath, cell  in
    // 选中动物Cell后回调
    tableView.deselectRow(at: indexPath, animated: true)
    print("Animal is selected:", tableView, indexPath, cell)
})

// 添加若干行Cell展示人物信息
for (i, person) in persons.enumerated() {
    rows.append(UITableViewRowDisplay(cellHeight: 60, cellType: PersonCell.self, reuseType: .anyClass) { tableView, indexPath, cell in
        cell.numberLabel.text = "Number is: \(i)"
        cell.nameLabel.text = person.name
        cell.genderLabel.text = person.gender
    }
}

// 添加电器Cell展示电视信息
row.append(UITableViewRowDisplay(cellHeight: 120, cellType: AppliancesTableViewCell.self, reuseType: .nib) { tableView, indexPath, cell in
    cell.lblName.text = "TV"
} didSelectRowAtIndexPath: { tableView, indexPath, cell  in
// 选中电器Cell后回调
    tableView.deselectRow(at: indexPath, animated: true)
    print("This is a TV")
})
```

#### 定制数据组

下列是展示一个新闻相关的组：
```Swift
// 增加新闻section, header高度45，不允许自动行高(自动行高需要Cell的约束支持，即内容决定Cell高度)，header复用形式为XIB，类型为NewsListTableHeaderView
sections.append(UITableViewSectionDisplay(headerHeight: 45.0, isAutoHeaderHeight: false, headerReuse:.nib(NewsListTableHeaderView.self, { tabelView, section, header in
// 给header设置标题
    header.lblName.text = "News Header"
}), { rows in
    // row.append(XXX)
    // row.append(XXX)
}, footerHeight: 50.0, isAutoFooterHeight: false, footerReuse: .anyClass(NewsListTableFooterView.self, { tableView, section, footer in
// footer高度50，不允许自动行高，header复用形式为anyClass，类型为NewsListTableFooterView,设置文本标签展示内容
    footer.lblDesc.text = "News Footer"
})))
```

header和footer的复用参数（headerHeight和footerReuse）可以设定类型如下：

* .anyClass: 纯代码型视图，继承自UIView。
* .nib: XIB型视图，继承自UITableHeaderFooterView。
* .none: 不设定Header或Footer。


## 作者

Chen Bo（陈波）, cba023@hotmail.com

## 证书

UITableViewAgent在MIT许可下可用。查看许可文件以获得更多信息。
