using Microsoft.AspNetCore.Mvc;
using Test_FinalAzure_250214.Data;
using Test_FinalAzure_250214.Models;
using System.Threading.Tasks;

namespace BattleGameAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PlayerController : ControllerBase
    {
        private readonly BattleGameContext _context;

        public PlayerController(BattleGameContext context)
        {
            _context = context;
        }

        [HttpPost("registerplayer")]
        public async Task<IActionResult> RegisterPlayer(Player player)
        {
            _context.Players.Add(player);
            await _context.SaveChangesAsync();
            return Ok(new { message = "Player registered successfully!", PlayerId = player.PlayerId });
        }
    }
}