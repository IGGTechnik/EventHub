using graphQLBackend.DTOs;
using Microsoft.EntityFrameworkCore;

namespace graphQLBackend.Services
{
    public class EventHubDbContext : DbContext
    {
        public EventHubDbContext(DbContextOptions<EventHubDbContext> options) : base(options)
        {
        }

        public DbSet<Events> Events { get; set; }
        public DbSet<Inventory> Inventory { get; set; }
        public DbSet<Packages> Packages { get; set; }
    }
}
