using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Test_FinalAzure_250214.Data;
using Test_FinalAzure_250214.Models;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace BattleGameAPI.Controllers
{
    public class ReportController : Controller
    {
        private readonly BattleGameContext _context;

        public ReportController(BattleGameContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> GetAssetsByPlayer()
        {
            var query = from pa in _context.PlayerAssets
                join p in _context.Players on pa.PlayerId equals p.PlayerId
                join a in _context.Assets on pa.AssetId equals a.AssetId
                select new PlayerAssetReportDto
                {
                    PlayerName = p.PlayerName,
                    Level = p.Level,
                    Age = p.Age,
                    AssetName = a.AssetName
                };

            var result = await query.ToListAsync();
            return View(result);
        }
    }
}