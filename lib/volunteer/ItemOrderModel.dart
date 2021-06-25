class ItemOrderModel {
  String Did;
  int   TotalPrice;
  String donater_Email;
  String TakenBy;


  ItemOrderModel
  ({
    this.TakenBy,
    this.Did,
    this.TotalPrice,
    this.donater_Email,
  });
}