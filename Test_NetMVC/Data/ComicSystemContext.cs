using Microsoft.EntityFrameworkCore;
using Test_NetMVC.Models;

namespace Test_NetMVC.Data;

public class ComicSystemContext : DbContext
{
    public DbSet<Customers> Customers { get; set; }
    public DbSet<ComicBook> ComicBooks { get; set; }
    public DbSet<Rentals> Rentals { get; set; }
    public DbSet<RentalDetails> RentalDetails { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlite("Data Source=ComicSystem.db");
    }
}