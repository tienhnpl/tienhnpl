using Microsoft.AspNetCore.Mvc;
using Test_FinalAzure_250214.Data;
using Test_FinalAzure_250214.Models;
using System.Threading.Tasks;

namespace BattleGameAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AssetController : ControllerBase
    {
        private readonly BattleGameContext _context;

        public AssetController(BattleGameContext context)
        {
            _context = context;
        }

        [HttpPost("createasset")]
        public async Task<IActionResult> CreateAsset(Asset asset)
        {
            _context.Assets.Add(asset);
            await _context.SaveChangesAsync();
            return Ok(new { message = "Asset created successfully!", AssetId = asset.AssetId });
        }
    }
}