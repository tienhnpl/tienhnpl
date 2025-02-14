using System;
using System.ComponentModel.DataAnnotations;

namespace Test_FinalAzure_250214.Models
{
    public class Player
    {
        [Key]
        public Guid PlayerId { get; set; } = Guid.NewGuid();

        [Required]
        public string PlayerName { get; set; }

        public string FullName { get; set; }

        public string Age { get; set; }

        public int Level { get; set; }

        public string Email { get; set; }
    }
}