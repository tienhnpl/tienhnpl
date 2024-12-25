namespace Test_NetMVC.Models;

public class Customers
{
    public int CustomerId { get; set; }
    public string FullName { get; set; }
    public string PhoneNumber { get; set; }
    public DateTime RegistrationDate { get; set; }
    
    public ICollection<Rentals> Rentals { get; set; }
}