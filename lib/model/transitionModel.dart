class Transition {
  String memo;
  String memobytes;
  String id;
  String pagingtoken;
  bool success;
  String hash;
  int ledger;
  String created;
  String sourceAcc;
  String sourceAccSeq;
  String feeAcc;
  String feeCharge;
  String maxfee;
  int operationCount;
  String envelopXDR;
  String resultXDR;
  String feeMetaXDR;
  String memoType;
  Transition({
    this.memo,
    this.memobytes,
    this.id,
    this.pagingtoken,
    this.success,
    this.hash,
    this.ledger,
    this.created,
    this.sourceAcc,
    this.sourceAccSeq,
    this.feeAcc,
    this.feeCharge,
    this.maxfee,
    this.operationCount,
    this.envelopXDR,
    this.resultXDR,
    this.feeMetaXDR,
    this.memoType,
  });

  Transition.fromJson(Map<String, dynamic> json)
      : memo = json['memo'],
        memobytes = json['memo_bytes'],
        id = json['id'],
        pagingtoken = json['paging_token'],
        success = json['successful'],
        hash = json['hash'],
        ledger = json['ledger'],
        created = json['created_at'],
        sourceAcc = json['source_account'],
        sourceAccSeq = json['source_account_sequence'],
        feeAcc = json['fee_account'],
        feeCharge = json['fee_charged'],
        maxfee = json['max_fee'],
        operationCount = json['operation_count'],
        envelopXDR = json['envelope_xdr'],
        resultXDR = json['reult_xdr'],
        feeMetaXDR = json['fee_meta_xdr'],
        memoType = json['memo_type'];
}
