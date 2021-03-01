////
///* **********************************************************************
//// *
//// *  * Created by Kyung Shik Kim on 2021/02/08.
//// *  * @file - HttpDownloadManager.swift
//// *
//// *  * @brief - 간단한 설명..
//// *  * @memo - 메모
//// * 
//// *  * Copyright (c) 2021, KB Kookmin Bank. All Rights Reserved.
//// *
//// *********************************************************************** */
//
//
//import Foundation
//protocol HttpDownloadManagerDelegate {
//    func didFinishLoadingAllForManager(_ downloadManager: HttpDownloadManager?)
//    func downloadManager(_ downloadManager: HttpDownloadManager?, downloadDidFinishLoading download: HttpDownload?)
//    func downloadManager(_ downloadManager: HttpDownloadManager?, downloadDidFail download: HttpDownload?)
//    func downloadManager(_ downloadManager: HttpDownloadManager?, downloadDidReceiveData download: HttpDownload?)
//}
//
//class HttpDownloadManager: NSObject, HttpDownloadManagerDelegate, HttpDownloadDelegate {
//    
//    var maxConcurrentDownloads = 0
//    var downloads: [AnyHashable]?
//    weak var delegate: HttpDownloadManagerDelegate?
//    var cancelAllInProgress: Bool?
//
//    
//    //MARK: HttpDownloadManager public methods
//    
//    /// class init
//    override init() {
//        downloads = [AnyHashable]()
//        maxConcurrentDownloads = 4
//        cancelAllInProgress = false
//    }
//
//    
//    /// convenience init
//    /// - Parameter delegate: HttpDownloadManagerDelegate
//    convenience init(delegate: HttpDownloadManagerDelegate?) {
//        self.init()
//            self.delegate = delegate
//    }
//    
//    /// 다운로드 URL 추가.
//    /// - Parameters:
//    ///   - filename: 경로 string값
//    ///   - url: 다운로드 url
//    func addDownloadwithFilename (filename: String?, url: URL?) {
//        guard let name = filename, let host = url else { return }
//        let download = HttpDownload(filename: name, url: host, delegate: self)
//        self.downloads?.append(download)
//        start()
//    }
//    
//    
//    /// Download request
//    func start() {
//        self.tryDownloading()
//    }
//    
//    /// 모든 작업을 취소한다.
//    func cancelAll() {
//        self.cancelAllInProgress = true
//        self.downloads?.removeAll()
//        self.cancelAllInProgress = false
//        self.informDelegateThatDownloadsAreDone()
//    }
//    
//    //MARK: HttpDownloadDelegate Methods
//    
//    func didFinishLoadingAllForManager(_ downloadManager: HttpDownloadManager?) {
//        self.downloads?.removeAll { ($0 as AnyObject) as? NSObject == downloadManager }
//
//        if self.delegate.responds(to: #selector(downloadManager(_:downloadDidFinishLoading:)) {
//            delegate.downloadManager(self, downloadDidFinishLoading: downloadManager)
//        }
//        tryDownloading()
//    }
//    
//    func downloadManager(_ downloadManager: HttpDownloadManager?, downloadDidFinishLoading download: HttpDownload?) {
//        <#code#>
//    }
//    
//    func downloadManager(_ downloadManager: HttpDownloadManager?, downloadDidFail download: HttpDownload?) {
//        <#code#>
//    }
//    
//    func downloadManager(_ downloadManager: HttpDownloadManager?, downloadDidReceiveData download: HttpDownload?) {
//        <#code#>
//    }
//    
//    func downloadDidFail(_ download: HttpDownload?) {
//        
//        downloads.removeAll { $0 as AnyObject === download as AnyObject }
//
//        if delegate.responds(to: #selector(downloadManager(_:downloadDidFail:))) {
//            delegate.downloadManager(self, downloadDidFail: download)
//        }
//
//        if !cancelAllInProgress {
//            tryDownloading()
//        }
//    }
//
//    func downloadDidReceiveData(_ download: HttpDownload?) {
//        if delegate.responds(to: #selector(downloadManager(_:downloadDidReceiveData:))) {
//            delegate.downloadManager(self, downloadDidReceiveData: download)
//        }
//    }
//    
//    
//    //MARK: Private methods
//    func informDelegateThatDownloadsAreDone() {
//        if delegate.responds(to: #selector(didFinishLoadingAll(forManager:))) {
//            delegate.didFinishLoadingAll(forManager: self)
//        }
//    }
//    
//    func tryDownloading() {
//        let totalDownloads = downloads?.count
//        
//        if totalDownloads == 0 {
//            informDelegateThatDownloadsAreDone()
//            return
//        }
//        while (countUnstartedDownloads() > 0) && countActiveDownloads() < maxConcurrentDownloads {
//            for (HttpDownload) downloads in self.downloads {
//                
//            }
//        }
//    }
//    
//    func countUnstartedDownloads() -> Int {
//        return self.downloads!.count - countActiveDownloads()
//    }
//    
//    func countActiveDownloads() -> Int {
//        
//        let activeDownloadCount = 0
//
//        for download in self.downloads {
//            if download.isDownloading {
//                activeDownloadCount += 1
//            }
//        }
//
//        return activeDownloadCount
//    }
//    
//    
//    //MARK: Static methods
//    
//    /// 주어진 폴더안에 있는 파일들을 얻는다.
//    class func findFilesinPath (path: String?) -> [AnyHashable]? {
//        
//        var matches: [String] = []
//        let fManager = FileManager.default
//        var contents: [String]?
//        
//        do {
//            contents = try fManager.contentsOfDirectory(atPath: path ?? "")
//        } catch {
//            
//        }
//
//        for item in contents ?? [] {
//            matches.append(item)
//        }
//        return matches
//    }
//    
//    /// 주어진 폴더를 삭제한다.
//    class func deleteFolder(_ path: String?) -> Bool {
//        
//        let fManager = FileManager.default
//        var derror: Error? = nil
//        var success = false
//        
//        do {
//            try fManager.removeItem(atPath: path ?? "")
//            success = true
//        } catch {
//            derror = error
//            success = false
//        }
//
//        return success
//        
//    }
//    
//    /// aArray와 bArray의 파일 리스트를 비교해서 누락되거나 틀린 파일이 있는지 알아본다.
//    class func compareFilesA(_ aArray: [String]?, toB bArray: [String]?) -> Bool {
//        
//        var isSame = true
//        
//        if (aArray?.count ?? 0) != (bArray?.count ?? 0) {
//            return false
//        }
//        if ((aArray?.count ?? 0) == 0) || ((bArray?.count ?? 0) == 0) {
//            return false
//        }
//    
//        let aSortedArray = aArray?.sorted()
//        let bSortedArray = bArray?.sorted()
//        
////        let aSortedArray = aArray.sortedArray(using: #selector(String.localizedCaseInsensitiveCompare(_:)))
////        let bSortedArray = aArray.sortedArray(using: #selector(String.localizedCaseInsensitiveCompare(_:)))
//    
//        let aSet = Set(arrayLiteral: aSortedArray)
//        let bSet = Set(arrayLiteral: bSortedArray)
//        
//        if aSet.isDisjoint(with: bSet) {
//            isSame = false
//        }
//
//        return isSame
//    }
//    
//}
