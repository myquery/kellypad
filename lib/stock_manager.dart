class StockManager {
  StockManager(
      this.openingstock,
      this.addedstock,
      this.totalstock,
      this.unitprice,
      this.soldstock,
      this.discount,
      this.complementary,
      this.spoilage,
      this.closingstock,
      this.totalamount);

  int openingstock;
  int addedstock;
  int totalstock;
  int unitprice;
  int soldstock;
  int discount;
  int complementary;
  int spoilage;
  int closingstock;
  int totalamount;

 

  static int getTotalStock(int opened, int added) {
    return opened + added;
  }

  static int getClosingStock(
      int totalstock, int soldstock, int complementary, int spoilt) {
        var closedstock = 0;
    if (complementary != 0 && spoilt != 0) {
     var closedstock = totalstock - soldstock;
    } else {
      var closedstock = totalstock - soldstock - complementary - spoilt;
    }
    return closedstock;
  }

 static int getTotalAmount(int soldstock, int unitprice) {
    return soldstock * unitprice;
  }
}
