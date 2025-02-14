using System;
using System.ComponentModel.DataAnnotations;

namespace Test_FinalAzure_250214.Models
{
    public class PlayerAsset
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public Guid PlayerId { get; set; }

        [Required]
        public Guid AssetId { get; set; }
    }
}