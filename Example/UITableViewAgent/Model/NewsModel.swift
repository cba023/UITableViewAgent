//
//  NewsModel.swift
//  CBTableViewSecretSwifty
//
//  Created by flowerflower on 2019/1/19.
//  Copyright © 2019 Creater. All rights reserved.
//

import UIKit

struct Ext_action :Codable {
    var fimgurl30: String?
    var fimgurl33: String?
    var fimgurl32: String?
    
}

struct Ext_data :Codable {
    var src: String?
    var desc: String?
    var ext_action: Ext_action?
    
}

struct Newslist :Codable {
    var ext_data: Ext_data?
    var source: String?
    var time: String?
    var title: String?
    var url: String?
    var videoTotalTime: String?
    var thumbnails_qqnews: [String]?
    var abstract: String?
    var imagecount: Int = 0
    var origUrl: String?
    var graphicLiveID: String?
    var uinnick: String?
    var flag: String?
    var tag: [String]?
    var voteId: String?
    var articletype: String?
    var voteNum: String?
    var qishu: String?
    var id: String?
    var timestamp: Int = 0
    var commentid: String?
    var comments: Int = 0
    var weiboid: String?
    var comment: String?
    var uinname: String?
    var surl: String?
    var thumbnails: [String]?
    
}

class NewsModel :Codable {
    var ret: Int = 0
    var newslist: [Newslist]?
}

