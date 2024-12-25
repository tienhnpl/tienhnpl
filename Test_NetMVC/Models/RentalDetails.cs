namespace Test_NetMVC.Models;

public class RentalDetails
{
    public int RentalDetailId { get; set; }
    public int RentalId { get; set; }
    public int ComicBookId { get; set; }
    public Decimal PricePerDay { get; set; }
    public int Quantity { get; set; }
    
    public Rentals Rentals { get; set; }
    public ComicBook ComicBook { get; set; }
}