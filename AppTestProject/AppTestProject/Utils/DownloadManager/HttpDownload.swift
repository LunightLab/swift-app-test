//
/* **********************************************************************
// *
// *  * Created by Kyung Shik Kim on 2021/02/08.
// *  * @file - HttpDownload.swift
// *
// *  * @brief - 간단한 설명..
// *  * @memo - 메모
// * 
// *  * Copyright (c) 2021, KB Kookmin Bank. All Rights Reserved.
// *
// *********************************************************************** */


import Foundation

protocol HttpDownloadDelegate {
    func downloadDidFinishLoading(_ download: HttpDownload?)
    func downloadDidFail(_ download: HttpDownload?)
    func downloadDidReceiveData(_ download: HttpDownload?)
}

class HttpDownload: NSObject,NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    private var downloadStream: OutputStream!
    private var connection: NSURLConnection!
    private var tempFilename: String!
    
    private var filename: String!
    private var url: URL!
    private var delegate: HttpDownloadDelegate?
    
    var downloading = false
    var expectedContentLength: Int64 = 0
    var progressContentLength: Int64 = 0
    var error: Error?
    
    
    // MARK: Public methods
    
    init (filename: String?, url: URL?, delegate: HttpDownloadDelegate) {
        self.filename = filename
        self.url = url
        self.delegate = delegate
    }
    
    func start() {
        
        downloading = true
        expectedContentLength = -1
        progressContentLength = 0

        // create the download file stream (so we can write the file as we download it

        tempFilename = pathForTemporaryFilewithPrefix(prefix: "downloads")
        downloadStream = OutputStream(toFileAtPath: self.tempFilename ?? "", append: false)
        
        if (self.downloadStream == nil) {
            self.error = NSError(domain: Bundle.main.bundleIdentifier ?? "", code: -1, userInfo: [
                "message": "Unable to create NSOutputStream",
                "function": String(utf8String: #function) ?? "",
                "path": tempFilename
            ])

            self.cleanupConnectionSuccessful(success: false)
            
            return
        }
        
        self.downloadStream?.open()
        
        let request = URLRequest(url: url!)
        if request == nil {
            error = NSError(domain: Bundle.main.bundleIdentifier ?? "", code: -1, userInfo: [
                "message": "Unable to create URL",
                "function": String(utf8String: #function) ?? "",
                "URL": self.url
            ])
            
            cleanupConnectionSuccessful(success: false)
            return
        }
        self.connection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        self.connection?.schedule(in: RunLoop.main, forMode: .common)
        self.connection?.start()
        
        if (connection == nil) {
            error = NSError(domain: Bundle.main.bundleIdentifier ?? "", code: -1, userInfo: [
                "message": "Unable to create NSURLConnection",
                "function": String(utf8String: #function) ?? "",
                "NSURLRequest": request
            ])

            cleanupConnectionSuccessful(success: false)
        }
        
        
    }
    
    func stop() {
        cleanupConnectionSuccessful(success: false)
    }
    
    // MARK: Private methods
    
    func createFolerForPath(filePath: String?) -> Bool {
        
        var error: Error?
        let fileManager = FileManager.default
        let folder = URL(fileURLWithPath: filePath ?? "").deletingLastPathComponent().path
        var isDirectory: ObjCBool = ObjCBool(false)

        if !fileManager.fileExists(atPath: folder, isDirectory: UnsafeMutablePointer<ObjCBool>(mutating: withUnsafePointer(to: &isDirectory){ $0 })) {
            // if folder doesn't exist, try to create it

            do {
                try fileManager.createDirectory(atPath: folder, withIntermediateDirectories: true, attributes: nil)
            } catch {
            }

            // if fail, report error

            if error != nil {
                //error = error
                return false
            }

            // directory successfully created

            return true
            
        }else if isDirectory.boolValue == false {
            error = NSError(domain: Bundle.main.bundleIdentifier ?? "", code: -1, userInfo: [
                "message": "Unable to create directory; file exists by that name",
                "function": String(utf8String: #function) ?? "",
                "folder": folder
            ])
            return false
        }
        
        return true
    }
    
    func cleanupConnectionSuccessful(success: Bool!) {
        
        let fileManager = FileManager.default
        var sError: Error?
        
        // clean up connection and download steam
        if let connection = self.connection {
            if !success {
                self.connection?.cancel()
            }
            self.connection = nil
        }

        if let downloadStream = self.downloadStream{
            self.downloadStream?.close()
            self.downloadStream = nil
        }
        
        self.downloading = false
        
        if success {
            if let filename = self.filename {
                
                if !createFolerForPath(filePath: filename) {
                    self.delegate?.downloadDidFail(self)
//                    (self.delegate?.downloadDidFail)(self)
                    return
                }
                if fileManager.fileExists(atPath: filename) {
                    do {
                        try fileManager.removeItem(atPath: filename)
                    } catch {
                    }
                    if error != nil {
                        sError = error
                        delegate?.downloadDidFail(self)
                        return
                    }
                }
                
                do {
                    try fileManager.copyItem(atPath: self.tempFilename!, toPath: filename)
                } catch {
                    sError = error
                }
                
                if (error != nil) {
                    self.error = sError
                    delegate?.downloadDidFail(self)
                    return
                }
                delegate? .downloadDidFinishLoading(self)
            } else { delegate?.downloadDidFail(self) }
            
        }else{
            if (tempFilename != nil) {
                if fileManager.fileExists(atPath: tempFilename ?? "") {
                    do {
                        try fileManager.removeItem(atPath: tempFilename ?? "")
                    } catch {
                    }
                }
            }
            delegate?.downloadDidFail(self)
        }
        
    }
    
    func pathForTemporaryFilewithPrefix (prefix: String?) -> String? {
        
        var result: String?
        var uuid: CFUUID?
        var uuidStr: CFString?

        uuid = CFUUIDCreate(nil)
        assert(uuid != nil)

        uuidStr = CFUUIDCreateString(nil, uuid)
        assert(uuidStr != nil)

        result = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(prefix ?? "")-\(uuidStr ?? "" as CFString)").path
        assert(result != nil)

        return result
    }
    
    //MARK: NSURLConnectionDataDelegate methods
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
        
        if response is HTTPURLResponse {
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            
            if statusCode == 200  {
                expectedContentLength = response.expectedContentLength
            }else if statusCode >= 400 {
                error = NSError(domain: Bundle.main.bundleIdentifier ?? "", code: statusCode, userInfo: [
                    "message": "bad HTTP response status code",
                    "function": String(utf8String: #function) ?? "",
                    "NSHTTPURLResponse": response
                ])
                cleanupConnectionSuccessful(success: false)
            }
        } else {
            self.expectedContentLength = -1
        }
    }
    
    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        
        let dataLength = data.count
        let dataBytes = [UInt8](data as Data) //data.withUnsafeBytes { $0.load(as: UInt32.self) }
        var bytesWritten: Int
        var bytesWrittenSoFar: Int
        
        bytesWrittenSoFar = 0
        repeat {
            bytesWritten = (downloadStream?.write(UnsafePointer<UInt8>(dataBytes), maxLength: dataLength))!
            
            assert(bytesWritten != 0)
            if bytesWritten == -1 {
                cleanupConnectionSuccessful(success: false)
                break
            } else {
                bytesWrittenSoFar += bytesWritten
            }
        } while bytesWrittenSoFar != dataLength
        
        self.progressContentLength += Int64(dataLength)
        
        if delegate.responds(to: #selector(downloadDidReceiveData(_:))) {
            delegate?.downloadDidReceiveData(self)
        }
        
    }
    
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        self.cleanupConnectionSuccessful(success: true)
    }
    
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        self.error = error
        self.cleanupConnectionSuccessful(success: false)
    }
    
}
