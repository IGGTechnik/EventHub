using Microsoft.EntityFrameworkCore;

namespace EventHub.GraphQL.DTO
{
    public class EventHub_DbContext : DbContext
    {
        public EventHub_DbContext (DbContextOptions<EventHub_DbContext> contextOptions) : base(contextOptions)  { }
        
        public DbSet<Event> Events { get; set; }
        public DbSet<Inventory> Inventory { get; set; }
        public DbSet<Package> Packages { get; set; }
    }
}
