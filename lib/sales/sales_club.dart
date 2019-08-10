import '../stock_manager.dart';

class ClubSales extends StockManager{
final String item;
  ClubSales(this.item, 
  int openingstock, 
  int addedstock,
  int totalstock,
  int unitprice,
  int soldstock,
  int discount,
  int complementary,
  int spoilage,
  int closingstock,
  int totalamount) 
  : super(
    openingstock, 
    addedstock, 
    totalstock, 
    unitprice, 
    soldstock, 
    discount, 
    complementary , 
    spoilage,
    closingstock,
    totalamount);
    

    totalClubStock(){
      var _totalstock = StockManager.getTotalStock(openingstock, addedstock);
      this.totalstock = _totalstock;
      return totalstock;
    }

    
}