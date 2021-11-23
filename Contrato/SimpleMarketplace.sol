pragma solidity >=0.4.25 <0.6.0;

contract SimpleMarketplace
{
    //Se crea un estado de participacion dentro del marketplace
    enum StateType { 
      ItemAvailable,
      OfferPlaced,
      Accepted
    }
    //Se crean las instancias
    address public InstanceOwner;
    string public Description;
    int public AskingPrice;
    StateType public State;
    int public Discount;

    address public InstanceBuyer;
    int public OfferPrice;
    
    //Se maneja el constructor con los valores iniciales
    constructor(string memory description, int price) public
    {
        InstanceOwner = msg.sender;
        AskingPrice = price;
        Description = description;
        State = StateType.ItemAvailable;
        Discount = Discount;
    }
    
    /*La funcion MakeOffer me trae el 75% de descuento por el articulo que se esta vendiendo
    * Esto con el fin de que el usuario tenga una oportunidad de comprarlo si se le hace un descuento
    */
   
    /*  Funcion Eval
    *   Se maneja para comparar el precio de la oferta, con el del descuento por parte del usuario
    *   Si el descuento es correcto, permite aceptar la oferta, caso contrario manda error en el sistema
    */  
    function Eval()public{
        if(Discount == OfferPrice){
            revert();
        } else if(Discount <= OfferPrice){
           State = StateType.Accepted;
        } else if(Discount >= OfferPrice){
           revert();
        }
            
    }
    
     function MakeOffer(int offerPrice) public
    {
        
        Discount = ((offerPrice * 75) / 100);
        
        //Inclusión revertida para hacer el nuevo espacio creado por JSMartinez
        /*if (offerPrice == 0)
        {
            revert();
        }*/

        /*if (State != StateType.ItemAvailable)
        {
            revert();
        }
        */
        /*if (InstanceOwner == msg.sender)
        {
            revert();
        }*/

        //Genera el campo completado
        InstanceBuyer = msg.sender;
        OfferPrice = offerPrice;
        State = StateType.Accepted;
    }
    
    //Funcion para rechazar la entrega y salir del programa
    function Reject() public
    {
        if ( State != StateType.OfferPlaced )
        {
            revert();
        }

        if (InstanceOwner != msg.sender)
        {
            revert();
        }

        InstanceBuyer = 0x0000000000000000000000000000000000000000;
        State = StateType.ItemAvailable;
    }
    //Funcion aceptar la oferta para terminar la ejecución del programa
    function AcceptOffer() public
    {
        if ( msg.sender != InstanceOwner )
        {
            revert();
        }

        State = StateType.Accepted;
    }
}
