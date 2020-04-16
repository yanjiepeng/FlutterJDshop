
class CheckoutService {


    static double getTotalPrice (List checkoutList) {


        double totalPrice = 0.0;
        
        for (var i = 0; i < checkoutList.length; i++) {
          

            if(checkoutList[i]['checked']) {


                totalPrice += checkoutList[i]['price'] * checkoutList[i]['count'];

            }

        }

        return totalPrice;



    }

}