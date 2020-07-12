/**
 * 
 */
package com.jarvis.common;

/**
 * @author msaugata
 *
 */
public class AllQueries {
	
	public static final String AUTHENTICATION_QUERY = "from User user where user.email= :userName and user.password = :userPassword";
	
	public static final String FIELD_VALUES_BY_APPID = "from FieldValues fv join fv.application app where app.idApplication = ?";
	
	public static final String FIELD_VALUES_BY_USERID = "from FieldValues fv join fv.application app join app.user user where user.idUser = ?";
	
	public static final String FEED_BACK_VALUES_BY_APPID = "from FieldValues where application.idApplication = ?";
	
	public static final String FEED_BACK_FORMDATA_BY_APPID = "from FeedbackForm where application.idApplication = ?";
	
public static final String BULKTXN_BATCH_INSERT_QUERY_PART1 = "set identity_insert bulkTxn on INSERT INTO bulkTxn(idBulkTxn, metadataName,";
	
	public static final String BULKTXN_BATCH_INSERT_QUERY_PART2 = "idBulkTxnFile,isSoftDeleted,amount,eftTransactionId,status,lastUpdatedBy," +
			"lastUpdatedAt) VALUES(?,?,?,?,?,?,?,?,?,";
	
	public static final String BULKTXN_BATCH_INSERT_QUERY = "INSERT INTO bulkTxn(element1,element2,element3,element4,element5,element6,element7," +
	"element8,element9,element10,element11,element12,element13,element14,element15,element16,element17," +
	"element18,element19,element20,element21,element22,element23,element24,element25,element26,element27," +
	"element28,element29,element30,element31,element32,element33,element34,element35,element36,element37," +
	"element38,element39,element40,element41,element42,element43,element44,element45,element46,element47," +
	"element48,element49,element50,element51,element52,element53,element54,element55,element56,element57," +
	"element58,element59,element60,idBulkTxnFile,isSoftDeleted) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?," +
	"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	public static final String NETTEDTXN_BATCH_INSERT_QUERY = "INSERT INTO nettedTxn(metadataName,element1,element2,element3,element4,element5,element6,element7," +
	"element8,element9,element10,element11,element12,element13,element14,element15,element16,element17," +
	"element18,element19,element20,element21,element22,element23,element24,element25,element26,element27," +
	"element28,element29,element30,element31,element32,element33,element34,element35,element36,element37," +
	"element38,element39,element40,element41,element42,element43,element44,element45,element46,element47," +
	"element48,element49,element50,element51,element52,element53,element54,element55,element56,element57," +
	"element58,element59,element60,idBulkTxnFile,isSoftDeleted,amount,eftTransactionId,status,lastUpdatedBy,lastUpdatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?," +
	"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	public static final String NETTEDTXN_BATCH_UPDATE_QUERY = "UPDATE nettedTxn set metadataName = ?, element1 = ?, element2 = ?, element3 = ?, element4 = ?, element5 = ?, element6 = ?, element7 = ?, " +
	"element8 = ?, element9 = ?, element10 = ?, element11 = ?, element12 = ?, element13 = ?, element14 = ?, element15 = ?, element16 = ?, element17 = ?, " +
	"element18 = ?, element19 = ?, element20 = ?, element21 = ?, element22 = ?, element23 = ?, element24 = ?, element25 = ?, element26 = ?, element27 = ?, " +
	"element28 = ?, element29 = ?, element30 = ?, element31 = ?, element32 = ?, element33 = ?, element34 = ?, element35 = ?, element36 = ?, element37 = ?, " +
	"element38 = ?, element39 = ?, element40 = ?, element41 = ?, element42 = ?, element43 = ?, element44 = ?, element45 = ?, element46 = ?, element47 = ?, " +
	"element48 = ?, element49 = ?, element50 = ?, element51 = ?, element52 = ?, element53 = ?, element54 = ?, element55 = ?, element56 = ?, element57 = ?, " +
	"element58 = ?, element59 = ?, element60 = ?, isSoftDeleted = ?, amount = ?, lastUpdatedBy = ?, lastUpdatedAt = ?, idBulkTxnFile = ? ";
	
	public static final String EFT_DRAFT_INSERT_QUERY_1 = "INSERT INTO eftTransactionDraftData(";
	
}
