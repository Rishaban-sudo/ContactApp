//
//  ZCAPIWrapper.swift
//  ContactApp
//
//  Created by rishab-13586 on 21/12/22.
//

import Foundation
import ZCCoreFramework

struct ZCAPIWrapper {
    
    public static func fetchMyUserInfo(shouldCacheResponse: Bool, completionHandler: @escaping (Result<UserInfo>) -> Void) {
        ZCAPIService.fetchUserInfo(shouldCacheResponse: shouldCacheResponse, completionHandler: completionHandler)
    }
    
    public static func fetchRecordsFromListReport(reportInfo: ReportInfo,
                                              configuration: ListReportAPIConfiguration,
                                              preConfiguration: ReportAPIConfiguration = ReportAPIConfiguration.init(),
                                                  completionHandler: @escaping (Result<ListReport>) -> Void) {
        
        ZCReportAPIService.fetchListReport(for: reportInfo, with: configuration, completionHandler: completionHandler)
        
    }
    
    public static func fetchForm(for formInfo: FormInfo, completionHandler: @escaping (Result<WorkFlowChangeSet>) -> Void) {
        ZCFormAPIService.fetch(for: formInfo, completionHandler: completionHandler)
    }
    
    public static func submitForm(form: Form, completionHandler: @escaping (Result<SubmitResponse>) -> Void) {
        ZCFormAPIService.submit(form: form, completionHandler: completionHandler)
    }
    
    
    public static func updateRecord(withRecordId recordId: String, inReportLinkName reportLinkName: String, form: Form, completionHandler: @escaping (Result<SubmitResponse>) -> Void) {
        ZCFormAPIService.updateRecord(withRecordID: recordId, inReportLinkName: reportLinkName, form: form, completionHandler: completionHandler)
    }
    
    
    public static func deleteRecords(withRecordIds recordIds: [String], in reportInfo: ReportInfo, completionHandler: @escaping (Result<DeleteResponse>) -> Void) {
        ZCReportAPIService.deleteRecords(withRecordIDs: recordIds, in: reportInfo, completionHandler: completionHandler)
    }
    
    public static func uploadMedia(media: Data, withFileName fileName: String, for fieldAccessPath: FieldAccessPath, form: Form, completionhandler: @escaping
    (Result<FileUploadResponse>) -> Void) {
        ZCFormAPIService.upload(media: media, withFileName: fileName, for: fieldAccessPath, form: form, completionHandler: completionhandler)
    }
    
}
