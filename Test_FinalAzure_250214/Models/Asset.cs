using System;
using System.ComponentModel.DataAnnotations;

namespace Test_FinalAzure_250214.Models
{
    public class Asset
    {
        [Key]
        public Guid AssetId { get; set; } = Guid.NewGuid();

        [Required]
        public string AssetName { get; set; }

        [Required]
        public int LevelRequire { get; set; }
    }
}