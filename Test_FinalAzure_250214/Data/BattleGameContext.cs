using Microsoft.EntityFrameworkCore;
using Test_FinalAzure_250214.Models;

namespace Test_FinalAzure_250214.Data
{
    public class BattleGameContext : DbContext
    {
        public BattleGameContext(DbContextOptions<BattleGameContext> options) : base(options) { }

        public DbSet<Player> Players { get; set; }
        
        public DbSet<Asset> Assets { get; set; }
        
        public DbSet<PlayerAsset> PlayerAssets { get; set; }


    }
}