
class productsModel{
  final String Pname;
  final String Pprice;
  final String imageUrl;
  final String Pdescription;
  final String Pcategories;
      int Pquantity;
  final String Pid;
  productsModel({
    this.Pid,
    this.Pquantity,
      this.Pname,
      this.Pprice,
      this.imageUrl,
      this.Pcategories,
      this.Pdescription
  });
}