namespace Test_NetMVC.Models;

public class Rentals
{
    public int RentalId { get; set; }
    public int CustomerId { get; set; }
    public DateTime RentalDate { get; set; }
    public DateTime ReturnDate { get; set; }
    public string Status { get; set; }
    
    public Customers Customers { get; set; }
    public ICollection<RentalDetails> RentalDetails { get; set; }
}